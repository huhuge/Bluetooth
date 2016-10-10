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
#import "HHAddVillageVC.h"
#import "editorMyCommunityVC.h"
@interface MyCommunityViewController ()<UITableViewDelegate,UITableViewDataSource,MyCommunityDelegate>
{
    UITableView *myTableView;
    NSArray *housesArr;
}
@end

@implementation MyCommunityViewController

- (void)viewDidLoad {
    housesArr = [NSArray array];
    [self getMyHouses];
    [super viewDidLoad];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, ScreenW, ScreenH-74) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:myTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)getMyHouses{
    NSUserDefaults *Defau = [NSUserDefaults standardUserDefaults];
    NSString *userID = [Defau stringForKey:HHUser_info_userID];
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    [mudic setObject:userID forKey:@"userId"];
    [[HYHttp sharedHYHttp] POST:GetUserHouseInfoUrl parameters:mudic success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"success"] integerValue]) {
            NSDictionary *objDic = responseObject[@"obj"];
            housesArr = objDic[@"rows"];
            [myTableView reloadData];
//            NSLog(@"3333%@", housesArr);
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"3333%@", error);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)MyCommunityBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)MyComunityAddBtn:(UIButton *)sender {
    HHAddVillageVC *addCommuVC = [[HHAddVillageVC alloc] init];
    [self.navigationController pushViewController:addCommuVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return housesArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CommunityCell = @"cell";
    MyCommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommunityCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCommunityTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    NSDictionary *houseDic = housesArr[indexPath.row];
    cell.communityDic = houseDic;
    NSString *nameStr = [NSString stringWithFormat:@"%@-%@-%@(%@)",houseDic[@"buildingName"],houseDic[@"floor"],houseDic[@"houseNum"],houseDic[@"residentialName"]];
    cell.nameLabel.text = nameStr;
    NSString *stateStr = [NSString stringWithFormat:@"%@", houseDic[@"authentication"]];
    if ([stateStr isEqualToString:@""]) {
        cell.stateLabel.text =@"草稿";
    }else if ([stateStr isEqualToString:@"1"]){
        cell.stateLabel.text =@"申请认证";
    }else if ([stateStr isEqualToString:@"2"]){
        cell.stateLabel.text =@"审核通过";
    }else {
        cell.stateLabel.text =@"审核失败";
    }
    
    return cell;
}

- (void)deleteCommunity{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定删除" message: nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancleBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertVC addAction:sureBtn];
    [alertVC addAction:cancleBtn];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)editorCommunity:(NSDictionary *)comDic{
    editorMyCommunityVC *addCommuVC = [[editorMyCommunityVC alloc] init];
    addCommuVC.commuDic = comDic;
    [self.navigationController pushViewController:addCommuVC animated:YES];
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
