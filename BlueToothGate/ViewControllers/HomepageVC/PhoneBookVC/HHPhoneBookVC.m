//
//  HHPhoneBookVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/25.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHPhoneBookVC.h"
#import "HHPhoneBookCell.h"

@interface HHPhoneBookVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    ///分组是否展开状态数组
    NSMutableArray *_statusArray;
    ///列表数组
    NSMutableArray *_dataArray;
    ///分组后的数组
    NSMutableArray *_sectionArray;

    
}

@end

@implementation HHPhoneBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self initTabView];
    
    [self getPhoneNumber];
    
    
}

#pragma mark ---请求---======================================
- (void)getPhoneNumber{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:@"36" forKey:@"residentialInfoId"];
    [[HYHttp sharedHYHttp]POST:GetPhoneBookUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        [_dataArray addObjectsFromArray:responseObject];
        kLog(@"%@",_dataArray);
        [_tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark ---setData---======================================
- (void)setData{
    _dataArray = [NSMutableArray new];
    _statusArray = [[NSMutableArray alloc]initWithObjects:@"NO",@"NO",@"NO", nil];
    NSArray *arr1 = @[@1,@2,@3];
    NSArray *arr2 = @[@1,@2];
    NSArray *arr3 = @[@1,@1,@1,@1,@1,@1];
    _sectionArray = [[NSMutableArray alloc]initWithObjects:arr1,arr2,arr3, nil];
}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHPhoneBookCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_statusArray[section] isEqualToString:@"YES"]) {
        NSDictionary *dic = _dataArray[section];
        NSArray *arr = [dic objectForKey:@"children"];
        return arr.count;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *secDic = _dataArray[section];
    NSArray *arr = [secDic objectForKey:@"children"];

    UIView *headerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 10, 10)];

    if ([_statusArray[section]isEqualToString:@"NO"]) {
        imgView.image = [UIImage imageNamed:@"x_fuhe_03"];
    }else{
        imgView.image = [UIImage imageNamed:@"x_zhank_03"];
    }
    [headerView addSubview:imgView];
    
    UILabel *lab  = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 100, 30)];
    lab.font      = [UIFont systemFontOfSize:13];
    lab.textColor = [UIColor blackColor];
    lab.text      = [NSString stringWithFormat:@"%@",[secDic objectForKey:@"text"]];
    [headerView addSubview:lab];
    
    UILabel *lab1  = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW - 50, 10, 50, 30)];
    lab1.font      = [UIFont systemFontOfSize:13];
    lab1.textColor = [UIColor blackColor];
    lab1.text      = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)[arr count],(unsigned long)[arr count]];
    [headerView addSubview:lab1];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame     = CGRectMake(0, 0, ScreenW, 50);
    btn.tag       = section;
    [btn addTarget:self action:@selector(spreadSection:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *secDic = _dataArray[indexPath.section];
    NSArray *arr = [secDic objectForKey:@"children"];
    NSDictionary *child = arr[indexPath.row];
    

    HHPhoneBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHPhoneBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }
    cell.labPhoneNum.text = [child objectForKey:@"text"];
    
    cell.btnCall.tag = indexPath.section * 1000 + indexPath.row;
    [cell.btnCall addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld----%ld",(long)indexPath.section,indexPath.row);
    
    UIButton *btn = [UIButton new];
    btn.tag = indexPath.section * 1000 + indexPath.row;
    [self callPhone:btn];
}


#pragma mark ---call---======================================
- (void)callPhone:(UIButton *)sender{
    kLog(@"%ld",(long)sender.tag);
    
    NSDictionary *secDic = _dataArray[sender.tag/1000];
    NSArray *arr = [secDic objectForKey:@"children"];
    NSDictionary *child = arr[sender.tag%1000];
    NSString *phoneNumber = [child objectForKey:@"code"];
    NSString *name = [child objectForKey:@"text"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"是否拨打%@电话:\n%@",name,phoneNumber] message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ensureAction    = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *allString = [NSString stringWithFormat:@"tel:%@",phoneNumber];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:allString]];
    }];
    UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:ensureAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
   
    
}

#pragma mark ---分组展开---======================================
- (void)spreadSection:(UIButton *)sender{
    
    NSInteger index      = sender.tag;
    if ([_statusArray[index] isEqualToString:@"NO"]) {
        [_statusArray replaceObjectAtIndex:index withObject:@"YES"];
    }else{
        [_statusArray replaceObjectAtIndex:index withObject:@"NO"];

    }
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];

}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




@end
