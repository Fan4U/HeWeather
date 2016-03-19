//
//  NowWeather.m
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "NowWeather.h"
#import "CondInNow.h"
#import "WindInNow.h"
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
