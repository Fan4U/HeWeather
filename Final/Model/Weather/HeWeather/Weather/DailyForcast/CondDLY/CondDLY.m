//
//  CondDLY.m
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "CondDLY.h"

@implementation CondDLY

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"txtd" : @"txt_d",
             @"coden" : @"code_n",
             @"coded" : @"code_d",
             @"txtn" : @"txt_n"};
}

@end
