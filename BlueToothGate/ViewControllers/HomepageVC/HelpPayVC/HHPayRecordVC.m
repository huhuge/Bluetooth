//
//  HHPayRecordVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/25.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHPayRecordVC.h"
#import "HHPayRecordCell.h"


@interface HHPayRecordVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_dataArray;
}

@end

@implementation HHPayRecordVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"水电费",@"第三方达",@"打的费",@"是打发",@"水电费",@"第三方达",@"打的费",@"是打发",@"水电费",@"第三方达",@"打的费",@"是打发",@"水电费",@"第三方达",@"打的费",@"是打发",@"水电费",@"第三方达",@"打的费",@"是打发", nil];
    
    [self initPop];
    
    [self initTabView];
    
}

#pragma mark ---initPop---======================================
- (void)initPop{
 
}


#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableview.delegate         = self;
    _tableview.dataSource       = self;
    _tableview.separatorStyle   = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HHPayRecordCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    //    return _dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  27;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHPayRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHPayRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }
    
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = kRGBColor(240, 240, 240);
    }
    
    if (indexPath.row == 0) {
        cell.labGasFee.textColor      = [UIColor blackColor];
        cell.labWaterFee.textColor    = [UIColor blackColor];
        cell.labManageFee.textColor   = [UIColor blackColor];
        cell.labElectricFee.textColor = [UIColor blackColor];
    }
    
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.row);
//    HHNoticeDetailVC *nextVC = [HHNoticeDetailVC new];
//    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ---选择小区---=====================================
- (IBAction)selectCommunity:(UIButton *)sender {
    
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFCommunity.frame.origin.x, _TFCommunity.frame.origin.y + 64+30, _TFCommunity.frame.size.width, 100) selectData:_dataArray action:^(NSInteger index){
        _TFCommunity.text = _dataArray[index];
        
    } animated:YES];

}



#pragma mark ---返回---=====================================
- (IBAction)backAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
