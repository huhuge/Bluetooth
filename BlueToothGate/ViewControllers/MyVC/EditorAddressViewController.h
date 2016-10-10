//
//  EditorAddressViewController.h
//  BlueToothGate
//
//  Created by guobao on 16/9/27.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditorAddressViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *numLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressLabel;

@property (nonatomic, strong)NSString *nameStr;
@property (nonatomic, strong)NSString *numStr;
@property (nonatomic, strong)NSString *addressStr;
@property (nonatomic, strong)NSString *addressID;

@end
