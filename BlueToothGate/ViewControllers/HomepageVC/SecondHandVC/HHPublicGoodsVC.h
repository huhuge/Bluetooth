//
//  HHPublicGoodsVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/26.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPublicGoodsVC : UIViewController

@property (weak, nonatomic  ) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView      *headerView;
@property (strong, nonatomic) IBOutlet UIView      *footerView;

@property (weak, nonatomic) IBOutlet UITextField *TFType;
@property (weak, nonatomic) IBOutlet UITextField *TFSubType;
@property (weak, nonatomic) IBOutlet UITextField *TFCommunity;

@property (weak, nonatomic) IBOutlet UITextField *TFNewOrOld;

@property (weak, nonatomic) IBOutlet UITextField *TFTitle;
@property (weak, nonatomic) IBOutlet UITextField *TFPrice;
@property (weak, nonatomic) IBOutlet UITextView *TVDescription;


@property (weak, nonatomic) IBOutlet UIButton *btnAddImage_one;
@property (weak, nonatomic) IBOutlet UIButton *btnAddImage_two;
@property (weak, nonatomic) IBOutlet UIButton *btnAddImage_thr;
@property (weak, nonatomic) IBOutlet UIButton *btnFace;
@property (weak, nonatomic) IBOutlet UILabel *labFace;
@property (weak, nonatomic) IBOutlet UITextField *TFPhoneNum;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeight;

@property (nonatomic, strong) NSString *MyFreeGoodsId;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (nonatomic, strong) NSString *titleNameStr;

@property (nonatomic, strong) NSString *GoodsClass;

@end
