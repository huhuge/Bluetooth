//
//  HHAddVillageVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/22.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHAddVillageVC : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineOne_x;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTwo_x;

@property (weak, nonatomic) IBOutlet UIButton *btnProvence;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;
@property (weak, nonatomic) IBOutlet UIButton *btnArea;

@property (weak, nonatomic) IBOutlet UILabel *labProvence;
@property (weak, nonatomic) IBOutlet UILabel *labCity;
@property (weak, nonatomic) IBOutlet UILabel *labArea;

@property (weak, nonatomic) IBOutlet UITextField *TFCommunity;
@property (weak, nonatomic) IBOutlet UITextField *TFBuilding;
@property (weak, nonatomic) IBOutlet UITextField *TFFloor;
@property (weak, nonatomic) IBOutlet UITextField *TFDoorplate;

@property (weak, nonatomic) IBOutlet UIButton *btnAddImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


///数据id
@property (nonatomic, strong) NSString *dataID;
@end
