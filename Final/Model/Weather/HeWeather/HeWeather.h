//
//  HeWeather.h
//  和风Weather
//
//  Created by pro on 16/3/3.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Weather;
@interface HeWeather : NSObject

@property (nonatomic, strong)NSArray<Weather *> *weather;

+ (NSDictionary *)modelContainerPropertyGenericClass;
+ (NSDictionary *)modelCustomPropertyMapper;
@end
