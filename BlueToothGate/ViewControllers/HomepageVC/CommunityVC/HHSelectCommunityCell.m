//
//  HHSelectCommunityCell.m
//  BlueToothGate
//
//  Created by JeroMac on 16/9/9.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHSelectCommunityCell.h"

@implementation HHSelectCommunityCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithModel:(HHSelectCommunityModel *)model{
    self.labName.text = [NSString stringWithFormat:@"%@-%@-%@-%@",model.residentialName,model.buildingName,model.floor,model.houseNum];
    int authentication = [model.authentication intValue];
    switch (authentication){
        case 0:
        {
            self.labStatus.text = @"未认证";
            self.labStatus.backgroundColor = [UIColor redColor];
        }
            break;
        case 1:
        {
            self.labStatus.text = @"认证中";
            self.labStatus.backgroundColor = [UIColor yellowColor];

        }
            break;
        case 2:
        {
            self.labStatus.text = @"认证成功";
            self.labStatus.backgroundColor = kRGBColor(128, 189, 66);

        }
            break;
        case 3:
        {
            self.labStatus.text = @"认证失败";
            self.labStatus.backgroundColor = [UIColor redColor];

        }
            break;
            
        default:
            break;
    }
}

@end
