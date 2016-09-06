//
//  OwerAgainCerViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/8/25.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "OwerAgainCerViewController.h"

@interface OwerAgainCerViewController ()

@end

@implementation OwerAgainCerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AgainCerBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)AgainCerSureBtn:(UIButton *)sender {
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
