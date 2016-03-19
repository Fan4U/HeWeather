//
//  Aqi.m
//  Final
//
//  Created by pro on 16/3/15.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "Aqi.h"
#import "City.h"
@implementation Aqi


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"city" : @"city"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"city" : [City class]};
}
@end
