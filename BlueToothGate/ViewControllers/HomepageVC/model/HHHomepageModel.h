//
//  HHHomepageModel.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/22.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHHomepageModel : NSObject

@property (nonatomic, strong) NSString *myID;//商品id
@property (nonatomic, strong) NSString *goods_store_id;//店铺id
@property (nonatomic, strong) NSString *goods_name;//商品 名称
@property (nonatomic, strong) NSString *goods_price;//商品价格
@property (nonatomic, strong) NSString *store_price;//店铺价格
@property (nonatomic, strong) NSString *path;//图片路径
@property (nonatomic, strong) NSString *name;//图片名
@property (nonatomic, strong) NSString *addTime;//添加时间


@end
