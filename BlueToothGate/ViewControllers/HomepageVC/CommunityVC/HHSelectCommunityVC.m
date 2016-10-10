//
//  HHSelectCommunityVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/24.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHSelectCommunityVC.h"
#import "HHSelectCommunityCell.h"
#import "HHSelectCommunityModel.h"

@interface HHSelectCommunityVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_dataArray;
    NSMutableArray *_orginArray;
}

@end

@implementation HHSelectCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self getCommunity];
    
    [self initTabView];
    
    
}

#pragma mark ---setData---======================================
- (void)setData{
    _dataArray = [NSMutableArray new];
    _orginArray = [NSMutableArray new];
    _labCurrentSel.text =   [NSString stringWithFormat:@"当前选择：%@",_currentCommunity];

}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    _tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHSelectCommunityCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.00001;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  67;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHSelectCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHSelectCommunityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    HHSelectCommunityModel *model = _dataArray[indexPath.section];
    [cell setCellWithModel:model];
    
      return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.row);
    HHSelectCommunityModel *model = _dataArray[indexPath.section];
    NSDictionary *dic             = _orginArray[indexPath.section];
    
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:HHUser_info_selectedCommunity_dic];
    
    if (self.delegate) {
        [self.delegate respondsToSelector:@selector(getCurrentCommunityString:)];
        [self.delegate getCurrentCommunityString:model.residentialName];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ---获取小区---======================================
- (void)getCommunity{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:HHUser_info_userID] forKey:@"userId"];
    [[HYHttp sharedHYHttp]POST:GetUserHouseInfoUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows     = [obj objectForKey:@"rows"];
            
            for (NSDictionary *dic in rows) {
                HHSelectCommunityModel *model = [HHSelectCommunityModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArray addObject:model];
                [_orginArray addObject:dic];
            }
            [_tableView reloadData];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
