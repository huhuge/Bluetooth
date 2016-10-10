//
//  HHCircleModel.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/30.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHCircleModel : NSObject

@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, strong) NSString *deleteStatus;
@property (nonatomic, strong) NSArray *favorAll;//点赞数组
@property (nonatomic, strong) NSString *headNsme;
@property (nonatomic, strong) NSString *headPath;
@property (nonatomic, strong) NSString *myID;
@property (nonatomic, strong) NSString *imgs;
@property (nonatomic, strong) NSArray *listFavorsReply;//评论数组
@property (nonatomic, strong) NSString *publishTiame;
@property (nonatomic, strong) NSString *residentialInfo_id;
@property (nonatomic, strong) NSString *residentialName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *trueName;
@property (nonatomic, strong) NSString *user_id;


@end
