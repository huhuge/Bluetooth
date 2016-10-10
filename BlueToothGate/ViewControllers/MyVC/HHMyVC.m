//
//  HHMyVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/16.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHMyVC.h"
#import "MyTableViewCell.h"
#import "MyCountViewController.h"
#import "OwnerDidCerViewController.h"
#import "MyCommunityViewController.h"
#import "HHSecondHandVC.h"
#import "MyOpinionViewController.h"

#import "HHCircleVC.h"
#import "MyCircleViewController.h"
#import "MySecondHandVC.h"
@interface HHMyVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *view1;
    UILabel *view2;
    UILabel *view3;
    UILabel *view4;
    
    NSDictionary *baseDic;
    NSDictionary *ProDic;
}

@property (nonatomic, strong) UITableView *myTableView;


@end

@implementation HHMyVC

- (void)viewWillAppear:(BOOL)animated{
    [self getPersonInfo];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    baseDic = [NSDictionary dictionary];
    ProDic = [NSDictionary dictionary];
//    self.navigationController.title = @"我的";
    self.title = @"我的";
    [self getPersonInfo];
    [self creatUI];
     _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+123, ScreenW, ScreenH-123-50-44) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_myTableView];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
//    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _myTableView.scrollEnabled = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)getPersonInfo{
    NSUserDefaults *Defau = [NSUserDefaults standardUserDefaults];
    NSString *userID = [Defau stringForKey:HHUser_info_userID];
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    [mudic setObject:userID forKey:@"userId"];
    [[HYHttp sharedHYHttp] GET:GetUserInfoUrl parameters:mudic success:^(id  _Nonnull responseObject) {
//    NSLog(@"8888%@", responseObject);
        if ([responseObject[@"success"] integerValue]) {
            NSDictionary *dic = responseObject[@"obj"];
            NSArray *baseArr = dic[@"userBase"];
            baseDic = baseArr[0];
            self.nameLabel.text = baseDic[@"userName"];
            
            NSArray *ProArr = dic[@"userPhoto"];
            ProDic = ProArr[0];
            NSString *ProtraitStr = [NSString stringWithFormat:@"%@%@/%@",API_URL_BASE,ProDic[@"path"], ProDic[@"name"]];
            [self.ProtrairImg sd_setImageWithURL:[NSURL URLWithString:ProtraitStr] placeholderImage:[UIImage imageNamed:@"ic_account"]];
        }
} failure:^(NSError * _Nonnull error) {
    NSLog(@"8888%@", error);
}];
    
    
}

