//
//  CodeModel.m
//  Final
//
//  Created by pro on 16/3/15.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "CodeModel.h"

@implementation CodeModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self= [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;
}

+ (instancetype)CodeModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
