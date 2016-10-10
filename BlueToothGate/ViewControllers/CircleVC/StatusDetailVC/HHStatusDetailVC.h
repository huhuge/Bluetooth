//
//  HHStatusDetailVC.h
//  BlueToothGate
//
//  Created by JeroMac on 2016/9/28.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHStatusDetailVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *labLikeCount;
@property (weak, nonatomic) IBOutlet UILabel *labLikeName;

@property (weak, nonatomic) IBOutlet UITextField *TFContnet;

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel     *labName;
@property (weak, nonatomic) IBOutlet UILabel     *labThing;
@property (weak, nonatomic) IBOutlet UILabel     *labTime;

@property (weak, nonatomic) IBOutlet UIImageView *contengImage_one;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage_two;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage_three;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@property (nonatomic, strong) NSString *statusID;
@property (nonatomic, strong) NSString *contentStr;

@end
