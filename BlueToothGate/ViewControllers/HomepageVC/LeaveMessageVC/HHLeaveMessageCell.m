//
//  HHLeaveMessageCell.m
//  BlueToothGate
//
//  Created by JeroMac on 2016/9/28.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHLeaveMessageCell.h"

@implementation HHLeaveMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCellDataWithDictionary:(NSDictionary *)dic{
    
    [self getReplyWithID:[dic objectForKey:@"id"]];
    self.labCommunity.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"residentialName"]];
    self.labTime.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"addTime"]];
    self.labMyMessage.text = [NSString stringWithFormat:@"我的留言：%@",[dic objectForKey:@"notes"]];
    self.labCommunity.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"residentialName"]];
    
}

#pragma mark ---获取回复---======================================
- (void)getReplyWithID:(NSString *)idString{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:idString forKey:@"id"];
    [[HYHttp sharedHYHttp]POST:ReplyMessageUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows = [obj objectForKey:@"rows"];
            if (rows.count) {
                NSDictionary *info =rows[0];
                _labReply.text = [NSString stringWithFormat:@"%@",[info objectForKey:@"reply"]];
            }
        }else{
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];

}

@end
