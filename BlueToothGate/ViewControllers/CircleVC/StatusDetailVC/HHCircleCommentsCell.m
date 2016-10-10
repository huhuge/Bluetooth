//
//  HHCircleCommentsCell.m
//  BlueToothGate
//
//  Created by JeroMac on 2016/9/28.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHCircleCommentsCell.h"
#define CommonWidth 30

@implementation HHCircleCommentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCellDataWithDic:(NSDictionary *)dic{
    NSString *sendName    = [dic objectForKey:@"sendName"];
    NSString *tureName    = [dic objectForKey:@"trueName"];
    NSString *content     = [dic objectForKey:@"contents"];
    NSString *sendUser_ID = [dic objectForKey:@"sendUser_id"];
    NSString *user_ID     = [dic objectForKey:@"user_id"];
    NSString *communityCircleReply_id = [dic objectForKey:@"communityCircleReply_id"];
    
    _sendNameWidth.constant = [self getStringRect_:sendName andWidth:0 Height:20].width+10;
    _trueNameWidth.constant = [self getStringRect_:tureName andWidth:0 Height:20].width+10;

    [_btnSendName setTitle:sendName forState:UIControlStateNormal];
    NSString *ID1 = [NSString stringWithFormat:@"%@,%@",sendUser_ID,communityCircleReply_id];
    [_btnSendName setTitle:ID1 forState:UIControlStateSelected];
    
    [_btnTrueName setTitle:tureName forState:UIControlStateNormal];
    NSString *ID2 = [NSString stringWithFormat:@"%@,%@",user_ID,communityCircleReply_id];
    [_btnTrueName setTitle:ID2 forState:UIControlStateSelected];
    _labContent.text = content;

    if ([[dic objectForKey:@"type"]longValue] == 1) {//回复帖子
        _labReply.hidden    = YES;
        _btnTrueName.hidden = YES;
        _contentLabX.constant = _sendNameWidth.constant;
        self.contentHeight.constant = [self getStringRect_:content andWidth:ScreenW-90-_sendNameWidth.constant Height:0].height/15.6*16;

    }else{//回复评论
        _labReply.hidden      = NO;
        _btnTrueName.hidden   = NO;
        _replyLabX.constant   = _sendNameWidth.constant;
        _contentLabX.constant = _replyLabX.constant+CommonWidth+_trueNameWidth.constant;
        self.contentHeight.constant = [self getStringRect_:content andWidth:ScreenW-90-_sendNameWidth.constant-_trueNameWidth.constant-CommonWidth Height:0].height/15.5*16;

    }
    

}

#pragma mark ---获取字符串的大小  ios6---======================================
- (CGSize)getStringRect_:(NSString*)aString andWidth:(CGFloat )width Height:(CGFloat )height{
    if (width>0) {
        CGSize size = CGSizeMake(width,2000); //设置一个行高上限
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        CGSize labelsize = [aString boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        return  labelsize;

    }else{
        CGSize size = CGSizeMake(300,height); //设置一个宽度上限
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        CGSize labelsize = [aString boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        return  labelsize;

    }
}


@end
