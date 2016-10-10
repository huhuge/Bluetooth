//
//  HHCircleCommentsCell.h
//  BlueToothGate
//
//  Created by JeroMac on 2016/9/28.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HHCircleCommentsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnTrueName;
@property (weak, nonatomic) IBOutlet UIButton *btnSendName;
@property (weak, nonatomic) IBOutlet UILabel *labReply;//隐藏使用
@property (weak, nonatomic) IBOutlet UILabel *labContent;

//约束

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trueNameWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendNameWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyLabX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabX;

- (void)setCellDataWithDic:(NSDictionary *)dic;


@end
