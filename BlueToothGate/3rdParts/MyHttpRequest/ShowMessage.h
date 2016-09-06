//
//  ShowMessage.h
//  WXT
//
//  Created by SGB on 15/11/9.
//  Copyright © 2015年 济南工程职业技术学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowMessage : NSObject
#pragma mark 纯文本的消息提示
+(void)showTextOnly:(NSString *)strMessage messageView:(UIView *)viewInfo;
#pragma mark 自定义图片文字提示
+(void)showCustomViewWitnMessage:(NSString *)message inView:(UIView *)viewInfo;
#pragma mark 信息加载时返回一个实例MBProgressHUD
+(MBProgressHUD *)showLoadingData:(UIView *)viewInfo;
+(MBProgressHUD *)showLoadingData:(UIView *)viewInfo strMessage:(NSString*)strMessage;

@end

