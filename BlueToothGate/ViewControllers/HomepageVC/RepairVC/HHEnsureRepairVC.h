//
//  HHEnsureRepairVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHEnsureRepairVC : UIViewController

@property (nonatomic, strong) NSString *repairType;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSMutableArray *imgArray;

@property (weak, nonatomic) IBOutlet UILabel *labRepairType;
@property (weak, nonatomic) IBOutlet UILabel *labContent;

@property (weak, nonatomic) IBOutlet UIImageView *imgView_one;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_two;

@property (weak, nonatomic) IBOutlet UIButton *btnCommit;


@end
