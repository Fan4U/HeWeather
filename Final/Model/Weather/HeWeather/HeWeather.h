//
//  HeWeather.h
//  和风Weather
//
//  Created by pro on 16/3/3.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  空气质量--城市
 */
@interface City : NSObject
/**
 *  空气质量指数
 */
@property (nonatomic, copy)NSString *aqi;
/**
 *  一氧化碳1小时平均值(ug/m³)
 */
@property (nonatomic, copy)NSString *co;
/**
 *  二氧化氮1小时平均值(ug/m³)
 */
@property (nonatomic, copy)NSString *no2;
/**
 *  臭氧1小时平均值(ug/m³)
 */
@property (nonatomic, copy)NSString *o3;
/**
 *  PM10 1小时平均值(ug/m³)
 */
@property (nonatomic, copy)NSString *pm10;
/**
 *  PM2.5 1小时平均值(ug/m³)
 */
@property (nonatomic, copy)NSString *pm25;
/**
 *  空气质量类别
 */
@property (nonatomic, copy)NSString *qlty;
/**
 *  二氧化硫1小时平均值(ug/m³)
 */
@property (nonatomic, copy)NSString *so2;

@end

/**
 *  空气质量
 */
@interface Aqi : NSObject

@property (nonatomic, strong)City *city;

@end

/**
 *  基本信息 --Update
 */
@interface Update : NSObject

@property (nonatomic, copy) NSString *loc;
@property (nonatomic, copy) NSString *utc;

@end

/**
 *  基本信息
 */
@interface Basic : NSObject

@property (nonatomic, copy) NSString *cnty;
@property (nonatomic, copy) NSString *cityID;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *lon;
@property (nonatomic, strong) Update *update;

@end

/**
 *  一周预报 -- 天文
 */
@interface AstroDLY : NSObject

@property (nonatomic, copy) NSString *ss;
@property (nonatomic, copy) NSString *sr;

@end

/**
 *  一周预报 -- 状况
 */
@interface CondDLY : NSObject

@property (nonatomic, copy) NSString *txtd;
@property (nonatomic, copy) NSString *coden;
@property (nonatomic, copy) NSString *coded;
@property (nonatomic, copy) NSString *txtn;

@end

/**
 *  一周预报 -- 温度
 */
@interface TmpDLY : NSObject

@property (nonatomic, copy) NSString *max;
@property (nonatomic, copy) NSString *min;

@end

/**
 *  一周预报 -- 风
 */
@interface WindDLY : NSObject

@property (nonatomic, copy) NSString *dirDLY;
@property (nonatomic, copy) NSString *degDLY;
@property (nonatomic, copy) NSString *scDLY;
@property (nonatomic, copy) NSString *spdDLY;

@end

/**
 *  一周预报
 */
@interface DailyForecast : NSObject

@property (nonatomic, strong) AstroDLY *astroDLY;
@property (nonatomic, copy) NSString *presDLY;
@property (nonatomic, strong) TmpDLY *tmpDLY;
@property (nonatomic, strong) WindDLY *windDLY;
@property (nonatomic, copy) NSString *humDLY;
@property (nonatomic, copy) NSString *dateDLY;
@property (nonatomic, copy) NSString *visDLY;
@property (nonatomic, strong) CondDLY *condDLY;
@property (nonatomic, copy) NSString *pcpnDLY;
@property (nonatomic, copy) NSString *popDLY;

@end

/**
 *  时段预报 - 风
 */
@interface WindInHour : NSObject

@property (nonatomic, copy) NSString *dirInHour;
@property (nonatomic, copy) NSString *degInHour;
@property (nonatomic, copy) NSString *scInHour;
@property (nonatomic, copy) NSString *spdInHour;

@end

/**
 *  时段预报
 */
@interface HourlyForecast : NSObject

@property (nonatomic, copy) NSString *presInHour;
@property (nonatomic, strong) WindInHour *windInHour;
@property (nonatomic, copy) NSString *humInHour;
@property (nonatomic, copy) NSString *tmpInHour;
@property (nonatomic, copy) NSString *popInHour;
@property (nonatomic, copy) NSString *dateInHour;

@end

/**
 *  实况天气 -- 状况
 */
@interface CondInNow : NSObject

@property (nonatomic, copy) NSString *txtInNow;
@property (nonatomic, copy) NSString *codeInNow;

@end

/**
 *  实况天气 -- 风
 */
@interface WindInNow : NSObject

@property (nonatomic, copy) NSString *dirInNow;
@property (nonatomic, copy) NSString *spdInNow;
@property (nonatomic, copy) NSString *scInNow;

@end

/**
 *  实况天气
 */
@interface NowWeather : NSObject

@property (nonatomic, strong) CondInNow *condInNow;
@property (nonatomic, strong) WindInNow *windInNow;
@property (nonatomic, copy) NSString *humInNow;
@property (nonatomic, copy) NSString *pcpnInNow;
@property (nonatomic, copy) NSString *tmpInNow;

@end

@interface Drsg : NSObject

@property (nonatomic, copy) NSString *brf;

@property (nonatomic, copy) NSString *txt;

@end

@interface Flu : NSObject

@property (nonatomic, copy) NSString *brf;

@property (nonatomic, copy) NSString *txt;

@end

@interface Sport : NSObject

@property (nonatomic, copy) NSString *brf;

@property (nonatomic, copy) NSString *txt;

@end

@interface Comf : NSObject

@property (nonatomic, copy) NSString *brf;

@property (nonatomic, copy) NSString *txt;

@end

@interface Trav : NSObject

@property (nonatomic, copy) NSString *brf;

@property (nonatomic, copy) NSString *txt;

@end

@interface Cw : NSObject

@property (nonatomic, copy) NSString *brf;

@property (nonatomic, copy) NSString *txt;

@end

@interface Uv : NSObject

@property (nonatomic, copy) NSString *brf;

@property (nonatomic, copy) NSString *txt;

@end

/**
 *  生活建议
 */
@interface Suggestion : NSObject

@property (nonatomic, strong) Drsg *drsg;
@property (nonatomic, strong) Flu *flu;
@property (nonatomic, strong) Sport *sport;
@property (nonatomic, strong) Comf *comf;
@property (nonatomic, strong) Trav *trav;
@property (nonatomic, strong) Cw *cw;
@property (nonatomic, strong) Uv *uv;

@end

/**
 *  天气数据 数组
 */
@interface Weather : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSArray<HourlyForecast *> *hourlyForecast;
@property (nonatomic, strong) Basic *basic;
@property (nonatomic, strong) NowWeather *nowWeather;
@property (nonatomic, strong) NSArray<DailyForecast *> *dailyForecast;
@property (nonatomic, strong) Suggestion *suggestion;
@property (nonatomic, strong)Aqi *aqi;
@end

@interface HeWeather : NSObject

@property (nonatomic, strong)NSArray <Weather *>* weather;

@end