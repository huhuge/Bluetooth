//
//  HHHomepageVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/16.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHHomepageVC : UIViewController

@property (weak, nonatomic  ) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView           *headerView;
@property (weak, nonatomic  ) IBOutlet UIView           *badgeView;
@property (weak, nonatomic) IBOutlet UIButton *btnTitle;

@end
