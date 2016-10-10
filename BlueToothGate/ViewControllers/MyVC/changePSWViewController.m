//
//  changePSWViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "changePSWViewController.h"

@interface changePSWViewController ()

@end

@implementation changePSWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)PSWBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)changePSWSaveBtn:(UIButton *)sender {
    if ([self.oldTF.text length]&[self.NewTF.text length]&[self.SecondNewTF.text length]) {
        if ([self.NewTF.text isEqualToString:self.SecondNewTF.text]) {
            NSMutableDictionary *mudic = [NSMutableDictionary new];
            [mudic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"userId"];
            [mudic setObject:self.oldTF.text forKey:@"oldPassword"];
            [mudic setObject:self.NewTF.text forKey:@"newPassword"];
            [[HYHttp sharedHYHttp] POST:ChangePSW parameters:mudic success:^(id  _Nonnull responseObject) {
//                NSLog(@"5555%@", responseObject);
                if ([responseObject[@"success"] intValue]) {
                    [ShowMessage showTextOnly:@"密码修改成功" messageView:self.view];
                }else{
                    [ShowMessage showTextOnly:@"密码修改失败" messageView:self.view];
                }
                
                
            } failure:^(NSError * _Nonnull error) {
                  [ShowMessage showTextOnly:@"密码修改失败" messageView:self.view];
            }];
            
        }else{
           [ShowMessage showTextOnly:@"两次输入的新密码不一样" messageView:self.view];
        }
    }else{
        [ShowMessage showTextOnly:@"输入格式不正确" messageView:self.view];
    }
    
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
