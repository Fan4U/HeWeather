//
//  WindInHour.m
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "WindInHour.h"

@implementation WindInHour

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"dirInHour" : @"dir",
             @"degInHour" : @"deg",
             @"scInHour" : @"sc",
             @"spdInHour" : @"spd",};
}

@end
