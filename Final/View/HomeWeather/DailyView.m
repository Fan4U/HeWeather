//
//  DailyView.m
//  Final
//
//  Created by pro on 16/3/17.
//  Copyright © 2016年 张帆. All rights reserved.
//
#import "DailyView.h"
#import "WeatherData.h"
#import "HeWeather.h"
#import "YYTool.h"

#import "Masonry.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height


@implementation DailyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

#warning 待改进
- (void)setMyWeather:(HeWeather *)myWeather{
     _myWeather = myWeather;
    


    CGFloat cellCenterX = [UIScreen mainScreen].bounds.size.width / 6;
    CGFloat cellCenterY = self.frame.size.height / 5;
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
    self.titleDay1.textAlignment = NSTextAlignmentCenter;
//    self.titleDay1.backgroundColor = [UIColor greenColor];
//    self.titleDay1.transform = CGAffineTransformMakeScale(1.6, 1.6);

    //拼接度数
    NSString *tmpMin1 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[0].tmpDLY.min];
    self.minDay1.text = tmpMin1;
    self.minDay1.alpha = 0;
    self.minDay1.textAlignment = NSTextAlignmentCenter;
//    self.minDay1.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    NSString *tmpMax1 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[0].tmpDLY.max];
    self.maxDay1.text = tmpMax1;
    self.maxDay1.alpha = 0;
    self.maxDay1.textAlignment = NSTextAlignmentCenter;
//    self.maxDay1.transform = CGAffineTransformMakeScale(1.6, 1.6);
    
    //设置图标
    self.condDay1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[0].condDLY.coded]];
    self.condDay1.alpha = 0;
    self.condDay1.contentMode = UIViewContentModeScaleAspectFit;
//    self.condDay1.transform = CGAffineTransformMakeScale(1.6, 1.6);

    
    
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
    self.titleDay2.textAlignment = NSTextAlignmentCenter;
    
    //拼接度数
    NSString *tmpMin2 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[1].tmpDLY.min];
    self.minDay2.text = tmpMin2;
    self.minDay2.alpha = 0;
    self.minDay2.textAlignment = NSTextAlignmentCenter;
    
    NSString *tmpMax2 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[1].tmpDLY.max];
    self.maxDay2.text = tmpMax2;
    self.maxDay2.alpha = 0;
    self.maxDay2.textAlignment = NSTextAlignmentCenter;
    
    //设置图标
    self.condDay2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[1].condDLY.coded]];
    self.condDay2.alpha = 0;
    self.condDay2.contentMode = UIViewContentModeScaleAspectFit;
    
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
    self.titleDay3.textAlignment = NSTextAlignmentCenter;

    
    //拼接度数
    NSString *tmpMin3 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[2].tmpDLY.min];
    self.minDay3.text = tmpMin3;
    self.minDay3.alpha = 0;
    self.minDay3.textAlignment = NSTextAlignmentCenter;
    
    NSString *tmpMax3 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[2].tmpDLY.max];
    self.maxDay3.text = tmpMax3;
    self.maxDay3.alpha = 0;
    self.maxDay3.textAlignment = NSTextAlignmentCenter;
    
    //设置图标
    self.condDay3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[2].condDLY.coded]];
    self.condDay3.alpha = 0;
    self.condDay3.contentMode = UIViewContentModeScaleAspectFit;
    
#pragma mark - Day 4
    //去掉年份“2016-” 智能判断月份 把-改成月 后面加上日，
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
    self.titleDay4.textAlignment = NSTextAlignmentCenter;
    
    //拼接度数
    NSString *tmpMin4 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[3].tmpDLY.min];
    self.minDay4.text = tmpMin4;
    self.minDay4.alpha = 0;
    self.minDay4.textAlignment = NSTextAlignmentCenter;
    
    
    NSString *tmpMax4 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[3].tmpDLY.max];
    self.maxDay4.text = tmpMax4;
    self.maxDay4.alpha = 0;
    self.maxDay4.textAlignment = NSTextAlignmentCenter;
    
    //设置图标
    self.condDay4.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[3].condDLY.coded]];
    self.condDay4.alpha = 0;
    self.condDay4.contentMode = UIViewContentModeScaleAspectFit;
    
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
    self.titleDay5.textAlignment = NSTextAlignmentCenter;

    //拼接度数
    NSString *tmpMin5 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[4].tmpDLY.min];
    self.minDay5.text = tmpMin5;
    self.minDay5.alpha = 0;
    self.minDay5.textAlignment = NSTextAlignmentCenter;
    
    NSString *tmpMax5 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[4].tmpDLY.max];
    self.maxDay5.text = tmpMax5;
    self.maxDay5.alpha = 0;
    self.maxDay5.textAlignment = NSTextAlignmentCenter;
    
    //设置图标
    self.condDay5.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[4].condDLY.coded]];
    self.condDay5.alpha = 0;
    self.condDay5.contentMode = UIViewContentModeScaleAspectFit;
    
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
    self.titleDay6.textAlignment = NSTextAlignmentCenter;

    
    //拼接度数
    NSString *tmpMin6 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[5].tmpDLY.min];
    self.minDay6.text = tmpMin6;
    self.minDay6.alpha = 0;
    self.minDay6.textAlignment = NSTextAlignmentCenter;
    
    NSString *tmpMax6 = [NSString stringWithFormat:@"%@°",myWeather.weather[0].dailyForecast[5].tmpDLY.max];
    self.maxDay6.text = tmpMax6;
    self.maxDay6.alpha = 0;
    self.maxDay6.textAlignment = NSTextAlignmentCenter;
    
    //设置图标
    self.condDay6.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",myWeather.weather[0].dailyForecast[5].condDLY.coded]];
    self.condDay6.alpha = 0;
    self.condDay6.contentMode = UIViewContentModeScaleAspectFit;
    
    
    
    
    
