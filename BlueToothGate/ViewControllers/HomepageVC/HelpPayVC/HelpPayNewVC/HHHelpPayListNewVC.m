//
//  HHHelpPayNewVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/9/10.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHHelpPayListNewVC.h"
#import "HHHelpPayCell.h"
#import "HHAddNewPayVC.h"
#import "HHHelpPayModel.h"
#import "HHHelpPayNewVC.h"


@interface HHHelpPayListNewVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_dataArray;
}

@end

@implementation HHHelpPayListNewVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self GetList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self initTabView];
    
    [self GetList];
}

#pragma mark ---setData---======================================
- (void)setData{
    _dataArray = [NSMutableArray new];
}

#pragma mark ---getList---======================================
- (void)GetList{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"userId"];
    [[HYHttp sharedHYHttp]POST:GetPayTypeInfoUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            
            [_dataArray removeAllObjects];
            
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows     = [obj objectForKey:@"rows"];
            for (NSDictionary *dic in rows) {
                HHHelpPayModel *model = [HHHelpPayModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHHelpPayCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  68;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHHelpPayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHHelpPayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }
    HHHelpPayModel *model = _dataArray[indexPath.row];
    [cell setCellDataWithModel:model];
    
    cell.btnEdit.tag      = indexPath.row;
    cell.btnDelete.tag    = indexPath.row;
    [cell.btnEdit addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnDelete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.row);
    
    HHHelpPayModel *model      = _dataArray[indexPath.row];
    HHHelpPayNewVC *nextVC = [HHHelpPayNewVC new];
    
    nextVC.dataID              = model.myID;
    nextVC.carNumber           = model.cardNum;
    nextVC.house_from_fommer   = [NSString stringWithFormat:@"%@-%@-%@-%@",model.residentialName,model.buildingName,model.floor,model.houseNum];
    nextVC.houseID_from_fommer = model.userHoueseInfo_id;
    nextVC.type_from_fommer    = model.typeName;
    nextVC.type_id_form_fommer = model.proxyPayType_id;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ---edit---======================================
- (void)editAction:(UIButton *)sender{

    HHHelpPayModel *model      = _dataArray[sender.tag];
    HHAddNewPayVC *nextVC      = [HHAddNewPayVC new];
    nextVC.dataID              = model.myID;
    nextVC.carNumber           = model.cardNum;
    nextVC.house_from_fommer   = [NSString stringWithFormat:@"%@-%@-%@-%@",model.residentialName,model.buildingName,model.floor,model.houseNum];
    nextVC.houseID_from_fommer = model.userHoueseInfo_id;
    nextVC.type_from_fommer    = model.typeName;
    nextVC.type_id_form_fommer = model.proxyPayType_id;

    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark ---delete---======================================
- (void)deleteAction:(UIButton *)sender{
    
}

- (IBAction)AddNew:(UIButton *)sender {
    
    HHAddNewPayVC *nextVC = [HHAddNewPayVC new];
    
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
