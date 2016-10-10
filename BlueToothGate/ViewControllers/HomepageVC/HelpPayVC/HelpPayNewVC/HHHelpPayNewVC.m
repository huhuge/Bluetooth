//
//  HHHelpPayNewVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/9/10.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHHelpPayNewVC.h"

@interface HHHelpPayNewVC ()

@end

@implementation HHHelpPayNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
}

#pragma mark ---setData---======================================
- (void)setData{
    _TFhouse.text      = _house_from_fommer;
    _TFType.text       = _type_from_fommer;
    _TFCardNumber.text = _carNumber;
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ensurePay:(UIButton *)sender {
    if ([_TFmoney.text isEqualToString:@""]||_TFmoney.text.length == 0) {
        [ShowMessage showTextOnly:@"请输入金额" messageView:self.view];
        return;
    }
    [ShowMessage showLoadingData:self.view strMessage:@"提交中，稍等"];
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:HHUser_info_userID] forKey:@"userId"];
    [param setObject:_houseID_from_fommer forKey:@"userBindProxyId"];
    [param setObject:_dataID forKey:@"id"];
    [param setObject:_TFmoney.text forKey:@"currentPay"];
    
    
    [[HYHttp sharedHYHttp]POST:HelpPayApplyUrl parameters:param success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [ShowMessage showTextOnly:@"保存失败，请重试" messageView:self.view];
        
        kLog(@"fail");
    }];

    
}

@end
