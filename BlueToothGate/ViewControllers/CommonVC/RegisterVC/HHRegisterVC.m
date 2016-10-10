//
//  HHRegisterVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/22.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHRegisterVC.h"
#import "HHAddVillageVC.h"

@interface HHRegisterVC (){
    ///计时器
    NSTimer *_countdownTimer;
    ///倒计时
    NSInteger _countdownTimes;
    ///验证码
    NSString *_tempCaptcha;
}


@end

@implementation HHRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark ---获取验证码---=====================================
- (IBAction)getCode:(UIButton *)sender {
    
    [self checkPhoneNumberRequest];
    
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

#pragma mark ---checkPhone---======================================
- (void)checkPhoneNumberRequest{
    if ([_TFPhoneNumber.text isEqualToString:@""]||_TFPhoneNumber.text.length == 0) {
        [ShowMessage showTextOnly:@"请输入手机号码" messageView:self.view];
        return;
    }

    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:_TFPhoneNumber.text forKey:@"telephone"];
     [[HYHttp sharedHYHttp]POST:CheckRegisterUrl parameters:param success:^(id  _Nonnull responseObject) {
         kLog(@"%@",responseObject);
         if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
             [self GetCaptchaRequest];
         }else{
             [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];

         }
     } failure:^(NSError * _Nonnull error) {
         kLog(@"fail");
     }];
}

#pragma mark ---getCaptcha---======================================
- (void)GetCaptchaRequest{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:_TFPhoneNumber.text forKey:@"telephone"];
    [[HYHttp sharedHYHttp]POST:GetCaptchaUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        _tempCaptcha = [responseObject objectForKey:@"obj"];

    } failure:^(NSError * _Nonnull error) {
        kLog(@"fail");

    }];
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
    
    if ([_TFUserName.text isEqualToString:@""]||_TFUserName.text.length ==0) {
        [ShowMessage showTextOnly:@"请输入真实姓名" messageView:self.view];
        return;
    }
    
    if (![_TFPassword.text isEqualToString:_TFPasswordAgain.text]) {
        [ShowMessage showTextOnly:@"两次输入密码不同，请重新输入" messageView:self.view];
        return;
    }
    if ([_TFPassword.text isEqualToString:@""]||_TFPassword.text.length == 0) {
        [ShowMessage showTextOnly:@"请输入密码" messageView:self.view];
        return;
    }
    if ([_TFPhoneNumber.text isEqualToString:@""]||_TFPhoneNumber.text.length == 0) {
        [ShowMessage showTextOnly:@"请输入手机号" messageView:self.view];
        return;
    }

    if (![_TFCaptcha.text isEqualToString:_tempCaptcha]||[_TFCaptcha.text isEqualToString:@""]) {
        [ShowMessage showTextOnly:@"验证码错误" messageView:self.view];
        return;
    }
    
    [self setRegisterRequest];
    
//    HHAddVillageVC *nextVC = [HHAddVillageVC new];
//    [self.navigationController pushViewController:nextVC animated:YES];

}

#pragma mark ---register---======================================
- (void)setRegisterRequest{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:_TFUserName.text forKey:@"trueName"];
    [param setObject:_TFPasswordAgain.text forKey:@"password"];
    [param setObject:_TFPhoneNumber.text forKey:@"telephone"];
    
    [[HYHttp sharedHYHttp]POST:RegisterUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"]integerValue] == 1) {
            [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
            HHAddVillageVC *nextVC = [HHAddVillageVC new];
            [self.navigationController pushViewController:nextVC animated:YES];

        }else{
            [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];
        }

    } failure:^(NSError * _Nonnull error) {
        [ShowMessage showTextOnly:@"注册失败" messageView:self.view];
    }];
    
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
