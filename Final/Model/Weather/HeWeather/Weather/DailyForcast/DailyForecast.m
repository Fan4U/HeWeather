//
//  DailyForecast.m
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "DailyForecast.h"
#import "AstroDLY.h"
#import "TmpDLY.h"
#import "WindDLY.h"
#import "CondDLY.h"

@implementation DailyForecast

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"astroDLY" : @"astro",
             @"presDLY" : @"pres",
             @"tmpDLY" : @"tmp",
             @"windDLY" : @"wind",
             @"humDLY" : @"hum",
             @"dateDLY" : @"date",
             @"visDLY" : @"vis",
             @"condDLY" : @"cond",
             @"pcpnDLY" : @"pcpn",
             @"popDLY" : @"pop"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"astroDLY" : [AstroDLY class],
             @"tmpDLY" : [TmpDLY class],
             @"windDLY" : [WindDLY class],
             @"condDLY" : [CondDLY class]};
}

@end
