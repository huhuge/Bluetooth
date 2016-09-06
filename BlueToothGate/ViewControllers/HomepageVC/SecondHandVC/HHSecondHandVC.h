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


@end
