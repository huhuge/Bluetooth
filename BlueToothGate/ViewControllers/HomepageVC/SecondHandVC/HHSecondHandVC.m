//
//  HHSecondHandVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/26.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHSecondHandVC.h"
#import "HHSecondHandCell.h"
#import "HHPublicGoodsVC.h"
#import "HHGoodsDetailVC.h"
#import "HHSecondHandModel.h"


@interface HHSecondHandVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_dataArray;
    ///选择小区
    NSMutableArray *_comminutiesArray;
    ///新旧程度
    NSMutableArray *_newDegreeArray;
    
    ///页码
    int _pageNum;
    ///加载下一页标志
    BOOL _isLoadNext;
    ///刷新标志
    BOOL _isReLoad;
    ///是否租房
    BOOL _isHouse;
    ///默认小区信息
    NSDictionary *_defaultCommunityInfo;
    ///区列表
    NSMutableArray *_areaArray;
    NSMutableArray *_areaNameArray;
    ///小区列表
    NSMutableArray *_communityNameArray;
    ///小区ID
    NSString *_residentialInfoId;
    ///新旧
    NSString *_newDegree;
    ///产品分类名列表
    NSMutableArray *_typeIDarray;
    NSMutableArray *_typeNameArray;
    NSString *_currentTypeID;

}

@end

@implementation HHSecondHandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self setUI];
    
    [self initTabView];
    
    [self initMJRefresh];
    
    [self getTypeList];
}

#pragma mark ---初始化刷新控件
- (void)initMJRefresh
{
    ///下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadShowsPage)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    ///上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNextShowsPage)];
    [_tableView.mj_header beginRefreshing];
}

#pragma mark ---刷新
- (void)reloadShowsPage
{
    _pageNum = 0;
    _isReLoad = YES;
    
    [self getGoodsListWithType:_isHouse];
}

#pragma mark ---加载下一页
- (void)loadNextShowsPage
{
    _isLoadNext = YES;
    _isReLoad=NO;
    
    [self getGoodsListWithType:_isHouse];
}

#pragma mark ---隐藏列表加载头或脚
- (void)hideTableViewHeaderOrFooter
{
    if (_isLoadNext) {
        _isLoadNext = NO;
        [self.tableView.mj_footer endRefreshing];
        
    }else if(_isReLoad){
        _isReLoad = NO;
        [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        [self.tableView.mj_header endRefreshing];
    }
}

#pragma mark ---获取类型列表---======================================
- (void)getTypeList{
    NSDictionary *dic = [NSDictionary new];
    [[HYHttp sharedHYHttp]POST:SecondHandGoodsTypeUrl parameters:dic success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"]integerValue] == 1) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows =  [obj objectForKey:@"rows"];
            for (NSDictionary *dic in rows) {
                [_typeIDarray addObject:[dic objectForKey:@"id"]];
                [_typeNameArray addObject:[dic objectForKey:@"className"]];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark --获取物品列表---======================================
- (void)getGoodsListWithType:(BOOL)isHouse{
    
    NSString *urlString = isHouse?HouseLeaseListUrl:SecondHandListUrl;
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:_residentialInfoId forKey:@"residentialInfoId"];
    if (_currentTypeID.length && !_isHouse) {
        [param setObject:_currentTypeID forKey:@"goodsId"];
    }
    if (!_isHouse && _newDegree.length) {
        [param setObject:_newDegree forKey:@"oldAndNew"];
    }
    if (_isHouse && _currentTypeID.length) {
        [param setObject:_currentTypeID forKey:@"type"];
    }
    
    [param setObject:[NSString stringWithFormat:@"%d",_pageNum] forKey:@"currentPage"];
    
    [[HYHttp sharedHYHttp]POST:urlString parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"]integerValue] == 1) {
            
            if (_isReLoad) {
                [_dataArray removeAllObjects];
            }
            _pageNum++;

            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows = [obj objectForKey:@"rows"];
            
            if (rows.count == 0) {
                [ShowMessage showTextOnly:@"没有更多数据" messageView:self.view];
            }
            
            for (NSDictionary *dic in rows) {
                HHSecondHandModel *model = [HHSecondHandModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
            
        }
        [self hideTableViewHeaderOrFooter];

    } failure:^(NSError * _Nonnull error) {
        [self hideTableViewHeaderOrFooter];

        
    }];
}

#pragma mark ---setData---======================================
- (void)setData{
    _dataArray          = [NSMutableArray new];
    _comminutiesArray   = [NSMutableArray new];
    _areaArray          = [NSMutableArray new];
    _areaNameArray      = [NSMutableArray new];
    _communityNameArray = [NSMutableArray new];
    _typeIDarray        = [NSMutableArray new];
    _typeNameArray      = [NSMutableArray new];
    _newDegreeArray     = [[NSMutableArray alloc]initWithObjects:@"全新",@"9成新",@"8成新",@"7成新",@"6成新",@"5成新",@"4成新",@"3成新",@"2成新",@"1成新", nil];
    _defaultCommunityInfo = [[NSUserDefaults standardUserDefaults] dictionaryForKey:HHUser_info_selectedCommunity_dic];
    _labCommunity.text = [_defaultCommunityInfo objectForKey:@"residentialName"];
    _residentialInfoId = [_defaultCommunityInfo objectForKey:@"residentialInfoId"];
    [self getAddressWithParentId:[_defaultCommunityInfo objectForKey:@"residentialInfoId"]];
}

#pragma mark ---setUI---======================================
- (void)setUI{
    
    _lineOne_x.constant = ScreenW/3;
    _lineTwo_x.constant = ScreenW/3 * 2;
    
}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHSecondHandCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    //    return _dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  227;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHSecondHandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHSecondHandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }
    
    HHSecondHandModel *model = [_dataArray objectAtIndex:indexPath.section];
    [cell setCellDataWithModel:model];
    cell.goodView.hidden =  _isHouse;
    cell.roomView.hidden = !_isHouse;
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.section);
    HHSecondHandModel *model = [_dataArray objectAtIndex:indexPath.section];
    HHGoodsDetailVC *nextVC  = [HHGoodsDetailVC new];
    nextVC.model             = model;
    nextVC.isHouse           = _isHouse;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ---发布---=====================================
- (IBAction)publicAction:(UIButton *)sender {
    HHPublicGoodsVC *nextVC = [HHPublicGoodsVC new];
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ---change Seg---=====================================
- (IBAction)selectMessageType:(UISegmentedControl *)sender {
    kLog(@"----%ld",(long)_topSeg.selectedSegmentIndex);
    
    _isHouse = _topSeg.selectedSegmentIndex;
    _pageNum = 0;
    [_tableView scrollsToTop];
    [_tableView.mj_header beginRefreshing];
    _labProduct.text   = @"产品分类";
    _currentTypeID     = @"";
    _labNewDegree.text = @"新旧程度";
    _newDegree         = @"";
    
}

#pragma mark ---Community ---=====================================
- (IBAction)selectCommunity:(UIButton *)sender {
    _alertView.hidden = NO;
    _coverView.hidden = NO;
    
}

#pragma mark ---弹出框相关 ---=====================================
- (IBAction)selectCity:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( 55, 180, ScreenW/3, 200) selectData:_areaNameArray action:^(NSInteger index) {
        _labQu.text = _areaNameArray[index];
        NSDictionary *dic = _areaArray[index];
        [self getCommunityWithID:[dic objectForKey:@"id"]];
        
    } animated:YES];
}
- (IBAction)xiaoqu:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( 200, 180, ScreenW/3+30, 100) selectData:_communityNameArray action:^(NSInteger index) {
        _labXiaoqu.text = _communityNameArray[index];
        NSDictionary *dic = _comminutiesArray[index];
        _residentialInfoId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    } animated:YES];
}
- (IBAction)ensureAction:(UIButton *)sender {
    _labCommunity.text = _labXiaoqu.text;
    _alertView.hidden = YES;
    _coverView.hidden = YES;
    [_tableView.mj_header beginRefreshing];
}
- (IBAction)cancelAction:(UIButton *)sender {
    _alertView.hidden = YES;
    _coverView.hidden = YES;

}

