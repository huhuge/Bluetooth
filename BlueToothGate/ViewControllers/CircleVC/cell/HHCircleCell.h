//
//  HHCircleCell.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/30.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHCircleModel.h"

@interface HHCircleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView      *functionView;
@property (weak, nonatomic) IBOutlet UIButton    *btnComment;
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel     *labName;
@property (weak, nonatomic) IBOutlet UILabel     *labThing;
@property (weak, nonatomic) IBOutlet UILabel     *labTime;
@property (weak, nonatomic) IBOutlet UIView      *commentView;
@property (weak, nonatomic) IBOutlet UIButton *btnPrise;
@property (weak, nonatomic) IBOutlet UIButton *btnMakeComment;

@property (weak, nonatomic) IBOutlet UIImageView *contengImage_one;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage_two;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage_three;



- (void)setDataWithModel:(HHCircleModel *)model;


@property (nonatomic, readwrite) CGFloat rowHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contHeight;

@end
