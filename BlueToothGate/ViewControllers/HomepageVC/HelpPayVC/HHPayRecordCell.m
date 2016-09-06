//
//  HHPayRecordCell.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/25.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHPayRecordCell.h"

@implementation HHPayRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConstraint];
    
}

- (void)setCellWithModel:(HHPayRecordModel *)model{
    
}

#pragma mark ---setConstraint---======================================
- (void)setConstraint{
    _lineOne_x.constant   = ScreenW/5 + 40;
    _lineTwo_x.constant   = 2 * (ScreenW/5) + 30;
    _lineThree_x.constant = 3 * (ScreenW/5) + 20;
    _lineFour_x.constant  = 4 * (ScreenW/5) + 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
