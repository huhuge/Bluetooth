//
//  HHHelpPayCell.m
//  BlueToothGate
//
//  Created by JeroMac on 16/9/10.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHHelpPayCell.h"

@implementation HHHelpPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellDataWithModel:(HHHelpPayModel *)model{
    _labName.text = [NSString stringWithFormat:@"%@-%@-%@-%@",model.residentialName,model.buildingName,model.floor,model.houseNum];
    _labSub.text = [NSString stringWithFormat:@"%@%@",@"水费:",model.cardNum];
}

@end
