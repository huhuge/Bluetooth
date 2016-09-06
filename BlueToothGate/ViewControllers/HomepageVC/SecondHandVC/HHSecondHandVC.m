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

@interface HHSecondHandVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_dataArray;
    ///选择小区
    NSMutableArray *_comminutiesArray;
    ///产品分了
    NSMutableArray *_productArray;
    ///新旧程度
    NSMutableArray *_newDegreeArray;
}

@end

@implementation HHSecondHandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self setUI];
    
    [self initTabView];
    
}

#pragma mark ---setData---======================================
- (void)setData{
//    _productArray     = [NSMutableArray new];
//    _comminutiesArray = [NSMutableArray new];
//    _newDegreeArray   = [NSMutableArray new];
    
    _productArray     = [[NSMutableArray alloc]initWithObjects:@"衣",@"裤子",@"破鞋子",@"全新手套",@"精美比基尼", nil];
    _comminutiesArray = [[NSMutableArray alloc]initWithObjects:@"衣服",@"裤子",@"宜家",@"鞋子", nil];
    _newDegreeArray   = [[NSMutableArray alloc]initWithObjects:@"衣服",@"裤子",@"宜家",@"鞋子", nil];
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
    
    return 5;
    
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
    
    //    ReceivableModel *model = [_dataArray objectAtIndex:indexPath.section];
    //    cell.labCompanyName.text = [NSString stringWithFormat:@"%@",model.pharmacyName];
    //    cell.labBackMoney.text   = [NSString stringWithFormat:@"本次回款总额%@",model.paymentAmount];
    //    cell.labTime.text        = [NSString stringWithFormat:@"时间：%@",model.paymentTime];
    //    cell.labMonth.text       = [NSString stringWithFormat:@"本月合计总金额：%@",model.paymentAmountTotalMonth];
    //    cell.labYear.text        = [NSString stringWithFormat:@"本年合计总金额%@",model.paymentAmountTotalYear];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.section);
    HHGoodsDetailVC *nextVC = [HHGoodsDetailVC new];
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
    
}

#pragma mark ---Community ---=====================================
- (IBAction)selectCommunity:(UIButton *)sender {
    if (!_comminutiesArray.count) {
        [ShowMessage showTextOnly:@"无可选小区" messageView:self.view];
        return;
    }
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( 0, 100, ScreenW/3, 100) selectData:_comminutiesArray action:^(NSInteger index) {
        _labCommunity.text = _comminutiesArray[index];
    } animated:YES];
}

#pragma mark --- product---=====================================
- (IBAction)productType:(UIButton *)sender {
    if (!_productArray.count) {
        [ShowMessage showTextOnly:@"无可选产品分类" messageView:self.view];
        return;
    }
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( ScreenW/3, 100, ScreenW/3, 100) selectData:_productArray action:^(NSInteger index) {
        _labProduct.text = _productArray[index];
    } animated:YES];
}

#pragma mark ---newDegree ---=====================================
- (IBAction)newDegree:(UIButton *)sender {
    if (!_comminutiesArray.count) {
        [ShowMessage showTextOnly:@"无法选择新旧程度" messageView:self.view];
        return;
    }
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( ScreenW/3*2, 100, ScreenW/3, 100) selectData:_newDegreeArray action:^(NSInteger index) {
        _labNewDegree.text = _newDegreeArray[index];
    } animated:YES];
}


- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
