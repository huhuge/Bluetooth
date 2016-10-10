//
//  HHAddNewPayVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/9/10.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHAddNewPayVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *TFhouse;
@property (weak, nonatomic) IBOutlet UITextField *TFPayType;
@property (weak, nonatomic) IBOutlet UITextField *TFCarNumber;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectHouse;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectType;

@property (nonatomic, strong) NSString *dataID;
@property (nonatomic, strong) NSString *carNumber;

@property (nonatomic, strong) NSString *house_from_fommer;
@property (nonatomic, strong) NSString *houseID_from_fommer;
@property (nonatomic, strong) NSString *type_from_fommer;;
@property (nonatomic, strong) NSString *type_id_form_fommer;
@end
