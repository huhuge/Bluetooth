//
//  HHSelectCommunityVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/24.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HHSelectCommunityDelegate <NSObject>

- (void)getCurrentCommunityString:(NSString *)string;

@end



@interface HHSelectCommunityVC : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *labCurrentSel;

@property (weak, nonatomic) id<HHSelectCommunityDelegate>delegate;

@property (nonatomic, strong) NSString *currentCommunity;



@end
