//
//  NoticeCell.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/22.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHNoticeModel.h"

@interface HHNoticeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labDescription;
@property (weak, nonatomic) IBOutlet UILabel *labScans;

- (void)setCellDataWithModel:(HHNoticeModel *)model;

@end
