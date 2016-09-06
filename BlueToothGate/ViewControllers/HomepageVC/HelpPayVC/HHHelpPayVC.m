//
//  HHHelpPayVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/25.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHHelpPayVC.h"
#import "HHPayRecordVC.h"

@interface HHHelpPayVC ()

@end

@implementation HHHelpPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)turnToRecord:(UIButton *)sender {
    HHPayRecordVC *nextVC = [HHPayRecordVC new];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark ---select---======================================
- (IBAction)selectAction:(UIButton *)sender {
    
    if (sender.selected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
    kLog(@"%ld",(long)sender.tag);
}


#pragma mark ---返回---=====================================
- (IBAction)backAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
