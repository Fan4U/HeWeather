//
//  Weather.h
//  和风天气
//
//  Created by pro on 16/3/5.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HourlyForecast,Basic,NowWeather,DailyForecast,Suggestion,Aqi;
@interface Weather : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSArray<HourlyForecast *> *hourlyForecast;
@property (nonatomic, strong) Basic *basic;
@property (nonatomic, strong) NowWeather *nowWeather;
@property (nonatomic, strong) NSArray<DailyForecast *> *dailyForecast;
@property (nonatomic, strong) Suggestion *suggestion;
@property (nonatomic, strong)Aqi *aqi;

@end
