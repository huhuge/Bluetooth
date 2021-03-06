//
//  IDCardViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "IDCardViewController.h"

@interface IDCardViewController ()

@end

@implementation IDCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)IDCardBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)IDCardSaveBtn:(UIButton *)sender {
    if (![self.IDTF.text length]) {
        [ShowMessage showTextOnly:@"不能为空" messageView:self.view];
        return;
    }
    NSMutableDictionary *mudic = [NSMutableDictionary new];
    [mudic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"id"];
    [mudic setObject:self.IDTF.text forKey:@"id_card"];
    [[HYHttp sharedHYHttp] POST:UpdataUserInfoUrl parameters:mudic success:^(id  _Nonnull responseObject) {
        
//                NSLog(@"888%@", responseObject);
        if ([responseObject[@"success"] intValue]) {
            [ShowMessage showTextOnly:responseObject[@"obj"] messageView:self.view];
        }else{
            [ShowMessage showTextOnly:responseObject[@"obj"] messageView:self.view];
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        [ShowMessage showTextOnly:@"修改失败" messageView:self.view];
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
