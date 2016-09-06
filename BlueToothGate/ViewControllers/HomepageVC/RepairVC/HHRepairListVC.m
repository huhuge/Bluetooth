//
//  HHRepairListVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHRepairListVC.h"
#import "HHRepairCell.h"
#import "HHRepairDetailVC.h"

@interface HHRepairListVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_typeArray;
}

@end

@implementation HHRepairListVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setData];
    
    [self setUI];
    
    [self initTabView];
}

#pragma mark ---Data---======================================
- (void)setData{
    _typeArray = [[NSArray alloc]initWithObjects:@"水管维修",@"网络维修", nil];
}

#pragma mark ---initUI---======================================
- (void)setUI{
    _TFType.layer.borderColor = kRGBColor(228, 228, 228).CGColor;
    _TFType.layer.borderWidth = 0.5;
}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHRepairCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.00;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    //    return _dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  78;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHRepairCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHRepairCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
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
    HHRepairDetailVC *nextVC = [HHRepairDetailVC new];
    [self.navigationController pushViewController:nextVC animated:YES];
    
    
}

#pragma mark ---选择类型---=====================================

- (IBAction)selectType:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFType.frame.origin.x, _TFType.frame.origin.y+30+64, _TFType.frame.size.width, 60) selectData:_typeArray action:^(NSInteger index) {
        
        _TFType.text = _typeArray[index];
        kLog(@"%ld",(long)index);
        
    } animated:YES];

}

#pragma mark ---back---=====================================
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
