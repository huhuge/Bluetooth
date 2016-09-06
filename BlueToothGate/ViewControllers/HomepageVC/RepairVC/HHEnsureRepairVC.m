//
//  HHEnsureRepairVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHEnsureRepairVC.h"

@interface HHEnsureRepairVC ()

@end

@implementation HHEnsureRepairVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    
}

#pragma mark ---setUI---======================================
- (void)setUI{
    _labRepairType.text            = _repairType;
    _labContent.text               = _content;
    _imgView_one.image             = _imgArray[0];
    _imgView_two.image             = _imgArray[1];
    _btnCommit.layer.masksToBounds = YES;
    _btnCommit.layer.cornerRadius  = 5;

}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)commitAction:(UIButton *)sender {
    
}

@end
