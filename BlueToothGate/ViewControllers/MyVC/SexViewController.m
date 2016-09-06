//
//  SexViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "SexViewController.h"

@interface SexViewController ()

@property (nonatomic, assign) BOOL IFMaleSelect;
@property (nonatomic, assign) BOOL IFFemaleSelect;

@end

@implementation SexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.maleBtn.selected = NO;
    self.femaleBtn.selected = NO;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)selectBtn:(UIButton *)sender {
    if (![sender isFirstResponder]) {
        self.IFMaleSelect = YES;
    }
//    self.maleBtn.selected = !self.maleBtn.selected;
    if (self.IFMaleSelect) {
        [self.maleBtn setImage:[UIImage imageNamed:@"X-input_2"] forState:UIControlStateNormal];
         [self.femaleBtn setImage:[UIImage imageNamed:@"X-input_1"] forState:UIControlStateNormal];
    }else{
        [self.maleBtn setImage:[UIImage imageNamed:@"X-input_1"] forState:UIControlStateNormal];
        [self.femaleBtn setImage:[UIImage imageNamed:@"X-input_2"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)selectFemaleBtn:(UIButton *)sender {
//    self.femaleBtn.selected = !self.femaleBtn.selected;
    if (![sender isFirstResponder]) {
        self.IFFemaleSelect = YES;
    }
    if (self.IFFemaleSelect) {
        [self.femaleBtn setImage:[UIImage imageNamed:@"X-input_2"] forState:UIControlStateNormal];
         [self.maleBtn setImage:[UIImage imageNamed:@"X-input_1"] forState:UIControlStateNormal];
    }else{
        [self.femaleBtn setImage:[UIImage imageNamed:@"X-input_1"] forState:UIControlStateNormal];
        [self.maleBtn setImage:[UIImage imageNamed:@"X-input_2"] forState:UIControlStateNormal];
    }


}

- (IBAction)SexSaveBtn:(UIButton *)sender {
}

- (IBAction)SexBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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