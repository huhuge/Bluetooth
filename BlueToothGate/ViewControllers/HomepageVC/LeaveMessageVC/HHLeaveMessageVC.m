//
//  HHLeaveMessageVC.m
//  BlueToothGate
//
//  Created by JeroMac on 2016/9/28.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHLeaveMessageVC.h"
#import "HHLeaveMessageCell.h"

@interface HHLeaveMessageVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    NSMutableArray *_dataArray;
}

@end

@implementation HHLeaveMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self initTabView];
    
    [self GetMessageList];
}

#pragma mark ---获取列表---======================================
- (void)GetMessageList{
    [ShowMessage showLoadingData:self.view strMessage:@"加载中，稍等"];

    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[userDefault objectForKey:HHUser_info_userID] forKey:@"userId"];
    [[HYHttp sharedHYHttp]POST:GetMessageListUrl parameters:param success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            [_dataArray removeAllObjects];
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows = [obj objectForKey:@"rows"];
            for (NSDictionary *dic in rows) {
                [_dataArray addObject:dic];
            }
            [_tableView reloadData];
        }else{
            [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
}

#pragma mark ---留言---======================================
- (IBAction)leaveMessage:(UIButton *)sender {
    NSMutableDictionary *param = [NSMutableDictionary new];
    NSDictionary *dic = [userDefault dictionaryForKey:HHUser_info_selectedCommunity_dic];
    [param setObject:[userDefault objectForKey:HHUser_info_userID] forKey:@"userId"];
    [param setObject:[dic objectForKey:@"residentialInfoId"] forKey:@"residentialId"];
    [param setObject:_TFLeaveMessage.text forKey:@"notes"];
    [[HYHttp sharedHYHttp]POST:LeaveMessageUrl parameters:param success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            _TFLeaveMessage.text = @"";
            [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
            [self GetMessageList];
        }else{
            [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];
            
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];

}


#pragma mark ---Data---======================================
- (void)setData{
    _dataArray = [NSMutableArray new];
}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHLeaveMessageCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  91;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHLeaveMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHLeaveMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }
    NSDictionary *dic = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellDataWithDictionary:dic];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.row);
//    [self.navigationController pushViewController:nextVC animated:YES];
    
}



- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
