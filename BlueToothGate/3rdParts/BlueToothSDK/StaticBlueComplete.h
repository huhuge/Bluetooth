//
//  StaticBlueComplete.h
//  StaticBlueComplete
//
//  Created by mac on 16/2/18.
//  Copyright © 2016年 孙晓东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaticBlueComplete : NSObject

/**
 *  @author 孙晓东, 16-06-15 14:07:12
 *
 *  蓝牙名（长度为六位字符)
 */
@property(nonatomic,strong)NSString *blueName;
/**
 *  @author 孙晓东, 16-06-15 14:07:28
 *
 *  卡号（长度为八位字符
 */
@property(nonatomic,strong)NSString *cardName;
/**
 *  @author 孙晓东, 16-06-15 14:07:42
 *
 *  搜寻错误
 */
@property(nonatomic,strong)NSString *searchError;
/**
 *  @author 孙晓东, 16-06-15 14:07:54
 *
 *  搜寻中
 */
@property(nonatomic,strong)NSString *searching;
/**
 *  @author 孙晓东, 16-06-15 14:07:06
 *
 *  初始化
 *
 *  @return 初始化对象
 */
- (instancetype)init;
/**
 *  @author 孙晓东, 16-07-15 14:07:30
 *
 *  开始搜寻
 */
- (void)begin;
/**
 *  @author 孙晓东, 16-07-15 14:07:56
 *
 *  结束搜寻
 */
- (void)end;
@end
