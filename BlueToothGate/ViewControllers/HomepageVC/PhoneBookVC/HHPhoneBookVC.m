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
    
}

#pragma mark ---setData---======================================
- (void)setData{
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
    
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_statusArray[section] isEqualToString:@"YES"]) {
        NSArray *arr = _sectionArray[section];
        return arr.count;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
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
    lab.text      = [NSString stringWithFormat:@"第%d个选项",section];
    [headerView addSubview:lab];
    
    UILabel *lab1  = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW - 50, 10, 50, 30)];
    lab1.font      = [UIFont systemFontOfSize:13];
    lab1.textColor = [UIColor blackColor];
    lab1.text      = [NSString stringWithFormat:@"%d/%d",[_sectionArray[section] count],[_sectionArray[section]count]];
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
    
    HHPhoneBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHPhoneBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }
    
    cell.btnCall.tag = indexPath.section * 1000 + indexPath.row;
    [cell.btnCall addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.row);
    
}


#pragma mark ---call---======================================
- (void)callPhone:(UIButton *)sender{
    kLog(@"%ld",(long)sender.tag);
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
