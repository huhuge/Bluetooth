//
//  MyCircleViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/10/9.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "MyCircleViewController.h"
#import "HHCircleCell.h"
#import "HHPublicStatusVC.h"
#import "HHStatusDetailVC.h"
#import "HHCircleModel.h"

BOOL BisExercise;
NSString *Bsex;
NSArray *BtestArray;

@interface MyCircleViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_dataArray;
    NSMutableArray *_seleArray;
    HHPublicStatusVC *pvc;
    
    ///页码
    int _pageNum;
    ///加载下一页标志
    BOOL _isLoadNext;
    ///刷新标志
    BOOL _isReLoad;
    
}

@end

@implementation MyCircleViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (BisExercise) {
        //        kLog(@"success");
        [_tableView.mj_header beginRefreshing];
    }
    if (Bsex) {
        //        kLog(@"----%@-----",sex);
    }
    if (BtestArray.count) {
        //        kLog(@"%@",testArray);
    }
    if (SharedAppDelegate.testStr) {
        //        kLog(@"%@",SharedAppDelegate.testStr);
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self initTabView];
    
    [self initMJRefresh];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)MyCircleBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---setData---======================================
- (void)setData{
    _dataArray = [NSMutableArray new];
    _seleArray = [NSMutableArray new];
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
    
    [self getCircleList];
}

#pragma mark ---加载下一页
- (void)loadNextShowsPage
{
    _isLoadNext = YES;
    _isReLoad=NO;
    
    [self getCircleList];
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



#pragma mark ---获取列表---======================================
- (void)getCircleList{
    NSMutableDictionary *param = [NSMutableDictionary new];
    NSDictionary *info = [userDefault dictionaryForKey:HHUser_info_selectedCommunity_dic];
    
    [param setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"userId"];
    [param setObject:[info objectForKey:@"residentialInfoId"] forKey:@"residentialInfoId"];
    [param setObject:[NSString stringWithFormat:@"%d",_pageNum] forKey:@"currentPage"];
    [[HYHttp sharedHYHttp]POST:CircleListUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
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
                HHCircleModel *model = [HHCircleModel new];
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

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHCircleCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1.00001;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHCircleModel *model = _dataArray[indexPath.section];
    CGFloat height = [self getStringRect_:model.contents].height-18;
    
    return  175+height;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHCircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    
    HHCircleModel *model = _dataArray[indexPath.section];
    [cell setDataWithModel:model];
    
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.section);
    
    HHStatusDetailVC *nextVC = [HHStatusDetailVC new];
    HHCircleModel *model     = _dataArray[indexPath.section];
    
    nextVC.statusID   = model.myID;
    nextVC.contentStr = model.contents;
    [self.navigationController pushViewController:nextVC animated:YES];
}


#pragma mark ---发布圈子---======================================
- (IBAction)turnToPublic:(UIButton *)sender {
    HHPublicStatusVC *nextVC = [HHPublicStatusVC new];
    nextVC.block = ^(NSString * test){
        if (test) {
            kLog(@"+++%@+++",test);
        }else{
            kLog(@"---");
        }
    };
    
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark ---展示评论---======================================
- (void)showFunctionView:(UIButton*)sender{
    NSString *index = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    if ([_seleArray containsObject:index]) {
        [_seleArray removeObject:index];
    }else{
        [_seleArray addObject:index];
    }
}

#pragma mark ---评论---======================================
- (void)setComment:(UIButton *)sender{
    kLog(@"comment%ld",(long)sender.tag);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
    [ _tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark ---点赞---======================================
- (void)setPrize:(UIButton *)sender{
    kLog(@"prize%ld",(long)sender.tag);
    
}

#pragma mark ---获取字符串的大小  ios6---======================================
- (CGSize)getStringRect_:(NSString*)aString
{
    CGSize size = CGSizeMake(ScreenW-90,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize labelsize = [aString boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return  labelsize;
}


@end
