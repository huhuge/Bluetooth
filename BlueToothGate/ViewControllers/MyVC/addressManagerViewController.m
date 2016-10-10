//
//  addressManagerViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "addressManagerViewController.h"
#import "AddressTableViewCell.h"
#import "NewADDAddressViewController.h"
#import "EditorAddressViewController.h"
@interface addressManagerViewController ()<UITableViewDelegate,UITableViewDataSource,EditorAddressDelegate>
{
    UITableView *myTableView;
    NSArray *addressArr;
}
@end

@implementation addressManagerViewController

- (void)viewWillAppear:(BOOL)animated{
     [self getAddressInfo];
}

- (void)viewDidLoad {
    addressArr = [NSArray array];
    [super viewDidLoad];
    [self getAddressInfo];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH-64) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)getAddressInfo{
    NSMutableDictionary *mudic = [NSMutableDictionary new];
    [mudic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"userId"];
    [[HYHttp sharedHYHttp] POST:getGoodsAddress parameters:mudic success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"success"] intValue]) {
            NSDictionary *dic = [NSDictionary new];
            dic = responseObject[@"obj"];
            addressArr = dic[@"addrs"];
//            NSLog(@"3333%@", addressArr);
            [myTableView reloadData];
        }else{
            
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"3333%@", error);
    }];
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    myView.backgroundColor = kRGBColor(235, 235, 235);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, 10, ScreenW-60, 30);
    [btn setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = kRGBColor(255, 100, 66);
    [myView addSubview:btn];
    return myView;
}

- (void)addAddress{
    NewADDAddressViewController *newAddressVC = [[NewADDAddressViewController alloc] init];
    [self.navigationController pushViewController:newAddressVC animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return addressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyAddress = @"cell";
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyAddress];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressTableViewCell" owner:self options:nil] lastObject];
    }
    cell.nameLabel.text = addressArr[indexPath.row][@"trueName"];
    cell.numLabel.text = addressArr[indexPath.row][@"mobile"];
    cell.addresslabel.text = addressArr[indexPath.row][@"area_info"];
    cell.addressId = addressArr[indexPath.row][@"id"];
    cell.delegate = self;
    return cell;

}

- (void)addressEditor:(NSString *)name num:(NSString *)num address:(NSString *)address addressID:(NSString *)addressID{
    EditorAddressViewController *editorVC = [[EditorAddressViewController alloc] init];
    editorVC.addressID = addressID;
    editorVC.nameStr = name;
    editorVC.numStr = num;
    editorVC.addressStr = address;
    [self.navigationController pushViewController:editorVC animated:YES];
}

- (void)deleteAddress:(NSString *)ID{
//    UIAlertController *
    
    UIAlertController *changeAlert = [UIAlertController alertControllerWithTitle:@"确定删除" message:nil  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *SureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *DIC = [NSMutableDictionary dictionary];
        [DIC setObject:ID forKey:@"id"];
        [[HYHttp sharedHYHttp] POST:DeleteGoodsAddress parameters:DIC success:^(id  _Nonnull responseObject) {
//            NSLog(@"%@-----666%@",ID, responseObject);
            if ([responseObject[@"success"] integerValue]) {
                [ShowMessage showTextOnly:responseObject[@"obj"] messageView:self.view];
                [self getAddressInfo];

                [myTableView reloadData];
            }else{
                [ShowMessage showTextOnly:@"删除失败" messageView:self.view];
            }
        } failure:^(NSError * _Nonnull error) {
//            NSLog(@"%@-----666%@",ID, error);
       [ShowMessage showTextOnly:@"删除失败" messageView:self.view];
        }];
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [changeAlert addAction:SureAction];
    [changeAlert addAction:cancleAction];
    [self presentViewController:changeAlert animated:YES completion:nil];
}
- (void)deleteAddress{
    
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
