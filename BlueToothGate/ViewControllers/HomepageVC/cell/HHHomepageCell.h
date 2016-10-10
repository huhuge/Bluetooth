//
//  HHHomepageCell.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/19.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHHomepageModel.h"

@interface HHHomepageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *proImgView;
@property (weak, nonatomic) IBOutlet UILabel *labDescription;
@property (weak, nonatomic) IBOutlet UILabel *labNowPrice;
@property (weak, nonatomic) IBOutlet UILabel *labOriginPrice;
@property (weak, nonatomic) IBOutlet UILabel *labSalt;

- (void)setCellDataWithModel:(HHHomepageModel *)model;

@end
