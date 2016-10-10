//
//  HHRepairTypeModel.m
//  BlueToothGate
//
//  Created by JeroMac on 16/9/9.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHRepairTypeModel.h"

@implementation HHRepairTypeModel

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
