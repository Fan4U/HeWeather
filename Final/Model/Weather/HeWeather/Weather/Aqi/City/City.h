//
//  City.h
//  Final
//
//  Created by pro on 16/3/15.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

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


+ (NSDictionary *)modelCustomPropertyMapper;
@end
