//
//  HHRepairDetailVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHRepairListModel.h"

@interface HHRepairDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *TFcontent;
@property (weak, nonatomic) IBOutlet UIButton *btnStatus;
@property (weak, nonatomic) IBOutlet UITextField *TFCommunity;
@property (weak, nonatomic) IBOutlet UITextField *TFTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *labStatus;

@property (nonatomic, weak) HHRepairListModel *model;

@end
