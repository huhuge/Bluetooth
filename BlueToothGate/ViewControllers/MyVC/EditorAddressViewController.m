//
//  EditorAddressViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/9/27.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "EditorAddressViewController.h"

@interface EditorAddressViewController ()

@end

@implementation EditorAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.nameStr;
    self.numLabel.text = self.numStr;
    self.addressLabel.text = self.addressStr;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)EditorAddressBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (IBAction)EditoraddressCommitBtn:(UIButton *)sender {
    NSMutableDictionary *mudic = [NSMutableDictionary new];
    [mudic setObject:self.addressID forKey:@"id"];
    [mudic setObject:self.nameLabel.text forKey:@"trueName"];
    [mudic setObject:self.numLabel.text forKey:@"mobile"];
    [mudic setObject:self.addressLabel.text forKey:@"area_info"];
    [mudic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"userId"];
    [[HYHttp sharedHYHttp] POST:EditorGoodsAddress parameters:mudic success:^(id  _Nonnull responseObject) {
        NSLog(@"$$$%@", responseObject);
        if ([responseObject[@"success"] integerValue]) {
            [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
        }else{
            [ShowMessage showTextOnly:@"修改失败" messageView:self.view];
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"$$$%@", error);
        
        
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
