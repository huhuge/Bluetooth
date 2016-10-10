//
//  HHRepairCell.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHRepairListModel.h"

@interface HHRepairCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImgVie;

@property (weak, nonatomic) IBOutlet UILabel *labHouse;

@property (weak, nonatomic) IBOutlet UILabel *labTime;

@property (weak, nonatomic) IBOutlet UILabel *labRepairType;

@property (weak, nonatomic) IBOutlet UILabel *labStatus;


- (void)setDataWithModel:(HHRepairListModel *)model;

@end
