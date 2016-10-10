//
//  HHRepairDetailVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHRepairDetailVC.h"

@interface HHRepairDetailVC ()

@end

@implementation HHRepairDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.model) {
        [self setUI];
    }
}

#pragma mark ---UI---======================================
- (void)setUI{
    self.TFcontent.text = [NSString stringWithFormat:@"%@",self.model.repairTypeName];
    
    self.TFCommunity.text = [NSString stringWithFormat:@"%@-%@-%@-%@",_model.residentialName,_model.buildingName,_model.floor,_model.houseNum];
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",API_URL_BASE,_model.attachPath,_model.attachName]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.TFTime.text = [NSString stringWithFormat:@"%@",self.model.addTime];
    
    NSInteger status = _model.status.integerValue;
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

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
