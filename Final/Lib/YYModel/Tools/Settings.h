//
//  Settings.h
//  Final
//
//  Created by pro on 16/3/15.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject


//初始化
+ (void)initializePlist;

//修改城市ID和名字 && 取城市中文名
+ (NSString *)cityName;
+ (BOOL)cityWillModifiedWithCityID:(NSString *)cityID andCityName:(NSString *)cityname;

//修改城市 拼音来自国外
+ (void)cityWillModifiedWithNameFromGPS:(NSString *)cityNamePY;

//修改是否首次登陆
+ (void)isFirstLoginWillChange:(NSString *)yesOrNo;
+ (BOOL)isFirstLogin;

//是否需要定位
+ (void)isNeedSetWithGPSWillChange:(NSString *)yesOrNo;
+ (BOOL)isNeedSetWithGPS;

//跳转前判断
+ (NSString *)whatToDoAfterLoading;
+ (void)setWhatToDoAfterLoading:(NSString *)action;

//dailyView的风格
+ (void)styleOfDailyViewWillChange:(NSString *)style;
+ (NSString *)styleOfDailyView;

//是否开启动画
+ (void)useCoreAnimationWillChange:(NSString *)yesOrNo;
+ (BOOL)useCoreAnimation;

//是否开启雨天提醒
+ (void)warnOfRainWillChange:(NSString *)yesOrNo;
+ (BOOL)warnOfRain;
@end
