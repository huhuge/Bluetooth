//
//  HHCircleCell.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/30.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHCircleCell.h"

@implementation HHCircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imgDistance.constant = (ScreenW-300)/2;
    _headImgView.layer.borderColor = HHBackGroundColor.CGColor;
    _headImgView.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)makeComments:(UIButton *)sender {
    _functionView.hidden = !_functionView.hidden;
}

- (void)setDataWithModel:(HHCircleModel *)model{
    
    self.contHeight.constant = [self getStringRect_:model.contents].height+10;
    
    self.labName.text = [NSString stringWithFormat:@"%@",model.title];
    self.labTime.text = [NSString stringWithFormat:@"%@",model.addTime];
    self.labThing.text = [NSString stringWithFormat:@"%@",model.contents];
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",API_URL_BASE,model.headPath,model.headNsme]] placeholderImage:GetImage(@"placeholder")];
    
    NSArray *imageArr = [model.imgs componentsSeparatedByString:@","];
    if (imageArr.count >= 3) {
        [self.contengImage_one sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[0]]] placeholderImage:GetImage(@"placeholder")];
        [self.contentImage_two sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[1]]] placeholderImage:GetImage(@"placeholder")];
        [self.contentImage_three sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[2]]] placeholderImage:GetImage(@"placeholder")];
    }
    self.rowHeight = [self getStringRect_:model.contents].height;

}

#pragma mark ---获取字符串的大小  ios6---======================================
- (CGSize)getStringRect_:(NSString*)aString
{
    CGSize size = CGSizeMake(ScreenW-90,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize labelsize = [aString boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return  labelsize;
}

@end