#pragma mark ---请求地址省市区---======================================
- (void)getAddressWithParentId:(NSString *)parentID{
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[_defaultCommunityInfo objectForKey:@"parentTow_id"] forKey:@"parentId"];
    
    [[HYHttp sharedHYHttp] POST:GetAddressLinkUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows = [obj objectForKey:@"rows"];
            kLog(@"%@",rows);
            for (NSDictionary *dic in rows) {
                [_areaArray addObject:dic];
                [_areaNameArray addObject:[dic objectForKey:@"areaName"]];
            }
            
        }
    } failure:^(NSError * _Nonnull error) {
        kLog(@"fail");
    }];
    
}

#pragma mark ---获取小区---======================================
- (void)getCommunityWithID:(NSString *)IDString{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:IDString forKey:@"areaInfo"];
    [[HYHttp sharedHYHttp]POST:GetCommunityListUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            
            [_communityNameArray removeAllObjects];
            [_comminutiesArray removeAllObjects];
            
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows = [obj objectForKey:@"rows"];
            kLog(@"%@",rows);
            for (NSDictionary *dic in rows) {
                [_comminutiesArray addObject:dic];
                [_communityNameArray addObject:[dic objectForKey:@"residentialName"]];
                
            }
        }
    } failure:^(NSError * _Nonnull error) {
        kLog(@"error");
    }];
}


#pragma mark --- product---=====================================
- (IBAction)productType:(UIButton *)sender {
    if (!_typeIDarray.count) {
        [ShowMessage showTextOnly:@"无可选产品分类" messageView:self.view];
        return;
    }
    if (_isHouse) {
        [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( ScreenW/3, 100, ScreenW/3, 100) selectData:@[@"出租",@"出售"] action:^(NSInteger index) {
            _labProduct.text = @[@"出租",@"出售"][index];
            _currentTypeID   = @[@"0",@"1"][index];
            [_tableView.mj_header beginRefreshing];
        } animated:YES];
    }else{
        [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( ScreenW/3, 100, ScreenW/3, 100) selectData:_typeNameArray action:^(NSInteger index) {
            _labProduct.text = _typeNameArray[index];
            _currentTypeID   = [NSString stringWithFormat:@"%@",_typeIDarray[index]];
            [_tableView.mj_header beginRefreshing];
        } animated:YES];

    }
}

#pragma mark ---newDegree ---=====================================
- (IBAction)newDegree:(UIButton *)sender {
    if (!_newDegreeArray.count||_isHouse) {
        [ShowMessage showTextOnly:@"无法选择新旧程度" messageView:self.view];
        return;
    }
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( ScreenW/3*2, 100, ScreenW/3, 100) selectData:_newDegreeArray action:^(NSInteger index) {
        _labNewDegree.text = _newDegreeArray[index];
        _newDegree = [NSString stringWithFormat:@"%ld",10-index];
        [_tableView.mj_header beginRefreshing];
    } animated:YES];
}


- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
