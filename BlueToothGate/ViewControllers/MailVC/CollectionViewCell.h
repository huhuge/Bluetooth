//
//  CollectionViewCell.h
//  BlueToothGate
//
//  Created by guobao on 16/9/12.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *GoodsImage;
@property (weak, nonatomic) IBOutlet UILabel *GoodsName;
@property (weak, nonatomic) IBOutlet UILabel *RealyPrice;
@property (weak, nonatomic) IBOutlet UILabel *StorePrice;
@property (weak, nonatomic) IBOutlet UILabel *SoldNum;

@end
