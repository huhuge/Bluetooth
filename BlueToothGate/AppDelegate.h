//
//  AppDelegate.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/16.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SharedAppDelegate ((AppDelegate *)([UIApplication sharedApplication].delegate))

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) NSString *testStr;

@end

