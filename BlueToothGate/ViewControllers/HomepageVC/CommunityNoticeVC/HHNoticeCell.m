//
//  NoticeCell.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/22.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHNoticeCell.h"

@implementation HHNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellDataWithModel:(HHNoticeModel *)model{
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",API_URL_BASE,model.photopPath,model.photoName]] placeholderImage:GetImage(@"placeholder")];
    
    self.labTime.text        = [NSString stringWithFormat:@"%@",[self formatTimeWithString:model.addTime]];
    self.labDescription.text = [NSString stringWithFormat:@"%@",model.title];
    self.labScans.text       = [NSString stringWithFormat:@"阅读：%@",model.readNumber];
}

#pragma mark ---处理时间格式---======================================
- (NSString *)formatTimeWithString:(NSString *)time{
    if ([time isEqualToString:@""]||time.length == 0) {
        return @"";
    }else{
        NSArray *arr = [time componentsSeparatedByString:@"T"];
        NSArray *dateArray = [arr[0] componentsSeparatedByString:@"-"];
//        NSArray *timeArray = [arr[1] componentsSeparatedByString:@":"];
        return [NSString stringWithFormat:@"%@-%@-%@",dateArray[0],dateArray[1],dateArray[2]];
    }
}


@end
