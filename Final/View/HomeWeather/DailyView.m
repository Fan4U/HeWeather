//
//  DailyView.m
//  Final
//
//  Created by pro on 16/3/17.
//  Copyright © 2016年 张帆. All rights reserved.
//
#import "DailyView.h"


//basic of weather
#import "Basic.h"
#import "Update.h"
#import "WeatherData.h"
#import "HeWeather.h"
#import "Weather.h"

//HourlyForecast
#import "HourlyForecast.h"
#import "WindInHour.h"

//DailyForecast
#import "DailyForecast.h"
#import "CondDLY.h"
#import "WindDLY.h"
#import "TmpDLY.h"
#import "AstroDLY.h"

//suggestion
#import "Suggestion.h"
#import "Drsg.h"
#import "Flu.h"
#import "Sport.h"
#import "Comf.h"
#import "Trav.h"
#import "Cw.h"
#import "Uv.h"

//aqi
#import "Aqi.h"

//now
#import "NowWeather.h"
#import "CondInNow.h"
#import "WindInNow.h"

@implementation DailyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.titleDay1.alpha = 0;
        
    }
    return self;
}

- (void)setMyWeather:(HeWeather *)myWeather{
    _myWeather = myWeather;
    
//    拿到传进来的模型开始赋值

#pragma mark - Day 1
    //去掉年份“2016-”
    NSString *tmpTitleDate1 = myWeather.weather[0].dailyForecast[0].dateDLY;
    
    NSInteger isZero1 = (NSInteger)[tmpTitleDate1 characterAtIndex:5];
    
    if (isZero1 != 0) {
        self.titleDay1.text = [tmpTitleDate1 substringFromIndex:6];
    }else{
        self.titleDay1.text = [tmpTitleDate1 substringFromIndex:5];
    }
    self.titleDay1.font = [UIFont systemFontOfSize:13.0];
    self.titleDay1.alpha = 0;
    
    //拼接度数
    NSString *tmpMin1 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[0].tmpDLY.min];
    self.minDay1.text = tmpMin1;
    self.minDay1.alpha = 0;
    
    NSString *tmpMax1 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[0].tmpDLY.max];
    self.maxDay1.text = tmpMax1;
    self.maxDay1.alpha = 0;
    
    //设置图标
    self.condDay1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[0].condDLY.coded]];
    self.condDay1.alpha = 0;
    
#pragma mark - Day 2
    //去掉年份“2016-”
    NSString *tmpTitleDate2 = myWeather.weather[0].dailyForecast[1].dateDLY;
    
    NSInteger isZero2 = (NSInteger)[tmpTitleDate2 characterAtIndex:5];
    
    if (isZero2 != 0) {
        self.titleDay2.text = [tmpTitleDate2 substringFromIndex:6];
    }else{
        self.titleDay2.text = [tmpTitleDate2 substringFromIndex:5];
    }
    self.titleDay2.font = [UIFont systemFontOfSize:13.0];
    self.titleDay2.alpha = 0;
    
    //拼接度数
    NSString *tmpMin2 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[1].tmpDLY.min];
    self.minDay2.text = tmpMin2;
    self.minDay2.alpha = 0;
    
    NSString *tmpMax2 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[1].tmpDLY.max];
    self.maxDay2.text = tmpMax2;
    self.maxDay2.alpha = 0;
    
    //设置图标
    self.condDay2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[1].condDLY.coded]];
    self.condDay2.alpha = 0;
    
#pragma mark - Day 3
    //去掉年份“2016-”
    NSString *tmpTitleDate3 = myWeather.weather[0].dailyForecast[2].dateDLY;
    
    NSInteger isZero3 = (NSInteger)[tmpTitleDate3 characterAtIndex:5];
    
    if (isZero3 != 0) {
        self.titleDay3.text = [tmpTitleDate3 substringFromIndex:6];
    }else{
        self.titleDay3.text = [tmpTitleDate3 substringFromIndex:5];
    }
    self.titleDay3.font = [UIFont systemFontOfSize:13.0];
    self.titleDay3.alpha = 0;
    
    //拼接度数
    NSString *tmpMin3 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[2].tmpDLY.min];
    self.minDay3.text = tmpMin3;
    self.minDay3.alpha = 0;
    
    NSString *tmpMax3 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[2].tmpDLY.max];
    self.maxDay3.text = tmpMax3;
    self.maxDay3.alpha = 0;
    
    //设置图标
    self.condDay3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[2].condDLY.coded]];
    self.condDay3.alpha = 0;
    