- (void)creatUI{

//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn1.frame = CGRectMake((ScreenW-40*4)/8,0, 40, 40);
//    [btn1 addTarget:self action:@selector(unGetMoney) forControlEvents:UIControlEventTouchUpInside];
//    [btn1 setImage:[UIImage imageNamed:@"X-mian3"] forState:UIControlStateNormal];
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-40*4)/8,40, 40, 20)];
//    label1.text = @"待付款";
//    label1.font = [UIFont systemFontOfSize:12];
//    [self.BigView addSubview:label1];
//    [self.BigView addSubview:btn1];
//    view1 = [[UILabel alloc] initWithFrame:CGRectMake(32, 3, 10, 10)];
//    view1.layer.cornerRadius= 5;
//    view1.layer.borderWidth= 1;
//    view1.layer.borderColor = [[UIColor redColor] CGColor];
//    view1.textColor = [UIColor redColor];
//    view1.font = [UIFont systemFontOfSize:6];
//    view1.textAlignment = NSTextAlignmentCenter;
//    [btn1 addSubview:view1];
//    
//    
//    
//    
//    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn2.frame = CGRectMake((ScreenW-40*4)/8*3+40,0, 40, 40);
//    [btn2 addTarget:self action:@selector(unSendGoods) forControlEvents:UIControlEventTouchUpInside];
//     [btn2 setImage:[UIImage imageNamed:@"X-mian4"] forState:UIControlStateNormal];
//     UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-40*4)/8*3+40,40, 40, 20)];
//    label2.text = @"待发货";
//    label2.font = [UIFont systemFontOfSize:12];
//    [self.BigView addSubview:label2];
//    [self.BigView addSubview:btn2];
//    view2 = [[UILabel alloc] initWithFrame:CGRectMake(33, 3, 10, 10)];
//    view2.layer.cornerRadius= 5;
//    view2.layer.borderWidth= 1;
//    view2.layer.borderColor = [[UIColor redColor] CGColor];
//    view2.textColor = [UIColor redColor];
//    view2.font = [UIFont systemFontOfSize:6];
//    view2.textAlignment = NSTextAlignmentCenter;
//    [btn2 addSubview:view2];
//    
//    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn3.frame = CGRectMake((ScreenW-40*4)/8*5+40*2,0, 40, 40);
//    [btn3 addTarget:self action:@selector(unGetGoods) forControlEvents:UIControlEventTouchUpInside];
//     [btn3 setImage:[UIImage imageNamed:@"X-mian5"] forState:UIControlStateNormal];
//    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-40*4)/8*5+40*2,40, 40, 20)];
//    label3.text = @"待收货";
//    label3.font = [UIFont systemFontOfSize:12];
//    [self.BigView addSubview:label3];
//    [self.BigView addSubview:btn3];
//    view3 = [[UILabel alloc] initWithFrame:CGRectMake(36, 2, 10, 10)];
//    view3.layer.cornerRadius= 5;
//    view3.layer.borderWidth= 1;
//    view3.layer.borderColor = [[UIColor redColor] CGColor];
//    view3.textColor = [UIColor redColor];
//    view3.font = [UIFont systemFontOfSize:6];
//    view3.textAlignment = NSTextAlignmentCenter;
//    [btn3 addSubview:view3];
//    
//    
//    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn4.frame = CGRectMake((ScreenW-40*4)/8*7+40*3,0, 40, 40);
//    [btn4 addTarget:self action:@selector(unGetEvaluation) forControlEvents:UIControlEventTouchUpInside];
//     [btn4 setImage:[UIImage imageNamed:@"X-mian6"] forState:UIControlStateNormal];
//    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-40*4)/8*7+40*3,40, 40, 20)];
//    label4.text = @"待评价";
//    label4.font = [UIFont systemFontOfSize:12];
//    [self.BigView addSubview:label4];
//    [self.BigView addSubview:btn4];
//    view4 = [[UILabel alloc] initWithFrame:CGRectMake(33, 3, 10, 10)];
//    view4.layer.cornerRadius= 5;
//    view4.layer.borderWidth= 1;
//    view4.layer.borderColor = [[UIColor redColor] CGColor];
//    view4.textColor = [UIColor redColor];
//    view4.font = [UIFont systemFontOfSize:6];
//    view4.textAlignment = NSTextAlignmentCenter;
//    [btn4 addSubview:view4];
//    
//    view3.text = @"11";
}

- (void)unGetMoney{
    
}
- (void)unSendGoods{
    
}
- (void)unGetGoods{
    
}
- (void)unGetEvaluation{
    
}


- (IBAction)OwnerProtraitBtn:(UIButton *)sender {
    MyCountViewController *myAccount = [[MyCountViewController alloc] init];
    myAccount.BaseDic = baseDic;
    myAccount.ProtrDic= ProDic;
    [self.navigationController pushViewController:myAccount animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cell1 = @"cell";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell1];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:self options:nil] lastObject];
    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.contentLabe.text = @"业主认证";
            cell.MyProtraitImg.image = [UIImage imageNamed:@"X-mian7"];
        }else if (indexPath.row==1){
            cell.contentLabe.text = @"我的房子";
            cell.MyProtraitImg.image = [UIImage imageNamed:@"X-mian8"];
        }else if (indexPath.row==2){
            cell.contentLabe.text = @"我的圈子";
            cell.MyProtraitImg.image = [UIImage imageNamed:@"X-mian9"];
        }
    }else{
        if (indexPath.row ==0) {
            cell.contentLabe.text = @"我的闲置";
            cell.MyProtraitImg.image = [UIImage imageNamed:@"X-mian14"];
        }else{
            cell.contentLabe.text = @"意见反馈";
            cell.MyProtraitImg.image = [UIImage imageNamed:@"X-mian15"];
            
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            OwnerDidCerViewController *ownerDVC = [[OwnerDidCerViewController alloc] init];
            [self.navigationController pushViewController:ownerDVC animated:YES];
        }else if (indexPath.row==1){
            MyCommunityViewController *MyComVC = [[MyCommunityViewController alloc] init];
            [self.navigationController pushViewController:MyComVC animated:YES];
        }else{
            MyCircleViewController *circleVC = [[MyCircleViewController alloc] init];
            [self.navigationController pushViewController:circleVC animated:YES];
        }
    }else{
        if (indexPath.row==0) {
            MySecondHandVC *myRefreshVC = [[MySecondHandVC alloc] init];
            [self.navigationController pushViewController:myRefreshVC animated:YES];
        }else{
            MyOpinionViewController *myOpintionVC = [[MyOpinionViewController alloc] init];
            [self.navigationController pushViewController:myOpintionVC animated:YES];
        }
    }
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
