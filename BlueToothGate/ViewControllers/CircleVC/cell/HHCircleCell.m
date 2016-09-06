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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)makeComments:(UIButton *)sender {
    _functionView.hidden = !_functionView.hidden;
}

- (void)setDataWithModel:(HHCircleModel *)model andisShowComment:(BOOL)isShow{
    
    _functionView.hidden = !isShow;
    
}

#pragma mark ---获取字符串的大小  ios6---======================================
- (CGSize)getStringRect_:(NSString*)aString
{
    CGSize size = CGSizeMake(290,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize labelsize = [aString boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return  labelsize;
}

@end
