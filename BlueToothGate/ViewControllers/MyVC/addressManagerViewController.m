//
//  addressManagerViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "addressManagerViewController.h"

@interface addressManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
}
@end

@implementation addressManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, ScreenW, ScreenH-100-64) style:UITableViewStylePlain];
//    myTableView.delegate = self;
//    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)addressBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addressBtn:(UIButton *)sender {
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
