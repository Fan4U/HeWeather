//
//  Cities.m
//  Final
//
//  Created by pro on 16/3/14.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "Cities.h"

@implementation Cities

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"cityName" : @"市名",
             @"cityCode" : @"编码"};
}

@end
