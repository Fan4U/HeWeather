//
//  OpenWeatherModel.m
//  Final
//
//  Created by pro on 16/3/21.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "OpenWeatherModel.h"

@implementation CityInOpen
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"name" : @"name"};
}

@end



@implementation OpenWeatherModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"cityInOpen" : @"city"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"cityInOpen" : [CityInOpen class]};
}
@end
