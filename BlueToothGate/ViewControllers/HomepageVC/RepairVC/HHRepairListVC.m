//
//  HHRepairListVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHRepairListVC.h"
#import "HHRepairCell.h"
#import "HHRepairDetailVC.h"
#import "HHRepairTypeModel.h"
#import "HHRepairListModel.h"

@interface HHRepairListVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _flag;
    NSMutableArray *_dataArray;
}

@end

@implementation HHRepairListVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setData];
    
    [self setUI];
    
    [self initTabView];
    
    [self getRepairListWhitTypeID:@""];
}

#pragma mark ---Data---======================================
- (void)setData{
    _dataArray = [NSMutableArray new];
}

#pragma mark ---initUI---======================================
- (void)setUI{
    _TFType.layer.borderColor = kRGBColor(228, 228, 228).CGColor;
    _TFType.layer.borderWidth = 0.5;
    if (_displayArray.count) {
        _TFType.text = _displayArray[0];
    }
    
}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHRepairCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.00;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return 10;
    return _dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  78;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHRepairCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHRepairCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }
    HHRepairListModel *model = _dataArray[indexPath.row];
    [cell setDataWithModel:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.row);
    HHRepairListModel *model = _dataArray[indexPath.row];

    HHRepairDetailVC *nextVC = [HHRepairDetailVC new];
    nextVC.model             =  model;
    [self.navigationController pushViewController:nextVC animated:YES];
    
    
}

#pragma mark ---选择类型---=====================================
- (IBAction)selectType:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFType.frame.origin.x, _TFType.frame.origin.y+30+64, _TFType.frame.size.width, 120) selectData:_displayArray action:^(NSInteger index) {
        
        _TFType.text = _displayArray[index];
        _flag = index;
        
    } animated:YES];

}

#pragma mark ---查询---=====================================
- (IBAction)searchAction:(UIButton *)sender {
    
    HHRepairTypeModel *model = _typeArray[_flag];
    [self getRepairListWhitTypeID:model.myID];

}

#pragma mark ---获取列表---======================================
- (void)getRepairListWhitTypeID:(NSString *)idString{
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    NSString *ID = [NSString stringWithFormat:@"%@",idString];
    if (ID.length != 0) {
        [param setObject:idString forKey:@"repairTypeId"];
    }
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:HHUser_info_userID] forKey:@"userId"];
    
    [[HYHttp sharedHYHttp]POST:GetRepairApplyUrl parameters:param success:^(id  _Nonnull responseObject) {
//        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            [_dataArray removeAllObjects];
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows     = [obj objectForKey:@"rows"];
            
            for (NSDictionary *dic in rows) {
                HHRepairListModel *model = [HHRepairListModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        
    } failure:^(NSError * _Nonnull error) {
        kLog(@"fail");
    }];
    
    
}

#pragma mark ---back---=====================================
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
