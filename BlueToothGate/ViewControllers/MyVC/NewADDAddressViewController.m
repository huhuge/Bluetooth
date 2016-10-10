//
//  NewADDAddressViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/9/27.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "NewADDAddressViewController.h"

@interface NewADDAddressViewController ()

@end

@implementation NewADDAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)commitAddressBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)commitAddressBtn:(UIButton *)sender {
    NSMutableDictionary *mudic = [NSMutableDictionary new];
    [mudic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"userId"];
    [mudic setObject:self.nameTF.text forKey:@"trueName"];
    [mudic setObject:self.numTF.text forKey:@"mobile"];
    [mudic setObject:self.addressTF.text forKey:@"area_inf"];
    [[HYHttp sharedHYHttp] POST:NewADDGoodsAddress parameters:mudic success:^(id  _Nonnull responseObject) {
        NSLog(@"555%@", responseObject);
        if ([responseObject[@"success"] integerValue]) {
            [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
        }else{
            [ShowMessage showTextOnly:@"提交失败" messageView:self.view];
        }
        
        
    } failure:^(NSError * _Nonnull error) {
         NSLog(@"555%@", error);
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
