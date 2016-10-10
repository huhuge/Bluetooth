//
//  AppDelegate.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/16.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "AppDelegate.h"
#import "HHTabBarVC.h"
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>
#import "StaticBlueComplete.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "HHLoginVC.h"
#import "HHHomepageVC.h"
#import <UserNotifications/UserNotifications.h>

#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>{
    CMMotionManager *_manager;
    StaticBlueComplete *_blue;

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initBlueTooth];
    
    [self initShake];
    
    [self initPushWithOption:launchOptions];
    
    ///初始化根视图
    HHTabBarVC *tabBarVC = [[HHTabBarVC alloc]init];
    
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:tabBarVC];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];
    
    return YES;
}


#pragma mark ---initPush---======================================
- (void)initPushWithOption:(NSDictionary *)launchOptions{
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //Required
    // init Push(2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil  )
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];  

}


#pragma mark ---initShake---======================================
- (void)initShake{
    
    _manager = [[CMMotionManager alloc]init];
    _manager.accelerometerUpdateInterval=10/60.0;
//    [_manager startAccelerometerUpdates];
    //根据自己需求调节x y z
    [_manager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *latestAcc, NSError *error){
        
         if (fabs(_manager.accelerometerData.acceleration.x) > 2.0 || fabs(_manager.accelerometerData.acceleration.y) > 2.0 || fabs(_manager.accelerometerData.acceleration.z) > 2.0){
             
             [_manager stopAccelerometerUpdates];
             AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//振动效果
             static SystemSoundID soundIDTest = 0;
             NSString * path = [[NSBundle mainBundle] pathForResource:@"Sound01" ofType:@"wav"];
             if (path) {
                 AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest );
             }
             AudioServicesPlaySystemSound( soundIDTest );
             
             NSLog(@"我晃动了 。。。。。");

//             [_blue begin];

             
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self initShake];
             });
         }
     }];

}

#pragma mark ---initBlueTooth---======================================
- (void)initBlueTooth{
//    _blue = [[StaticBlueComplete alloc]init];
//    _blue.cardName = @"A0000000";
//    _blue.searchError = @"未找到设备";
//    _blue.searching = @"正在开门，请稍等";
//    _blue.blueName = @"E00001";

}

#pragma mark ---推送方法-注册---=====================================
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required -    DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark ---推送方法-注册失败---=====================================
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error { //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo; if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo]; }
    completionHandler(UNNotificationPresentationOptionAlert);
    //                    Badge Sound Alert
    NSSLog(@"iOS系统，收到通知:%@", [self logDic:userInfo]);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo; if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo]; }
    completionHandler(); //
    kLog(@"iOS10系统，收到通知:%@", [self logDic:userInfo]);

    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler: (void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo]; completionHandler(UIBackgroundFetchResultNewData);
    kLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);

}
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
        // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    
}

    
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [_manager startAccelerometerUpdates];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 自定义跳转不同的页面
//登录页面
-(void)setupLoginViewController
{
    HHLoginVC *logInVc = [[HHLoginVC alloc]init];
    self.window.rootViewController = logInVc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

//首页
-(void)setupHomeViewController
{
    HHHomepageVC *tabBarController = [[HHHomepageVC alloc] init];
    [self.window setRootViewController:tabBarController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}


@end
