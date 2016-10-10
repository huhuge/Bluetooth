//
//  HHNoticeDetailVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/22.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHNoticeDetailVC.h"

@interface HHNoticeDetailVC ()

@end

@implementation HHNoticeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];

}
#pragma mark ---setData---======================================
- (void)setData{
    self.labTitle.text  = [NSString stringWithFormat:@"%@",self.titleStr];
    self.labTime.text   = [NSString stringWithFormat:@"%@", [self formatTimeWithString:self.timeStr]];
    self.labScans.text  = [NSString stringWithFormat:@"阅读：%@", self.scanStr];
    self.TVcontent.text = [NSString stringWithFormat:@"%@", self.contentStr];
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
