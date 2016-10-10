//
//  HHBuildingInfoModel.m
//  BlueToothGate
//
//  Created by JeroMac on 16/9/8.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHBuildingInfoModel.h"

@implementation HHBuildingInfoModel

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
