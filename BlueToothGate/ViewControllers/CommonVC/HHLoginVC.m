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
#import "JPUSHService.h"
#import "HHAddVillageVC.h"

@interface HHLoginVC ()

@end

@implementation HHLoginVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUI];
    
}


#pragma mark ---setUI---======================================
- (void)setUI{
    
    self.btnBack.hidden = _isHideBackBtn;
    self.backImgView.hidden = _isHideBackBtn;
//    kLog(@"%hhd",_isHideBackBtn);
    
}

#pragma mark ---登录---=====================================
- (IBAction)loginAction:(UIButton *)sender {
    
    [self setLoginRequest];
    
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---setReq---======================================
- (void)setLoginRequest{
    [ShowMessage showLoadingData:self.view strMessage:@"正在登录"];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:_TFUserName.text forKey:@"username"];
    [dic setObject:_TFPassword.text forKey:@"password"];
    [[HYHttp sharedHYHttp]GET:LoginUrl parameters:dic success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1 ) {
            [ShowMessage showTextOnly:@"登录成功！" messageView:self.view];
            
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            
            
            ///保存用户信息
            NSUserDefaults *userDft = [NSUserDefaults standardUserDefaults];
            [userDft setObject:obj[@"id"] forKey:HHUser_info_userID];
            [userDft setObject:_TFUserName.text forKey:HHUser_info_Account];
            [userDft setObject:_TFPassword.text forKey:HHUser_info_Psaaword];
            [userDft setBool:YES forKey:HHUser_LoginStatus];
            [userDft synchronize];
            NSString *alias_id = [NSString stringWithFormat:@"%@",obj[@"id"]];
            [self getCommunity];
            __autoreleasing NSMutableSet *tags = [NSMutableSet set];
            [JPUSHService setTags:tags alias:alias_id fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                kLog(@"-----%@",iAlias);
            }];
            
//            kLog(@"%@---%hhd",[userDft objectForKey:HHUser_info_Psaaword],[userDft boolForKey:HHUser_LoginStatus]);
//            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [ShowMessage showTextOnly:responseObject[@"errorMessage"] messageView:self.view];

        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [ShowMessage showTextOnly:@"登录失败，请重试" messageView:self.view];

    }];

}

#pragma mark ---获取小区---======================================
- (void)getCommunity{
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:HHUser_info_userID] forKey:@"userId"];
    [[HYHttp sharedHYHttp]POST:GetUserHouseInfoUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            NSDictionary *obj     = [responseObject objectForKey:@"obj"];
            NSArray *rows         = [obj objectForKey:@"rows"];
            if (!rows.count) {
                HHAddVillageVC *nextVC = [HHAddVillageVC new];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
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
