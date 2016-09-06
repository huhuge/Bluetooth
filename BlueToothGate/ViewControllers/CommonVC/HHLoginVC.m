//
//  HHLoginVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/19.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHLoginVC.h"
#import "HHRegisterVC.h"
#import "HHForgetPasswordVC.h"

@interface HHLoginVC ()

@end

@implementation HHLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ---登录---=====================================
- (IBAction)loginAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---注册---=====================================
- (IBAction)registerAction:(UIButton *)sender {
    
    HHRegisterVC *nextVC = [[HHRegisterVC alloc]init];
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ---忘记密码---=====================================
- (IBAction)forgetPasswordAction:(UIButton *)sender {
    
    HHForgetPasswordVC *nextVC = [[HHForgetPasswordVC alloc]init];
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ---返回---=====================================
- (IBAction)backAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
