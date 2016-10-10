//
//  HHHelpPayNewVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/9/10.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHHelpPayNewVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *TFhouse;
@property (weak, nonatomic) IBOutlet UITextField *TFType;
@property (weak, nonatomic) IBOutlet UITextField *TFCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *TFmoney;

@property (nonatomic, strong) NSString *dataID;
@property (nonatomic, strong) NSString *carNumber;

@property (nonatomic, strong) NSString *house_from_fommer;
@property (nonatomic, strong) NSString *houseID_from_fommer;
@property (nonatomic, strong) NSString *type_from_fommer;;
@property (nonatomic, strong) NSString *type_id_form_fommer;

@end
