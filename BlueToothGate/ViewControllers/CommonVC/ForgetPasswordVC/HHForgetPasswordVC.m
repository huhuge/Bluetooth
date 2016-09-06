//
//  HHForgetPasswordVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/24.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHForgetPasswordVC.h"
#import "HHFindPasswordVC.h"

@interface HHForgetPasswordVC (){
    ///计时器
    NSTimer *_countdownTimer;
    ///倒计时
    NSInteger _countdownTimes;
}


@end

@implementation HHForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)getCode:(UIButton *)sender {
    [self timerStart];
}

#pragma mark ---开始计时
-(void)timerStart
{
    _btnSendCode.userInteractionEnabled=NO;
    [_btnSendCode setBackgroundColor:[UIColor lightGrayColor]];
    _countdownTimes = 60;
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    [_countdownTimer fire];
}

#pragma mark ---倒计时
- (void)countdown
{
    if (_countdownTimes > 0) {
        [_btnSendCode setTitle:[NSString stringWithFormat:@"(%i)重新获取",(int)_countdownTimes] forState:UIControlStateNormal];
        _countdownTimes--;
        
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            //            _codeViewWidthConst.constant = 95;
            //            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            _btnSendCode.userInteractionEnabled = YES;
            [_btnSendCode setBackgroundColor:HHThemeColor];
            [_btnSendCode setTitle:@"发送验证码" forState:UIControlStateNormal];
            //关闭定时器
            [_countdownTimer setFireDate:[NSDate distantFuture]];
        }];
        
    }
}

#pragma mark ---下一步---=====================================
- (IBAction)nextStep:(UIButton *)sender {
    HHFindPasswordVC *nextVC = [HHFindPasswordVC new];
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
