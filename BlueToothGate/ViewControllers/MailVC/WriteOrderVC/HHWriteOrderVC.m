//
//  HHWriteOrderVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/9/13.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHWriteOrderVC.h"
#import "HHShopCartCell.h"
#import "HHShopCartModel.h"

@interface HHWriteOrderVC ()<UITableViewDelegate,UITableViewDataSource>{
    
}

@end

@implementation HHWriteOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTabView];
    
}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    _tableView.tableHeaderView  = _headerView;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHShopCartCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 208.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSString *index = [NSString stringWithFormat:@"%ld",(long)section];
    
    UIView *sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 45)];
    sectionHeaderView.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame     = CGRectMake(15, 15, 15, 15);
    btn.tag       = section;
    [btn setImage:[UIImage imageNamed:@"X-input_1.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"X-input_2.png"] forState:UIControlStateSelected];
//    [btn addTarget:self action:@selector(selectAllInShop:) forControlEvents:UIControlEventTouchUpInside];
    btn.selected = YES;
    
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
    
    
    [sectionHeaderView addSubview:btn];
    [sectionHeaderView addSubview:imageView];
    [sectionHeaderView addSubview:lab];
    [sectionHeaderView addSubview:shopBtn];
    return sectionHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *labTr  = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 30, 13)];
    labTr.font      = [UIFont systemFontOfSize:13];
    labTr.text      = @"运费";
    labTr.textColor = [UIColor darkGrayColor];
    [footerView addSubview:labTr];
    
    UILabel *labTrFee  = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW - 40,10, 30, 13)];
    labTrFee.font      = [UIFont systemFontOfSize:13];
    labTrFee.text      = @"￥10";
    labTrFee.textColor = HHThemeColor;
    [footerView addSubview:labTrFee];
    
    UILabel *labTip  = [[UILabel alloc]initWithFrame:CGRectMake(50,30, 100, 13)];
    labTip.font      = [UIFont systemFontOfSize:13];
    labTip.text      = @"自动收取服务费";
    labTip.textColor = [UIColor darkGrayColor];
    [footerView addSubview:labTip];

    UILabel *labMsg  = [[UILabel alloc]initWithFrame:CGRectMake(10,60, 30, 13)];
    labMsg.font      = [UIFont systemFontOfSize:13];
    labMsg.text      = @"留言";
    labMsg.textColor = [UIColor darkGrayColor];
    [footerView addSubview:labMsg];
    
    UITextField *TFLeaveMsg = [[UITextField alloc]initWithFrame:CGRectMake(50, 90, ScreenW-70, 30)];
    TFLeaveMsg.borderStyle  = UITextBorderStyleRoundedRect;
    TFLeaveMsg.placeholder  = @"给卖家留言......";
    TFLeaveMsg.font         = [UIFont systemFontOfSize:13];
    [footerView addSubview:TFLeaveMsg];
    
    UIView *grayView         = [[UIView alloc]initWithFrame:CGRectMake(0, 130, ScreenW, 40)];
    grayView.backgroundColor = HHBackGroundColor;
    [footerView addSubview:grayView];
    
    UILabel *labCount  = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW - 150,10, 130, 20)];
    labCount.font      = [UIFont systemFontOfSize:13];
    labCount.text      = @"共1件商品 合计：79";
    labCount.textColor = [UIColor darkGrayColor];
    [grayView addSubview:labCount];

    UILabel *labNoti  = [[UILabel alloc]initWithFrame:CGRectMake(10,175, 130, 20)];
    labNoti.font      = [UIFont systemFontOfSize:13];
    labNoti.text      = @"短信通信收件人";
    labNoti.textColor = [UIColor blackColor];
    [footerView addSubview:labNoti];

    UIButton *btnNoti = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNoti.frame     = CGRectMake(ScreenW - 30, 175, 15, 15);
    btnNoti.tag       = section;
    [btnNoti setImage:[UIImage imageNamed:@"X-input_1.png"] forState:UIControlStateNormal];
    [btnNoti setImage:[UIImage imageNamed:@"X-input_2.png"] forState:UIControlStateSelected];
    //    [btn addTarget:self action:@selector(selectAllInShop:) forControlEvents:UIControlEventTouchUpInside];
    btnNoti.selected = YES;
    [footerView addSubview:btnNoti];
    
    UIView *deepView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, ScreenW, 8)];
    deepView.backgroundColor = HHBackGroundColor;
    [footerView addSubview:deepView];

    
    return footerView;
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
    cell.selectionStyle     = UITableViewCellSelectionStyleNone;
    cell.btnSelect.tag      = indexPath.section*1000 + indexPath.row;
    cell.btnSelect.selected = YES;
    cell.funcView.hidden    = YES;
    
//    [cell.btnSelect addTarget:self action:@selector(selectCell:) forControlEvents:UIControlEventTouchUpInside];
    
//    NSString *index = [NSString stringWithFormat:@"%ld",indexPath.section*1000+indexPath.row];
//    HHShopCartModel *model = [HHShopCartModel new];
    
//    [cell setCellDataWithModel:model andSelect:[_selectCellArry containsObject:index]?YES:NO];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.row);
    //    HHRepairDetailVC *nextVC = [HHRepairDetailVC new];
    //    [self.navigationController pushViewController:nextVC animated:YES];
    
    
}

#pragma mark ---跳转商店---=====================================
- (void)turnToshop:(UIButton *)sender{
    kLog(@"shop = %ld",(long)sender.tag);
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
//    [SharedAppDelegate setupLoginViewController];
}


@end
