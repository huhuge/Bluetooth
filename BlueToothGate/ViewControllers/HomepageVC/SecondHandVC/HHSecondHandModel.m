//
//  HHSecondHandModel.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/29.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHSecondHandModel.h"

@implementation HHSecondHandModel

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
