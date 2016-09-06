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
@interface HHMyVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *view1;
    UILabel *view2;
    UILabel *view3;
    UILabel *view4;
}

@property (nonatomic, strong) UITableView *myTableView;


@end

@implementation HHMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.title = @"我的";
    self.title = @"我的";
    [self creatUI];
     _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+160, ScreenW, ScreenH-160-50-44) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_myTableView];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.scrollEnabled = NO;
    // Do any additional setup after loading the view from its nib.
}


- (void)creatUI{
//    UIView *BigView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 80)];
//    [self.view addSubview:BigView];
//    UIImageView *Pimg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
//    [BigView addSubview:Pimg];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake((ScreenW-40*4)/8,0, 40, 40);
    [btn1 addTarget:self action:@selector(unGetMoney) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setImage:[UIImage imageNamed:@"X-mian3"] forState:UIControlStateNormal];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-40*4)/8,40, 40, 20)];
    label1.text = @"待付款";
    label1.font = [UIFont systemFontOfSize:12];
    [self.BigView addSubview:label1];
    [self.BigView addSubview:btn1];
    view1 = [[UILabel alloc] initWithFrame:CGRectMake(32, 3, 10, 10)];
    view1.layer.cornerRadius= 5;
    view1.layer.borderWidth= 1;
    view1.layer.borderColor = [[UIColor redColor] CGColor];
    view1.textColor = [UIColor redColor];
    view1.font = [UIFont systemFontOfSize:6];
    view1.textAlignment = NSTextAlignmentCenter;
    [btn1 addSubview:view1];
    
    
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake((ScreenW-40*4)/8*3+40,0, 40, 40);
    [btn2 addTarget:self action:@selector(unSendGoods) forControlEvents:UIControlEventTouchUpInside];
     [btn2 setImage:[UIImage imageNamed:@"X-mian4"] forState:UIControlStateNormal];
     UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-40*4)/8*3+40,40, 40, 20)];
    label2.text = @"待发货";
    label2.font = [UIFont systemFontOfSize:12];
    [self.BigView addSubview:label2];
    [self.BigView addSubview:btn2];
    view2 = [[UILabel alloc] initWithFrame:CGRectMake(33, 3, 10, 10)];
    view2.layer.cornerRadius= 5;
    view2.layer.borderWidth= 1;
    view2.layer.borderColor = [[UIColor redColor] CGColor];
    view2.textColor = [UIColor redColor];
    view2.font = [UIFont systemFontOfSize:6];
    view2.textAlignment = NSTextAlignmentCenter;
    [btn2 addSubview:view2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake((ScreenW-40*4)/8*5+40*2,0, 40, 40);
    [btn3 addTarget:self action:@selector(unGetGoods) forControlEvents:UIControlEventTouchUpInside];
     [btn3 setImage:[UIImage imageNamed:@"X-mian5"] forState:UIControlStateNormal];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-40*4)/8*5+40*2,40, 40, 20)];
    label3.text = @"待收货";
    label3.font = [UIFont systemFontOfSize:12];
    [self.BigView addSubview:label3];
    [self.BigView addSubview:btn3];
    view3 = [[UILabel alloc] initWithFrame:CGRectMake(36, 2, 10, 10)];
    view3.layer.cornerRadius= 5;
    view3.layer.borderWidth= 1;
    view3.layer.borderColor = [[UIColor redColor] CGColor];
    view3.textColor = [UIColor redColor];
    view3.font = [UIFont systemFontOfSize:6];
    view3.textAlignment = NSTextAlignmentCenter;
    [btn3 addSubview:view3];
    
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake((ScreenW-40*4)/8*7+40*3,0, 40, 40);
    [btn4 addTarget:self action:@selector(unGetEvaluation) forControlEvents:UIControlEventTouchUpInside];
     [btn4 setImage:[UIImage imageNamed:@"X-mian6"] forState:UIControlStateNormal];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-40*4)/8*7+40*3,40, 40, 20)];
    label4.text = @"待评价";
    label4.font = [UIFont systemFontOfSize:12];
    [self.BigView addSubview:label4];
    [self.BigView addSubview:btn4];
    view4 = [[UILabel alloc] initWithFrame:CGRectMake(33, 3, 10, 10)];
    view4.layer.cornerRadius= 5;
    view4.layer.borderWidth= 1;
    view4.layer.borderColor = [[UIColor redColor] CGColor];
    view4.textColor = [UIColor redColor];
    view4.font = [UIFont systemFontOfSize:6];
    view4.textAlignment = NSTextAlignmentCenter;
    [btn4 addSubview:view4];
    
    view3.text = @"11";
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
    [self.navigationController pushViewController:myAccount animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (ScreenH-160-50-30-64)/8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section==1){
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
            cell.contentLabe.text = @"我的小区";
            cell.MyProtraitImg.image = [UIImage imageNamed:@"X-mian8"];
        }else if (indexPath.row==2){
            cell.contentLabe.text = @"我的圈子";
            cell.MyProtraitImg.image = [UIImage imageNamed:@"X-mian9"];
        }
    }else if (indexPath.section ==1){
        if (indexPath.row==0) {
             cell.contentLabe.text = @"我的积分";
            cell.MyProtraitImg.image = [UIImage imageNamed:@"X-mian10"];
        }else if (indexPath.row==1) {
            cell.contentLabe.text = @"我的评价";
            cell.MyProtraitImg.image = [UIImage imageNamed:@"X-mian12"];
        }else{
            cell.contentLabe.text = @"退货管理";
            cell.MyProtraitImg.image = [UIImage imageNamed:@"X-mian13"];
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
            
        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            
        }else if (indexPath.row==1){
            
        }else{
            
        }
    }else{
        if (indexPath.row==0) {
            
        }else{
            
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
