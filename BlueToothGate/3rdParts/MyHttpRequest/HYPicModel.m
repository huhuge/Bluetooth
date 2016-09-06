//
//  HYPicModel.m
//  HaiYu
//
//  Created by SGB on 16/6/20.
//  Copyright © 2016年 HaiYu. All rights reserved.
//

#import "HYPicModel.h"

@implementation HYPicModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ : %p> \n{picName : %@ \n pic : %@ \n}", [self class], self,self.picName, self.pic];
}

@end
