//
//  City.m
//  Final
//
//  Created by pro on 16/3/15.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "City.h"

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
