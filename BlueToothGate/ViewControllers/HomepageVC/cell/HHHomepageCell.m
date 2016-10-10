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

- (void)setCellDataWithModel:(HHHomepageModel *)model{
    
   [self.proImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,model.path,model.name]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.labDescription.text = [NSString stringWithFormat:@"%@",model.goods_name];
    self.labNowPrice.text    = [NSString stringWithFormat:@"%@",model.store_price];
    self.labOriginPrice.text = [NSString stringWithFormat:@"￥%@", model.goods_price];
    self.labNowPrice.adjustsFontSizeToFitWidth    = YES;
    self.labOriginPrice.adjustsFontSizeToFitWidth = YES;

    
}

@end
