//
//  HHShopCartCell.m
//  BlueToothGate
//
//  Created by JeroMac on 16/9/12.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHShopCartCell.h"

@implementation HHShopCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellDataWithModel:(HHShopCartModel *)model andSelect:(BOOL)isSelected{

    if (isSelected) {
        _btnSelect.selected = YES;
    }else{
        _btnSelect.selected = NO;
    }
}

- (IBAction)selectOrNot:(UIButton *)sender {
    if (self.funcView.hidden) {
        return;
    }
    sender.selected = !sender.selected;
    
}

#pragma mark ---数量减
- (IBAction)decreaseCount:(UIButton *)sender {
    int count = _TFCount.text.intValue;
    if (count <= 1) {
        return;
    }else{
        count--;
        _TFCount.text = [NSString stringWithFormat:@"%d",count];
    }

}

#pragma mark ---数量加
- (IBAction)increaseCount:(UIButton *)sender {
    int count = _TFCount.text.intValue;
    count++;
    _TFCount.text = [NSString stringWithFormat:@"%d",count];
    

}

@end
