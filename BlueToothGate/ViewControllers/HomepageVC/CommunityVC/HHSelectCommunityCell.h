//
//  HHSelectCommunityCell.h
//  BlueToothGate
//
//  Created by JeroMac on 16/9/9.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSelectCommunityModel.h"

@interface HHSelectCommunityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labStatus;

- (void)setCellWithModel:(HHSelectCommunityModel *)model;

@end
