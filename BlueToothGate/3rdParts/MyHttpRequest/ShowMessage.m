//
//  ShowMessage.m
//  WXT
//
//  Created by SGB on 15/11/9.
//  Copyright © 2015年 济南工程职业技术学院. All rights reserved.
//

#import "ShowMessage.h"

@implementation ShowMessage
#pragma mark 纯文本的消息提示
+(void)showTextOnly:(NSString *)strMessage messageView:(UIView *)viewInfo
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:viewInfo animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = strMessage;
    hud.margin=10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1];
    
}
#pragma mark 自定义图片文字提示
+(void)showCustomViewWitnMessage:(NSString *)message inView:(UIView *)viewInfo
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:viewInfo animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *img_hudImage = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:img_hudImage];
    hud.tintColor = kRGBColor(128, 128, 128);
    hud.square = YES;
    hud.labelColor = [UIColor whiteColor];
    hud.labelFont = [UIFont systemFontOfSize:18];
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.0f];
}
#pragma mark 信息加载时返回一个实例MBProgressHUD
+(MBProgressHUD *)showLoadingData:(UIView *)viewInfo
{
    __weak MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:viewInfo animated:YES];
    
    hud.labelText = @"正在加载";
    hud.labelFont=[UIFont systemFontOfSize:12.0];
    hud.square = YES;
    hud.removeFromSuperViewOnHide=YES;
    
    return hud;
}
#pragma mark 信息加载时返回一个实例MBProgressHUD
+(MBProgressHUD *)showLoadingData:(UIView *)viewInfo strMessage:(NSString*)strMessage
{
    __weak MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:viewInfo animated:YES];
    
    hud.labelText = strMessage;
    hud.labelFont=[UIFont systemFontOfSize:12.0];
    hud.square = YES;
    hud.removeFromSuperViewOnHide=YES;
    
    return hud;
}

@end

