//
//  HHAddVillageVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/22.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHAddVillageVC.h"

@interface HHAddVillageVC ()

@end

@implementation HHAddVillageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
}

#pragma mark ---setUI---======================================
- (void)setUI{
    
    _lineOne_x.constant = ScreenW/3;
    _lineTwo_x.constant = ScreenW/3 * 2;
    
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
