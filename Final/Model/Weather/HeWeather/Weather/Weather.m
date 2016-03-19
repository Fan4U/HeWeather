//
//  Weather.m
//  和风天气
//
//  Created by pro on 16/3/5.
//  Copyright © 2016年 张帆. All rights reserved.
//
#import "HourlyForecast.h"
#import "DailyForecast.h"
#import "Basic.h"
#import "NowWeather.h"
#import "Suggestion.h"
#import "Aqi.h"

#import "Weather.h"

@implementation Weather

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"hourlyForecast" : @"hourly_forecast",
             @"dailyForecast" : @"daily_forecast",
             @"suggestion" : @"suggestion",
             @"nowWeather" : @"now",
             @"basic" : @"basic",
             @"status" : @"status",
             @"aqi" : @"aqi"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"hourlyForecast" : [HourlyForecast class],
             @"dailyForecast" : [DailyForecast class],
             @"basic" : [Basic class],
             @"nowWeather" : [NowWeather class],
             @"suggestion" : [Suggestion class],
             @"aqi" : [Aqi class]
             //不写status 不是分支 先记着
             };
}


@end
