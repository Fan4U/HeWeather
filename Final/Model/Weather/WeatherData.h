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

//判断
+ (void)loadWeatherData;

//从OpenWeather获取城市名字
+ (void)getNameOfCityWithlon:(NSString *)lon lat:(NSString *)lat;

//getJSON
+ (void)requestDataFromHEserverWithWhat:(NSString *)requestType;

@end
