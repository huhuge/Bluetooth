//
//  AddressTableViewCell.m
//  BlueToothGate
//
//  Created by guobao on 16/9/26.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)addressBtn:(UIButton *)sender {
    self.addressBtn.selected = !self.addressBtn.selected;
    if (self.addressBtn.selected) {
        [self.ADDBtn setImage:[UIImage imageNamed:@"X-input_2"] forState:UIControlStateNormal];
//        self.addressImg.image = [UIImage imageNamed:@"X-input_2"];
        
    }else{
        [self.ADDBtn setImage:[UIImage imageNamed:@"X-input_1"] forState:UIControlStateNormal];
//         self.addressImg.image = [UIImage imageNamed:@"X-input_1"];
    }
    
}

- (IBAction)editorBtn:(UIButton *)sender {
    [self.delegate addressEditor:self.nameLabel.text num:self.numLabel.text address:self.addresslabel.text addressID:self.addressId];
}

- (IBAction)deleteBtn:(UIButton *)sender {
    [self.delegate deleteAddress:self.addressId];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
