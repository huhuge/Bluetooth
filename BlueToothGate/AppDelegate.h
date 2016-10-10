//
//  AppDelegate.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/16.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *appKey = @"a8bd792ac332405b1d1cd04a";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

#define SharedAppDelegate ((AppDelegate *)([UIApplication sharedApplication].delegate))

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) NSString *testStr;


//登录页面
-(void)setupLoginViewController;

//跳转到首页
-(void)setupHomeViewController;


@end

