//
//  MyCommunityViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/8/25.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "MyCommunityViewController.h"
#import "MyCommunityTableViewCell.h"
#import "AddCommunityViewController.h"
@interface MyCommunityViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
}
@end

@implementation MyCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, ScreenW, ScreenH-74) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:myTableView];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)MyCommunityBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)MyComunityAddBtn:(UIButton *)sender {
    AddCommunityViewController *addCommuVC = [[AddCommunityViewController alloc] init];
    [self.navigationController pushViewController:addCommuVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CommunityCell = @"cell";
    MyCommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommunityCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCommunityTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
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
