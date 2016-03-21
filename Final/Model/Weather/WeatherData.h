//
//  WeatherData.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HeWeather;
@interface WeatherData : NSObject


+ (void)loadWeatherData;

//+ (void)requestData;
//和风版本
+ (void)requestDataFromHEserver;
//从百度获取城市名字
+ (void)getNameOfCityWithlon:(NSString *)lon lat:(NSString *)lat;

@end
