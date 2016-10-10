//
//  HHNoticeDetailVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/22.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHNoticeDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labScans;
@property (weak, nonatomic) IBOutlet UITextView *TVcontent;

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *timeStr;
@property (nonatomic, strong) NSString *scanStr;
@property (nonatomic, strong) NSString *contentStr;


@end
