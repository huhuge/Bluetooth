//
//  HHSecondHandVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/26.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHSecondHandVC : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *topSeg;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineOne_x;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTwo_x;

@property (weak, nonatomic) IBOutlet UILabel *labCommunity;
@property (weak, nonatomic) IBOutlet UILabel *labProduct;
@property (weak, nonatomic) IBOutlet UILabel *labNewDegree;

@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;
@property (weak, nonatomic) IBOutlet UIButton *btnCommunity;
@property (weak, nonatomic) IBOutlet UILabel *labQu;
@property (weak, nonatomic) IBOutlet UILabel *labXiaoqu;

@property (weak, nonatomic) IBOutlet UIButton *btnEnsure;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;


@property (weak, nonatomic) IBOutlet UIView *coverView;

@end
