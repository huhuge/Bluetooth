//
//  HHCircleVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/16.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHCircleVC.h"
#import "HHCircleCell.h"
#import "HHPublicStatusVC.h"

BOOL isExercise;
NSString *sex;
NSArray *testArray;

@interface HHCircleVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_dataArray;
    NSMutableArray *_seleArray;
    HHPublicStatusVC *pvc;
}

@end

@implementation HHCircleVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (isExercise) {
//        kLog(@"success");
    }
    if (sex) {
//        kLog(@"----%@-----",sex);
    }
    if (testArray.count) {
//        kLog(@"%@",testArray);
    }
    if (SharedAppDelegate.testStr) {
//        kLog(@"%@",SharedAppDelegate.testStr);
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setData];

    [self initTabView];
    
}

#pragma mark ---setData---======================================
- (void)setData{
    _dataArray = [NSMutableArray new];
    _seleArray = [NSMutableArray new];
}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHCircleCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1.00001;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    //    return _dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  227;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHCircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }
    
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.section];

    [cell setDataWithModel:nil andisShowComment:[_seleArray containsObject:index]?YES:NO];
    cell.btnComment.tag     = indexPath.section;
    cell.btnPrise.tag       = indexPath.section;
    cell.btnMakeComment.tag = indexPath.section;
    
    [cell.btnComment addTarget:self action:@selector(showFunctionView:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnPrise addTarget:self action:@selector(setPrize:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnMakeComment addTarget:self action:@selector(setComment:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.section);
  
}


#pragma mark ---发布圈子---======================================
- (IBAction)turnToPublic:(UIButton *)sender {
    HHPublicStatusVC *nextVC = [HHPublicStatusVC new];
    nextVC.block = ^(NSString * test){
        if (test) {
            kLog(@"+++%@+++",test);
        }else{
            kLog(@"---");
        }
    };

    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark ---展示评论---======================================
- (void)showFunctionView:(UIButton*)sender{
    NSString *index = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    if ([_seleArray containsObject:index]) {
        [_seleArray removeObject:index];
    }else{
        [_seleArray addObject:index];
    }
}

#pragma mark ---评论---======================================
- (void)setComment:(UIButton *)sender{
    kLog(@"comment%ld",(long)sender.tag);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
   [ _tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
   
}

#pragma mark ---点赞---======================================
- (void)setPrize:(UIButton *)sender{
    kLog(@"prize%ld",(long)sender.tag);

}

@end