#pragma mark Masonry
//title1
    [_titleDay1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.top.left.mas_equalTo(0);
    }];
    [_titleDay2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.left.equalTo(_titleDay1).offset(cellCenterX);
        make.centerY.equalTo(_titleDay1);
    }];
    [_titleDay3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.left.equalTo(_titleDay2).offset(cellCenterX);
        make.centerY.equalTo(_titleDay1);
    }];
    [_titleDay4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.left.equalTo(_titleDay3).offset(cellCenterX);
        make.centerY.equalTo(_titleDay1);
    }];
    [_titleDay5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.left.equalTo(_titleDay4).offset(cellCenterX);
        make.centerY.equalTo(_titleDay1);
    }];
    [_titleDay6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.left.equalTo(_titleDay5).offset(cellCenterX);
        make.centerY.equalTo(_titleDay1);
    }];
    
//min
    [_minDay1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.centerY.equalTo(_titleDay1).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_titleDay1);
    }];
    [_minDay2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.centerY.equalTo(_titleDay2).offset(cellCenterY* 1.5);
        make.centerX.equalTo(_titleDay2);
    }];
    [_minDay3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.centerY.equalTo(_titleDay3).offset(cellCenterY* 1.5);
        make.centerX.equalTo(_titleDay3);
    }];
    [_minDay4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.centerY.equalTo(_titleDay4).offset(cellCenterY* 1.5);
        make.centerX.equalTo(_titleDay4);
    }];
    [_minDay5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.centerY.equalTo(_titleDay5).offset(cellCenterY* 1.5);
        make.centerX.equalTo(_titleDay5);
    }];
    [_minDay6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY));
        make.centerY.equalTo(_titleDay6).offset(cellCenterY* 1.5);
        make.centerX.equalTo(_titleDay6);
    }];
    
//  icon
    [_condDay1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY * 2));
        make.centerY.equalTo(_minDay1).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_minDay1);
    }];
    [_condDay2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY * 2));
        make.centerY.equalTo(_minDay2).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_minDay2);
    }];
    [_condDay3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY * 2));
        make.centerY.equalTo(_minDay3).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_minDay3);
    }];
    [_condDay4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY * 2));
        make.centerY.equalTo(_minDay4).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_minDay4);
    }];
    [_condDay5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY * 2));
        make.centerY.equalTo(_minDay5).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_minDay5);
    }];
    [_condDay6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellCenterX, cellCenterY * 2));
        make.centerY.equalTo(_minDay6).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_minDay6);
    }];
    
//    max
    [_maxDay1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_minDay1);
        make.centerY.equalTo(_condDay1).offset(cellCenterY * 1.5);
    }];
    [_maxDay2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_minDay2);
        make.centerY.equalTo(_condDay2).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_maxDay1).offset(cellCenterX);
    }];
    [_maxDay3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_minDay3);
        make.centerY.equalTo(_condDay3).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_maxDay2).offset(cellCenterX);
    }];
    [_maxDay4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_minDay4);
        make.centerY.equalTo(_condDay4).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_maxDay3).offset(cellCenterX);
    }];
    [_maxDay5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_minDay5);
        make.centerY.equalTo(_condDay6).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_maxDay4).offset(cellCenterX);
    }];
    [_maxDay6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_minDay6);
        make.centerY.equalTo(_condDay6).offset(cellCenterY * 1.5);
        make.centerX.equalTo(_maxDay5).offset(cellCenterX);
    }];



}


@end
