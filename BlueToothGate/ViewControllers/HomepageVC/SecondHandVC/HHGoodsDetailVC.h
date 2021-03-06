//
//  HHGoodsDetailVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/29.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSecondHandModel.h"

@interface HHGoodsDetailVC : UIViewController
@property (weak, nonatomic  ) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView      *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;

@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labCommunity;
@property (weak, nonatomic) IBOutlet UILabel *labGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *labDescription;

@property (weak, nonatomic) IBOutlet UIImageView *image_one;
@property (weak, nonatomic) IBOutlet UIImageView *image_two;
@property (weak, nonatomic) IBOutlet UIImageView *image_thr;

@property (weak, nonatomic) IBOutlet UIView  *goodView;
@property (weak, nonatomic) IBOutlet UILabel *labGoodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *labNew;

@property (weak, nonatomic) IBOutlet UIView *roomView;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labRent;

@property (nonatomic, weak) HHSecondHandModel *model;
@property (nonatomic, readwrite) BOOL isHouse;

@end
