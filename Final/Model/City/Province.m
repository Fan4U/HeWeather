//
//  Province.m
//  Final
//
//  Created by pro on 16/3/14.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "Province.h"
#import "Cities.h"

@implementation Province

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"cities" : @"市",
             @"proName" : @"省"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"cities" : [Cities class]};
}
@end
