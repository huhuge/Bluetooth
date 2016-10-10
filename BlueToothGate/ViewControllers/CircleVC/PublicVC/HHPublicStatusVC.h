//
//  HHPublicStatusVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/31.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^valueChangeBlock)(NSString *string);

@interface HHPublicStatusVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *addImg_one;
@property (weak, nonatomic) IBOutlet UIButton *addImg_two;
@property (weak, nonatomic) IBOutlet UIButton *addImg_three;
@property (weak, nonatomic) IBOutlet UITextView *TFcontent;
@property (weak, nonatomic) IBOutlet UITextField *TFtitle;

@property(nonatomic, copy)valueChangeBlock block;

@end
