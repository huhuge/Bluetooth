//
//  HHShoppingCarVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/9/12.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHShoppingCarVC.h"
#import "HHShopCartCell.h"
#import "HHShopCartModel.h"
#import "HHWriteOrderVC.h"

@interface HHShoppingCarVC ()<UITableViewDelegate,UITableViewDataSource>{
    ///选中的组
    NSMutableArray *_selectSectionArray;
    ///选中的cell
    NSMutableArray *_selectCellArry;
    ///全选状态
    BOOL isSelectAll;
    ///组头选中按钮
    NSMutableArray *_sectionBtnArray;
    
}

@end

@implementation HHShoppingCarVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setData];
    
    [self initTabView];
}

#pragma mark ---setData---======================================
- (void)setData{
    _selectCellArry     = [NSMutableArray new];
    _selectSectionArray = [NSMutableArray new];
    _sectionBtnArray    = [NSMutableArray new];
    
}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHShopCartCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *index = [NSString stringWithFormat:@"%ld",(long)section];
    
    UIView *sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 45)];
    sectionHeaderView.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame     = CGRectMake(15, 15, 15, 15);
    btn.tag       = section;
    [btn setImage:[UIImage imageNamed:@"X-input_1.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"X-input_2.png"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(selectAllInShop:) forControlEvents:UIControlEventTouchUpInside];
    btn.selected = [_selectSectionArray containsObject:index]?YES:NO;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 30, 30)];
    imageView.image        = [UIImage imageNamed:@"X-mian12.png"];

    UILabel *lab  = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, 120, 15)];
    lab.text      = @"蓝月亮专卖店";
    lab.textColor = [UIColor blackColor];
    lab.font      = [UIFont systemFontOfSize:13];
    
    UIButton *shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shopBtn.frame = CGRectMake(lab.frame.origin.x+120, 15, 15, 15);
    [shopBtn setImage:[UIImage imageNamed:@"enter.png"] forState:UIControlStateNormal];
    shopBtn.tag = section;
    [shopBtn addTarget:self action:@selector(turnToshop:) forControlEvents:UIControlEventTouchUpInside];
    
    BOOL isHaven = false;
    for (int i = 0; i < _sectionBtnArray.count; i++) {
        UIButton *btn1 = (UIButton *)_sectionBtnArray[i];
        if (btn1.tag == btn.tag) {
            isHaven = YES;
            [_sectionBtnArray replaceObjectAtIndex:i withObject:btn];
        }
    }
    
    if (!isHaven) {
        [_sectionBtnArray addObject:btn];
    }
    
    [sectionHeaderView addSubview:btn];
    [sectionHeaderView addSubview:imageView];
    [sectionHeaderView addSubview:lab];
    [sectionHeaderView addSubview:shopBtn];
    return sectionHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 2;
//    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  78;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHShopCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.btnSelect.tag = indexPath.section*1000 + indexPath.row;
    [cell.btnSelect addTarget:self action:@selector(selectCell:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *index = [NSString stringWithFormat:@"%ld",indexPath.section*1000+indexPath.row];
    HHShopCartModel *model = [HHShopCartModel new];
    
    [cell setCellDataWithModel:model andSelect:[_selectCellArry containsObject:index]?YES:NO];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.row);
//    HHRepairDetailVC *nextVC = [HHRepairDetailVC new];
//    [self.navigationController pushViewController:nextVC animated:YES];
    
    
}

