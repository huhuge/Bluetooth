//
//  HHLoginVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/19.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHLoginVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *TFUserName;
@property (weak, nonatomic) IBOutlet UITextField *TFPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIImageView *backImgView;





@property (nonatomic ,assign)BOOL isHideBackBtn;
@end
