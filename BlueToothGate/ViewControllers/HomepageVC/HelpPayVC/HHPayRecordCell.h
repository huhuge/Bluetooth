//
//  HHPayRecordCell.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/25.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHPayRecordModel.h"

@interface HHPayRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labWaterFee;
@property (weak, nonatomic) IBOutlet UILabel *labElectricFee;
@property (weak, nonatomic) IBOutlet UILabel *labGasFee;
@property (weak, nonatomic) IBOutlet UILabel *labManageFee;


//约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineOne_x;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTwo_x;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineThree_x;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineFour_x;

- (void)setCellWithModel:(HHPayRecordModel *)model;

@end
