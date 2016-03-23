//
//  HeWeather.m
//  和风Weather
//
//  Created by pro on 16/3/3.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "HeWeather.h"

@implementation HeWeather : NSObject 

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"weather" : @"HeWeather data service 3.0"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"weather" : [Weather class]};
}

@end


/**
 *  天气数据 数组
 */
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
             @"aqi" : [Aqi class]};
}
@end

/**
 *  空气质量
 */
@implementation Aqi
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"city" : @"city"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"city" : [City class]};
}
@end

/**
 *  空气质量--城市
 */
@implementation City
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"aqi" : @"aqi",
             @"co" : @"co",
             @"no2" : @"no2",
             @"o3" : @"o3",
             @"pm10" : @"pm10",
             @"pm25" : @"pm25",
             @"qlty" : @"qlty",
             @"so2" : @"so2",};
}
@end

/**
 *  基本信息
 */
@implementation Basic

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cnty" : @"cnty",
             @"cityID" : @"id",
             @"lat" : @"lat",
             @"city" : @"city",
             @"lon" : @"lon",
             @"update" : @"update"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"update" : [Update class]};
}

@end

/**
 *  基本信息 --Update
 */
@implementation Update

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"loc" : @"loc",
             @"utc" : @"utc"};
}

@end

/**
 *  一周预报
 */
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

/**
 *  一周预报 -- 天文信息
 */
@implementation AstroDLY

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"ss" : @"ss",
             @"sr" : @"sr",};
}

@end

/**
 *  一周预报 -- 天气状况
 */
@implementation CondDLY

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"txtd" : @"txt_d",
             @"coden" : @"code_n",
             @"coded" : @"code_d",
             @"txtn" : @"txt_n"};
}

@end

/**
 *  一周预报 -- 温度
 */
@implementation TmpDLY

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"max" : @"max",
             @"min" : @"min",};
}

@end

/**
 *  一周预报 -- 风
 */
@implementation WindDLY

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"dirDLY" : @"dir",
             @"degDLY" : @"deg",
             @"scDLY" : @"sc",
             @"spdDLY" : @"spd"};
}

@end

/**
 *  时段预报
 */
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

/**
 *  时段预报 -- 风
 */
@implementation WindInHour

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"dirInHour" : @"dir",
             @"degInHour" : @"deg",
             @"scInHour" : @"sc",
             @"spdInHour" : @"spd",};
}

@end

/**
 *  实况天气
 */
@implementation NowWeather

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"condInNow" : @"cond",
             @"windInNow" : @"wind",
             @"humInNow" : @"hum",
             @"pcpnInNow" : @"pcpn",
             @"tmpInNow" : @"tmp",};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"condInNow" : [CondInNow class],
             @"windInNow" : [WindInNow class]};
}

@end

/**
 *  实况天气 -- 状况
 */
@implementation CondInNow

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"codeInNow" : @"code",
             @"txtInNow" : @"txt"};
}

@end

/**
 *  实况天气 -- 风
 */
@implementation WindInNow

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"scInNow" : @"sc",
             @"spdInNow" : @"spd",
             @"dirInNow" : @"dir"};
}

@end

/**
 *  生活建议
 */
@implementation Suggestion

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"drsg" : @"drsg",
             @"flu" : @"flu",
             @"sport" : @"sport",
             @"comf" : @"comf",
             @"trav" : @"trav",
             @"cw" : @"cw",
             @"uv" : @"uv"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"drsg" : [Drsg class],
             @"flu" : [Flu class],
             @"sport" : [Sport class],
             @"comf" : [Comf class],
             @"trav" : [Trav class],
             @"cw" : [Cw class],
             @"uv" : [Uv class]};
}

@end

@implementation Drsg
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"brf" : @"brf",
             @"txt" : @"txt",};
}
@end

@implementation Flu
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"brf" : @"brf",
             @"txt" : @"txt",};
}
@end

@implementation Sport
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"brf" : @"brf",
             @"txt" : @"txt",};
}
@end

@implementation Comf
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"brf" : @"brf",
             @"txt" : @"txt",};
}
@end

@implementation Trav
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"brf" : @"brf",
             @"txt" : @"txt",};
}
@end

@implementation Cw
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"brf" : @"brf",
             @"txt" : @"txt",};
}
@end

@implementation Uv
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"brf" : @"brf",
             @"txt" : @"txt",};
}
@end



