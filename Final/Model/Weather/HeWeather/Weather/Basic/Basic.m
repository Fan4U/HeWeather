//
//  Basic.m
//  和风天气
//
//  Created by pro on 16/3/5.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "Basic.h"
#import "Update.h"
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
