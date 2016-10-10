//
//  HHAddressInfoModel.m
//  BlueToothGate
//
//  Created by JeroMac on 16/9/7.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHAddressInfoModel.h"

@implementation HHAddressInfoModel

-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"myID"];
//        self.myID = value;
    }
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
