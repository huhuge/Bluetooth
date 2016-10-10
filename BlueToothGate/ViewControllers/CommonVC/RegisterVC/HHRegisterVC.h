//
//  HHRegisterVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/22.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHRegisterVC : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnSendCode;
@property (weak, nonatomic) IBOutlet UITextField *TFUserName;
@property (weak, nonatomic) IBOutlet UITextField *TFPassword;
@property (weak, nonatomic) IBOutlet UITextField *TFPasswordAgain;
@property (weak, nonatomic) IBOutlet UITextField *TFPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *TFCaptcha;

@end
