//
//  StoreViewController.h
//  BlueToothGate
//
//  Created by guobao on 16/9/13.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController

@property (nonatomic, strong) NSString *StoreID;//店铺ID

@property (weak, nonatomic) IBOutlet UILabel *StoreNAme;

@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSString *nameStr;
@end
