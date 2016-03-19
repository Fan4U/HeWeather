//
//  HourlyForecast.m
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "HourlyForecast.h"
#import "WindInHour.h"
@implementation HourlyForecast

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"presInHour" : @"pres",
             @"windInHour" : @"wind",
             @"humInHour" : @"hum",
             @"tmpInHour" : @"tmp",
             @"popInHour" : @"pop",
             @"dateInHour" : @"date"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"windInHour" : [WindInHour class]};
}

@end
