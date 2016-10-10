//
//  HHSecondHandCell.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/26.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "MySecondTableViewCell.h"

@implementation MySecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editorMyFree:(UIButton *)sender {
    [self.delegate editorMyFree:self.MyFreeGoodsId];
}

- (IBAction)deleteMyFree:(id)sender {
    [self.delegate deleteMyFree:self.MyFreeGoodsId];
}

- (IBAction)ShowAttention:(id)sender {
    [self.delegate ShowMessage];
    
}


- (void)setCellDataWithModel:(HHSecondHandModel *)model{
    NSArray *imageArr = [model.imgs componentsSeparatedByString:@","];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",API_URL_BASE,model.headImg,model.headImgName]] placeholderImage:GetImage(@"placeholder")];
    [_image_one sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[0]]] placeholderImage:GetImage(@"placeholder")];
    [_image_two sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[1]]] placeholderImage:GetImage(@"placeholder")];
    [_image_thr sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[2]]] placeholderImage:GetImage(@"placeholder")];
    
    _labTitle.text       = [NSString stringWithFormat:@"%@",model.title];
    _labCommunity.text   = [NSString stringWithFormat:@"%@",model.residentialInfoName];
    _labTime.text        = [NSString stringWithFormat:@"%@天前",model.days];
    _labGoodsName.text   = [NSString stringWithFormat:@"%@",model.goodsName];
    _labDescription.text = [NSString stringWithFormat:@"%@",model.goodsDescribe];
    _labGoodsPrice.text  = [NSString stringWithFormat:@"%@",model.price];
    _labPrice.text       = [NSString stringWithFormat:@"%@",model.price];
    _labNew.text         = [NSString stringWithFormat:@"%@成新",model.oldAndNew];
    NSString *type       = [NSString stringWithFormat:@"%@",model.type];
    _labRent.text        = [type isEqualToString:@"0"]?@"租":@"售";
    _labRent.backgroundColor = [type isEqualToString:@"0"]?HHThemeColor:kRGBColor(254, 198, 54);
    
    self.MyFreeGoodsId = model.myID;
}


@end
