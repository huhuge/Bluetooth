//
//  HHGoodsDetailVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/29.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHGoodsDetailVC.h"

@interface HHGoodsDetailVC ()

@end

@implementation HHGoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableHeaderView = _headerView;
    _tableView.separatorStyle  = UITableViewCellSelectionStyleNone;
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
