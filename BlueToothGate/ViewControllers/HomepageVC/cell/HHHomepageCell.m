//
//  HHHomepageCell.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/19.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHHomepageCell.h"

@implementation HHHomepageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius  = 5;
    self.backView.layer.borderWidth   = 0.5;
    self.backView.layer.borderColor   = kRGBColor(191, 191, 191).CGColor;
}



@end
