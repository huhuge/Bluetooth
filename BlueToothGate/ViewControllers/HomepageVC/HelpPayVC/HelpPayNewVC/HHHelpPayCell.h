//
//  HHHelpPayCell.h
//  BlueToothGate
//
//  Created by JeroMac on 16/9/10.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHHelpPayModel.h"

@interface HHHelpPayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labSub;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;


- (void)setCellDataWithModel:(HHHelpPayModel *)model;

@end
