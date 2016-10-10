//
//  MyCommunityTableViewCell.m
//  BlueToothGate
//
//  Created by guobao on 16/8/25.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "MyCommunityTableViewCell.h"

@implementation MyCommunityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)delegateCommunityBtn:(UIButton *)sender {
    [self.delegate deleteCommunity];
}

- (IBAction)editorCommunityBtn:(UIButton *)sender {
    [self.delegate editorCommunity:self.communityDic];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
