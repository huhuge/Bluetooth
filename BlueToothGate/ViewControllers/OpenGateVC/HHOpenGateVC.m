//
//  HHOpenGateVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/16.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHOpenGateVC.h"
#import "StaticBlueComplete.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <AudioToolbox/AudioToolbox.h>

@interface HHOpenGateVC (){
//    StaticBlueComplete *_blue;
}


@end

@implementation HHOpenGateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置允许摇一摇功能
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 并让自己成为第一响应者
    [self becomeFirstResponder];

    [self initBlueTooth];
}

#pragma mark ---初始化蓝牙---======================================
- (void)initBlueTooth{
//    _blue = [[StaticBlueComplete alloc]init];
//    _blue.cardName = @"A0000000";
//    _blue.searchError = @"未找到设备";
//    _blue.searching = @"searching...";

}

#pragma mark - 摇一摇相关方法
// 摇一摇开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    kLog(@"开始摇动");
//    _inputField.text = @"E00001";
//    _blue.blueName = _inputField.text;
//    _blue.blueName = @"E00001";
//    [_blue begin];
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//振动效果
    static SystemSoundID soundIDTest = 0;
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Sound01" ofType:@"wav"];
    if (path) {
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest );
    }
    AudioServicesPlaySystemSound( soundIDTest );

//    return;
}

// 摇一摇取消摇动
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    kLog(@"取消摇动");
    return;
}

// 摇一摇摇动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
        kLog(@"摇动结束");
        static SystemSoundID soundIDTest = 0;
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Sound00" ofType:@"wav"];
        if (path) {
            AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest );
        }
        AudioServicesPlaySystemSound( soundIDTest );
    }
    return;
}


@end