#pragma mark - Day 4
    //去掉年份“2016-” 智能判断月份 把-改成月 后面加上日，，没有这么做的原因是界面展示不下了
    NSString *tmpTitleDate4 = myWeather.weather[0].dailyForecast[3].dateDLY;
    
//    NSString *replaceTmpTitleDate4 = [tmpTitleDate4 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
//    NSString *resultTmpTitleDate4 = [replaceTmpTitleDate4 stringByAppendingString:@"日"];
    
    NSInteger isZero4 = (NSInteger)[tmpTitleDate4 characterAtIndex:5];
    
    if (isZero4 != 0) {
        NSLog(@"%s----->zero = 0",__func__);
        self.titleDay4.text = [tmpTitleDate4 substringFromIndex:6];
    }else{
        NSLog(@"%s----->zero = 1",__func__);
        self.titleDay4.text = [tmpTitleDate4 substringFromIndex:5];
    }
    self.titleDay4.font = [UIFont systemFontOfSize:13.0];
    self.titleDay4.alpha = 0;
    
    //拼接度数
    NSString *tmpMin4 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[3].tmpDLY.min];
    self.minDay4.text = tmpMin4;
    self.minDay4.alpha = 0;
    
    NSString *tmpMax4 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[3].tmpDLY.max];
    self.maxDay4.text = tmpMax4;
    self.maxDay4.alpha = 0;
    
    //设置图标
    self.condDay4.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[3].condDLY.coded]];
    self.condDay4.alpha = 0;
    
#pragma mark - Day 5
    //去掉年份“2016-”
    NSString *tmpTitleDate5 = myWeather.weather[0].dailyForecast[4].dateDLY;
    
    NSInteger isZero5 = (NSInteger)[tmpTitleDate5 characterAtIndex:5];
    
    if (isZero5 != 0) {
        self.titleDay5.text = [tmpTitleDate5 substringFromIndex:6];
    }else{
        self.titleDay5.text = [tmpTitleDate5 substringFromIndex:5];
    }
    self.titleDay5.font = [UIFont systemFontOfSize:13.0];
    self.titleDay5.alpha = 0;
    
    //拼接度数
    NSString *tmpMin5 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[4].tmpDLY.min];
    self.minDay5.text = tmpMin5;
    self.minDay5.alpha = 0;
    
    NSString *tmpMax5 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[4].tmpDLY.max];
    self.maxDay5.text = tmpMax5;
    self.maxDay5.alpha = 0;
    
    //设置图标
    self.condDay5.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[4].condDLY.coded]];
    self.condDay5.alpha = 0;
    
#pragma mark - Day 6
    //去掉年份“2016-”
    NSString *tmpTitleDate6 = myWeather.weather[0].dailyForecast[5].dateDLY;
    
    NSInteger isZero6 = (NSInteger)[tmpTitleDate3 characterAtIndex:5];
    
    if (isZero6 != 0) {
        self.titleDay6.text = [tmpTitleDate6 substringFromIndex:6];
    }else{
        self.titleDay6.text = [tmpTitleDate6 substringFromIndex:5];
    }
    self.titleDay6.font = [UIFont systemFontOfSize:13.0];
    self.titleDay6.alpha = 0;
    
    //拼接度数
    NSString *tmpMin6 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[5].tmpDLY.min];
    self.minDay6.text = tmpMin6;
    self.minDay6.alpha = 0;
    
    NSString *tmpMax6 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[5].tmpDLY.max];
    self.maxDay6.text = tmpMax6;
    self.maxDay6.alpha = 0;
    
    //设置图标
    self.condDay6.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[5].condDLY.coded]];
    self.condDay6.alpha = 0;
}

@end
