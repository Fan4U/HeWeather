//
//  CitiesModel.m
//  Final
//
//  Created by pro on 16/3/14.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "CitiesModel.h"
#import "Province.h"
@implementation CitiesModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"province" : @"城市代码"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"province" : [Province class]};
}

@end
