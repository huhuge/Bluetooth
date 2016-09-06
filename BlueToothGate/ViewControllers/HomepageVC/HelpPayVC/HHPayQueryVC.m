//
//  HHPayQueryVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/25.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHPayQueryVC.h"
#import "HHPayRecordVC.h"
#import "HHPayQueryCell.h"
#import "HHHelpPayVC.h"

@interface HHPayQueryVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_dataArray;
}

@end

@implementation HHPayQueryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"水电费",@"第三方达",@"打的费",@"是打发",@"水电费",@"第三方达",@"打的费",@"是打发",@"水电费",@"第三方达",@"打的费",@"是打发",@"水电费",@"第三方达",@"打的费",@"是打发",@"水电费",@"第三方达",@"打的费",@"是打发", nil];
    
    [self initTabView];
}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    _tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView  = _footerView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHPayQueryCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    headView.backgroundColor = HHBackGroundColor;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 100, 20)];
    lab.text = @"8月";
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:13];
    [headView addSubview:lab];
    return headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    //    return _dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  136;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHPayQueryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHPayQueryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }
    
    
    
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.row);
    //    HHNoticeDetailVC *nextVC = [HHNoticeDetailVC new];
    //    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ---缴费记录---=====================================
- (IBAction)turnToRecord:(UIButton *)sender {
    HHPayRecordVC *nextVC = [HHPayRecordVC new];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark ---缴费---=====================================
- (IBAction)payAction:(UIButton *)sender {
    HHHelpPayVC *nextVC = [HHHelpPayVC new];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark ---选择小区---=====================================
- (IBAction)selectAction:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFCommunity.frame.origin.x, _TFCommunity.frame.origin.y + 64+30, _TFCommunity.frame.size.width, 100) selectData:_dataArray action:^(NSInteger index){
        _TFCommunity.text = _dataArray[index];
        
    } animated:YES];
}

#pragma mark ---返回---=====================================
- (IBAction)backAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
