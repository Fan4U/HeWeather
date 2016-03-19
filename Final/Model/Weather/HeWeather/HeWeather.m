//
//  HeWeather.m
//  和风Weather
//
//  Created by pro on 16/3/3.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "HeWeather.h"
#import "Weather.h"
@implementation HeWeather


+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"weather" : @"HeWeather data service 3.0"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"weather" : [Weather class]};
}

@end
