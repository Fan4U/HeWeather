//
//  Suggestion.m
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "Suggestion.h"
#import "Drsg.h"
#import "Flu.h"
#import "Sport.h"
#import "Comf.h"
#import "Trav.h"
#import "Cw.h"
#import "Uv.h"

@implementation Suggestion

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"drsg" : @"drsg",
             @"flu" : @"flu",
             @"sport" : @"sport",
             @"comf" : @"comf",
             @"trav" : @"trav",
             @"cw" : @"cw",
             @"uv" : @"uv"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"drsg" : [Drsg class],
             @"flu" : [Flu class],
             @"sport" : [Sport class],
             @"comf" : [Comf class],
             @"trav" : [Trav class],
             @"cw" : [Cw class],
             @"uv" : [Uv class]};
}

@end
