//
//  HHNoticeVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/22.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHNoticeVC.h"
#import "HHNoticeCell.h"
#import "HHNoticeDetailVC.h"
#import "HHNoticeModel.h"

@interface HHNoticeVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_dataArray;
    int _pageNum;
    ///加载下一页标志
    BOOL _isLoadNext;
    ///刷新标志
    BOOL _isReLoad;
    
    BOOL _isNews;

}

@end

@implementation HHNoticeVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setData];
    
    [self initTabView];
    
//    [self getListWithType:NO];
    
    [self initMJRefresh];
    
}

#pragma mark ---Data---======================================
- (void)setData{
    
    _dataArray = [NSMutableArray new];
    
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
    
    [self getListWithType:_isNews];
}

#pragma mark ---加载下一页
- (void)loadNextShowsPage
{
    _isLoadNext = YES;
    _isReLoad=NO;
    
    [self getListWithType:_isNews];
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


#pragma mark ---获取数据---======================================
- (void)getListWithType:(BOOL)isNews{
    NSString *urlStr;
    if (!isNews) {
        urlStr = CommunityNoticeListUrl;
    }else{
        urlStr = ResidentialBulletinListUrl;
    }
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[NSString stringWithFormat:@"%d",_pageNum] forKey:@"currentPage"];
    [param setObject:@"36" forKey:@"residentialInfoId"];
    [[HYHttp sharedHYHttp]POST:urlStr parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1){
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
                HHNoticeModel *model = [HHNoticeModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArray addObject:model];
            }
            
//            if (kArrayIsEmpty(_dataArray)) {
//                kLog(@"empty");
//            }
            
            [_tableView reloadData];
        }
        [self hideTableViewHeaderOrFooter];
    } failure:^(NSError * _Nonnull error) {
        [self hideTableViewHeaderOrFooter];

        
    }];
}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHNoticeCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  78;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHNoticeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }
    
    HHNoticeModel *model = [_dataArray objectAtIndex:indexPath.row];
    [cell setCellDataWithModel:model];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.row);
    HHNoticeModel *model     = _dataArray[indexPath.row];
    HHNoticeDetailVC *nextVC = [HHNoticeDetailVC new];
    nextVC.titleStr          = model.title;
    nextVC.timeStr           = model.addTime;
    nextVC.scanStr           = model.readNumber;
    nextVC.contentStr        = model.detailedContent;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ---change Seg---=====================================
- (IBAction)selectMessageType:(UISegmentedControl *)sender {
    kLog(@"----%ld",(long)_topSeg.selectedSegmentIndex);
    _isNews = _topSeg.selectedSegmentIndex;
    _pageNum = 0;
    [_dataArray removeAllObjects];
    
    [self getListWithType:_topSeg.selectedSegmentIndex];
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
