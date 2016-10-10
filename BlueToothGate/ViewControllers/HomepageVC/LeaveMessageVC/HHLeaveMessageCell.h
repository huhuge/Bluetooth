//
//  HHLeaveMessageCell.h
//  BlueToothGate
//
//  Created by JeroMac on 2016/9/28.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHLeaveMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labCommunity;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labMyMessage;
@property (weak, nonatomic) IBOutlet UILabel *labReply;

- (void)setCellDataWithDictionary:(NSDictionary *)dic;

@end
