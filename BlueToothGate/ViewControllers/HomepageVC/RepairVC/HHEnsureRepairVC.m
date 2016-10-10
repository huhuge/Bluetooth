//
//  HHEnsureRepairVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHEnsureRepairVC.h"
#import "HYPicModel.h"

@interface HHEnsureRepairVC (){
}

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
//    _imgView_two.image             = _imgArray[1];
    _btnCommit.layer.masksToBounds = YES;
    _btnCommit.layer.cornerRadius  = 5;

}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)commitAction:(UIButton *)sender {
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"userId"];
    [param setObject:_houseID forKey:@"userHouseInfoId"];
//    [param setObject:@"" forKey:@"id"];
    [param setObject:_repairTypeID forKey:@"propertyRepairTypeId"];
//    [param setObject:@"" forKey:@"propertyRepairTypeApplyImg"];
    [param setObject:_content forKey:@"remarks"];
    
    HYPicModel *model = [[HYPicModel alloc]init];
    model.pic     = _imgArray[0];
    model.picData = _imageData;
    model.picName = @"propertyRepairTypeApplyImg";
    model.url     = _fullPath;
    
    
    
    [[HYHttp sharedHYHttp]POST:RepairApplyUrl parameters:param andPic:model progress:nil success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"]integerValue] == 1) {
            
            [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }else{
            [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];
            
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [ShowMessage showTextOnly:@"提交失败，请重试" messageView:self.view];
        
    }];

}

@end
