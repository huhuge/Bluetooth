//
//  HHWillRepairVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHWillRepairVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *TFRepairType;
@property (weak, nonatomic) IBOutlet UITextView *TVContent;
@property (weak, nonatomic) IBOutlet UIButton *btnEnsure;
@property (weak, nonatomic) IBOutlet UILabel *labPlacehoder;



@property (weak, nonatomic) IBOutlet UIButton *btnAddImage_one;
@property (weak, nonatomic) IBOutlet UIButton *btnAddImage_two;

@property (weak, nonatomic) IBOutlet UIButton *btnDelImg_one;
@property (weak, nonatomic) IBOutlet UIButton *btnDelImg_two;

@end
