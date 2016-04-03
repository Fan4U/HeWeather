//
//  YYTool.h
//  和风天气
//
//  Created by pro on 16/3/5.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HeWeather,CitiesModel;
@interface YYTool : NSObject

+ (HeWeather *)localJSONToModel;

+ (CitiesModel *)listToModel:(NSString *)file;

+ (void)saveJSONToLocal:(NSString *)JSON;
//得到一周平均温度
+ (NSArray *)getAverageTemperatureOfWeek:(HeWeather *)heweather;
//得到一周日期
+ (NSArray *)getDateNameOfWeek:(HeWeather *)heWeather;

+ (UIImage *)getImageWithColorRed:(float)red Grenn:(float)green Blue:(float)blue andButtonSize:(CGSize)size;

@end
