//
//  CollectHeaderView.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/19.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *scrollBackView;


@property (weak, nonatomic) IBOutlet UILabel *labTitle;


@property (weak, nonatomic) IBOutlet UIButton *btnNotice;
@property (weak, nonatomic) IBOutlet UIButton *btnMail;
@property (weak, nonatomic) IBOutlet UIButton *btnRemote;
@property (weak, nonatomic) IBOutlet UIButton *btnHelpPay;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoneNumbers;
@property (weak, nonatomic) IBOutlet UIButton *btnRepair;
@property (weak, nonatomic) IBOutlet UIButton *btnSecondHand;
@property (weak, nonatomic) IBOutlet UIButton *btnLeaveMessage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *FunctionViewHeight;

- (void)setScrollowWithImageArray:(NSArray *)imageArray;

//- (void)setContentWithInfo:()

@end
