//
//  HHRemoteVC.m
//  BlueToothGate
//
//  Created by JeroMac on 2016/10/8.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHRemoteVC.h"
#import "HHHomepageCell.h"

@interface HHRemoteVC ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
}

@end

@implementation HHRemoteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayout];
    [self setNib];
}

#pragma mark ---setLayout---======================================
- (void)setLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150, 159)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //    flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
    [self.collectionView setCollectionViewLayout:flowLayout];
}

#pragma mark ---setNib---======================================
- (void)setNib{
    UINib *cellNib = [UINib nibWithNibName:@"HHHomepageCell" bundle:nil];
    
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"simpleCell"];

}


#pragma mark ---collection delegate---=====================================
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"simpleCell";
    HHHomepageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    HHHomepageModel *model = _goodsArray[indexPath.row];
//    [cell setCellDataWithModel:model];
    
    return cell;
}


//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, (ScreenW-300)/3, 0, (ScreenW-300)/3);//分别为上、左、下、右
    //    return UIEdgeInsetsMake((ScreenW-300)/3, (ScreenW-300)/3, 0,0);//分别为
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    kLog(@"%ld",(long)indexPath.row);
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