#pragma mark ---选中cell---=====================================
- (void)selectCell:(UIButton *)sender{
     NSString *index = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    if ([_selectCellArry containsObject:index]) {
        [_selectCellArry removeObject:index];
    }else{
        [_selectCellArry addObject:index];
    }
    
    int cellInSection = 0;//该section中被选中cell的数量
    for (int i = 0; i < _selectCellArry.count; i++) {
        NSString *cellIndex = _selectCellArry[i];
        NSInteger cellTag = cellIndex.integerValue;
        if (cellTag/1000 == sender.tag/1000) {
            cellInSection++;
        }
    }
    
    UIButton *btn = _sectionBtnArray[sender.tag/1000];
    if (cellInSection == 2) {//section全选
        btn.selected = YES;
        NSString *index = [NSString stringWithFormat:@"%ld",sender.tag/1000];
        [_selectSectionArray addObject:index];
    }else{
        btn.selected = NO;
        NSString *index = [NSString stringWithFormat:@"%ld",sender.tag/1000];
        [_selectSectionArray removeObject:index];

    }
    
    [self checkSelectAll];
}

#pragma mark ---选中section---=====================================
- (void)selectAllInShop:(UIButton *)sender{
    kLog(@"selection = %ld",(long)sender.tag);
    NSString *sec = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    sender.selected = [_selectSectionArray containsObject:sec]?NO:YES;
    
    NSString *seciton = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    if ([_selectSectionArray containsObject:seciton]) {
        
        for (int i = 0; i<2; i++) {
            HHShopCartCell *cell = (HHShopCartCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:sender.tag]];
            cell.btnSelect.selected = NO;
            NSString *cellIndex = [NSString stringWithFormat:@"%ld",sender.tag*1000 + i];
            [_selectCellArry addObject:cellIndex];
            if ([_selectCellArry containsObject:cellIndex]) {
                [_selectCellArry removeObject:cellIndex];
            }
        }
        [_selectSectionArray removeObject:seciton];
    }else{
        for (int i = 0; i<2; i++) {
            HHShopCartCell *cell = (HHShopCartCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:sender.tag]];
            cell.btnSelect.selected = YES;
            NSString *cellIndex = [NSString stringWithFormat:@"%ld",sender.tag*1000 + i];
            if ([_selectCellArry containsObject:cellIndex]) {
                
            }else{
                [_selectCellArry addObject:cellIndex];
            }
        }
        [_selectSectionArray addObject:seciton];
    }
    
    [self checkSelectAll];
    
}

#pragma mark ---跳转商店---=====================================
- (void)turnToshop:(UIButton *)sender{
    kLog(@"shop = %ld",(long)sender.tag);
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---全选---=====================================
- (IBAction)selectAll:(UIButton *)sender {
    
    [_selectSectionArray removeAllObjects];
    [_selectCellArry removeAllObjects];
    
    _btnSelectAll.selected = !_btnSelectAll.selected;
    
    for (UIButton *btn in _sectionBtnArray) {//组头按钮选中效果
        if (isSelectAll) {
            btn.selected = NO;
        }else{
            btn.selected = YES;
        }
    }
    
    for (int i = 0; i < 5; i++) {//组头选中数组
        NSString *sectionindex = [NSString stringWithFormat:@"%d",i];
        if (!isSelectAll) {
            [_selectSectionArray addObject:sectionindex];
        }
    }
    
    for (int i = 0; i < 5; i++) {//cell选中效果
        for (int j = 0; j < 2; j++) {
            HHShopCartCell *cell = (HHShopCartCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            if (isSelectAll) {
                cell.btnSelect.selected = NO;
            }else{
                cell.btnSelect.selected = YES;
                NSString *cellIndex = [NSString stringWithFormat:@"%d",i*1000 + j];
                [_selectCellArry addObject:cellIndex];

            }

        }
    }

    isSelectAll = !isSelectAll;
}

#pragma mark ---检查全选---======================================
- (void)checkSelectAll{
    if (_selectSectionArray.count == 5) {
        _btnSelectAll.selected = YES;
    }else{
        _btnSelectAll.selected = NO;
    }
    isSelectAll = _btnSelectAll.selected;
}

#pragma mark ---结算---=====================================
- (IBAction)goToPay:(UIButton *)sender {
    kLog(@"cell = %@\nsection = %@",_selectCellArry,_selectSectionArray);
    HHWriteOrderVC *nextVC = [HHWriteOrderVC new];
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
