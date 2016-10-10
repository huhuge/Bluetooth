//
//  HHRepairCell.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHRepairCell.h"

@implementation HHRepairCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataWithModel:(HHRepairListModel *)model{
    
    [self.headImgVie sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",API_URL_BASE,model.attachPath,model.attachName]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.labHouse.text      = [NSString stringWithFormat:@"%@-%@-%@-%@",model.residentialName,model.buildingName,model.floor,model.houseNum];
    self.labRepairType.text = [NSString stringWithFormat:@"报修：%@",model.repairTypeName];
    self.labTime.text       = [self changeTimeFormatWithStamp:model.addTime];
    NSInteger status = model.status.integerValue;
    if (status == 0){
        self.labStatus.text = @"申请中";
        self.labStatus.backgroundColor = [UIColor orangeColor];
    }else if (status == 1){
        self.labStatus.text = @"已取消";
        self.labStatus.backgroundColor = [UIColor redColor];

    }else if (status == 2){
        self.labStatus.text = @"处理中";
        self.labStatus.backgroundColor = [UIColor orangeColor];

    }else if (status == 3){
        self.labStatus.text = @"已修理";
        self.labStatus.backgroundColor = kRGBColor(128, 189, 66);

    }else if (status == 4){
        self.labStatus.text = @"无法处理";
        self.labStatus.backgroundColor = [UIColor redColor];

    }
    
    
}

-(NSString *)changeTimeFormatWithStamp:(NSString *)stamp{
    if ([stamp isEqualToString:@""]||stamp.length == 0) {
        return @"时间不详";
    }else{
        NSArray *arr = [stamp componentsSeparatedByString:@"T"];
        return arr[0];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
