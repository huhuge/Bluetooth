//
//  MyCommunityTableViewCell.h
//  BlueToothGate
//
//  Created by guobao on 16/8/25.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MyCommunityDelegate <NSObject>

- (void)editorCommunity:(NSDictionary *)comDic;
- (void)deleteCommunity;

@end


@interface MyCommunityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (nonatomic, strong)NSDictionary *communityDic;


@property (nonatomic, assign) id<MyCommunityDelegate>delegate;


@end
