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

@interface HHNoticeVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_dataArray;
}

@end

@implementation HHNoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabView];
    
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
    return 10.00;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    //    return _dataArray.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  78;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHNoticeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }
    
//    ReceivableModel *model = [_dataArray objectAtIndex:indexPath.section];
//    cell.labCompanyName.text = [NSString stringWithFormat:@"%@",model.pharmacyName];
//    cell.labBackMoney.text   = [NSString stringWithFormat:@"本次回款总额%@",model.paymentAmount];
//    cell.labTime.text        = [NSString stringWithFormat:@"时间：%@",model.paymentTime];
//    cell.labMonth.text       = [NSString stringWithFormat:@"本月合计总金额：%@",model.paymentAmountTotalMonth];
//    cell.labYear.text        = [NSString stringWithFormat:@"本年合计总金额%@",model.paymentAmountTotalYear];
//    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.row);
    HHNoticeDetailVC *nextVC = [HHNoticeDetailVC new];
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ---change Seg---=====================================
- (IBAction)selectMessageType:(UISegmentedControl *)sender {
    kLog(@"----%ld",(long)_topSeg.selectedSegmentIndex);
    
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
