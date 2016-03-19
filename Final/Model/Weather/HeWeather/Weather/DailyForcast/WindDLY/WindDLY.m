//
//  WindDLY.m
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "WindDLY.h"

@implementation WindDLY

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"dirDLY" : @"dir",
             @"degDLY" : @"deg",
             @"scDLY" : @"sc",
             @"spdDLY" : @"spd"};
}

@end
