//
//  HHSelectCommunityVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/24.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHSelectCommunityVC.h"

@interface HHSelectCommunityVC ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *_dataArray;
}

@end

@implementation HHSelectCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"世纪新都",@"东和花园",@"计量综合楼",@"北城天界",@"南陈天骄",@"换了小区",@"什么小区",@"花卉园",@"红旗河沟",@"黄泥磅",@"江北的是吧",@"sm",@"神秘心情",@"哈哈", nil];
    _labCurrentSel.text =   [NSString stringWithFormat:@"当前选择：%@",_currentCommunity];
    
    [self setLayout];
    
    
    
}

#pragma mark ---setLayout---======================================
- (void)setLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(90, 50)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //    flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];

}

#pragma mark ---collection delegate---=====================================
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"myCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 30)];
    label.text      = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row]];
    label.textColor = [UIColor blackColor];
    label.font      = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor     = [UIColor whiteColor];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius  = 2;
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    [cell.contentView addSubview:label];
    return cell;
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, (ScreenW-270)/4, 0, (ScreenW-270)/4);//分别为上、左、下、右
    //    return UIEdgeInsetsMake((ScreenW-300)/3, (ScreenW-300)/3, 0,0);//分别为
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    kLog(@"%ld",(long)indexPath.row);
    _labCurrentSel.text = [NSString stringWithFormat:@"当前选择：%@",_dataArray[indexPath.row]];
    if ([self.delegate respondsToSelector:@selector(getCurrentCommunityString:)]) {
        [self.delegate getCurrentCommunityString:_dataArray[indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
