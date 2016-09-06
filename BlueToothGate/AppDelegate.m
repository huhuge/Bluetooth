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


@interface AppDelegate (){
    CMMotionManager *_manager;
    StaticBlueComplete *_blue;

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initBlueTooth];
    [self initShake];
    
    ///初始化根视图
    HHTabBarVC *tabBarVC = [[HHTabBarVC alloc]init];
    
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:tabBarVC];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];
    
    return YES;
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
//    [_manager startAccelerometerUpdates];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
