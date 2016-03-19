//
//  YYTool.m
//  和风天气
//
//  Created by pro on 16/3/5.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "YYTool.h"
#import "YYModel.h"
#import "HeWeather.h"

@implementation YYTool

+(HeWeather *)jsonToModel:(NSString *)file{
    NSData *data = [[NSData alloc] initWithContentsOfFile:file];
    return [HeWeather yy_modelWithJSON:data];
}

@end
