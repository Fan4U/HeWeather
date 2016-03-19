//
//  Update.m
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "Update.h"

@implementation Update

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"loc" : @"loc",
             @"utc" : @"utc"};
}

@end
