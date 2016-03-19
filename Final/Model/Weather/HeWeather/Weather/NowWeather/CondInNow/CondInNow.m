//
//  CondInNow.m
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "CondInNow.h"

@implementation CondInNow

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"codeInNow" : @"code",
             @"txtInNow" : @"txt"};
}

@end
