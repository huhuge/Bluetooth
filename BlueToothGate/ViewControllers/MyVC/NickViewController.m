//
//  NickViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "NickViewController.h"

@interface NickViewController ()

@end

@implementation NickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)nickBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nickSaveBtn:(UIButton *)sender {
    NSMutableDictionary *mudic = [NSMutableDictionary new];
    [mudic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"id"];
    [mudic setObject:self.NickTF.text forKey:@"trueName"];
    [[HYHttp sharedHYHttp] POST:UpdataUserInfoUrl parameters:mudic success:^(id  _Nonnull responseObject) {
        
//        NSLog(@"888%@", responseObject);
        if ([responseObject[@"success"] intValue]) {
            [ShowMessage showTextOnly:responseObject[@"obj"] messageView:self.view];
        }else{
            [ShowMessage showTextOnly:responseObject[@"obj"] messageView:self.view];
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"444%@", error);
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
