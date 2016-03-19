//
//  WindInNow.m
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "WindInNow.h"

@implementation WindInNow

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"scInNow" : @"sc",
             @"spdInNow" : @"spd",
             @"dirInNow" : @"dir"};
}

@end
