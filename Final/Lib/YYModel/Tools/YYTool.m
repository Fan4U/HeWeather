//
//  YYTool.m
//  和风天气
//
//  Created by pro on 16/3/5.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "YYTool.h"
#import "YYKit.h"
#import "HeWeather.h"
#import "WeatherData.h"
#import "CitiesModel.h"
#import "Settings.h"

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
//codelist
#define codeList [[NSBundle mainBundle] pathForResource:@"cityID.json" ofType:nil]
//OpenWeatherlist
//文件路径
#define jsonPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"weather.json"]

@implementation YYTool

+ (void)saveJSONToLocal:(NSString *)JSON{
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:jsonPath]) {
        NSData *jsonData = [JSON dataUsingEncoding:NSUTF8StringEncoding];
        [jsonData writeToFile:jsonPath atomically:YES];
        NSLog(@"YYTool--->保存新的JSON");

    }else{
        HeWeather *locModel = [YYTool localJSONToModel];
        HeWeather *newModel = [HeWeather modelWithJSON:JSON];
        
        if ([locModel.weather[0].basic.update.loc isEqualToString:newModel.weather[0].basic.update.loc] && [locModel.weather[0].basic.cityID isEqualToString:newModel.weather[0].basic.cityID]) {
            NSLog(@"本地数据已经是最新");
            return;
        }else{
            NSData *jsonData = [JSON dataUsingEncoding:NSUTF8StringEncoding];
            [jsonData writeToFile:jsonPath atomically:YES];
            NSLog(@"本地JSON已更新");
        }
    }
}

+ (HeWeather *)localJSONToModel{
    if ([[NSFileManager defaultManager] fileExistsAtPath:jsonPath]) {
        NSLog(@"本地存在JSON，开始返回转模型");
        NSData *data = [[NSData alloc] initWithContentsOfFile:jsonPath];
        return [HeWeather modelWithJSON:data];
    }else{
//        [WeatherData requestDataFromHEserverWithWhat:@"default"];
        return 0;
    }
}

+ (CitiesModel *)listToModel:(NSString *)file{
    if ([[NSFileManager defaultManager] fileExistsAtPath:codeList]) {
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:codeList];
        return [CitiesModel modelWithJSON:data];
    }else{
        return 0;
    }
}


+ (NSArray *)getAverageTemperatureOfWeek:(HeWeather *)heweather{
    //day1
    int min1 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[0].tmpDLY.min] intValue];
    int max1 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[0].tmpDLY.max] intValue];
    NSString *avr1 = [NSString stringWithFormat:@"%d",(min1 + max1) / 2];
    
    //day2
    int min2 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[1].tmpDLY.min] intValue];
    int max2 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[1].tmpDLY.max] intValue];
    NSString *avr2 = [NSString stringWithFormat:@"%d",(min2 + max2) / 2];
    
    //day3
    int min3 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[2].tmpDLY.min] intValue];
    int max3 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[2].tmpDLY.max] intValue];
    NSString *avr3 = [NSString stringWithFormat:@"%d",(min3 + max3) / 2];
    
    //day4
    int min4 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[3].tmpDLY.min] intValue];
    int max4 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[3].tmpDLY.max] intValue];
    NSString *avr4 = [NSString stringWithFormat:@"%d",(min4 + max4) / 2];
    
    //day5
    int min5 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[4].tmpDLY.min] intValue];
    int max5 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[4].tmpDLY.max] intValue];
    NSString *avr5 = [NSString stringWithFormat:@"%d",(min5 + max5) / 2];
    
    //day6
    int min6 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[5].tmpDLY.min] intValue];
    int max6 = [[NSString stringWithFormat:@"%@",heweather.weather[0].dailyForecast[5].tmpDLY.max] intValue];
    NSString *avr6 = [NSString stringWithFormat:@"%d",(min6 + max6) / 2];
    
    NSArray *avrTemperatureOfWeek = @[avr1,avr2,avr3,avr4,avr5,avr6];
    
    return avrTemperatureOfWeek;
}

+ (NSArray *)getDateNameOfWeek:(HeWeather *)heWeather{
    
    NSMutableArray *tmpArr = [NSMutableArray array];
    
    for (int i = 0; i < 6; i++) {
        NSString *titleDay;
        NSString *tmpTitleDate = heWeather.weather[0].dailyForecast[i].dateDLY;
        NSInteger isZero1 = (NSInteger)[tmpTitleDate characterAtIndex:5];
        if (isZero1 != 0) {
            titleDay = [tmpTitleDate substringFromIndex:6];
        }else{
            titleDay = [tmpTitleDate substringFromIndex:5];
        }
        [tmpArr addObject:titleDay];
    }
    return [NSArray arrayWithArray:tmpArr];

}

+ (UIImage *)getImageWithColorRed:(float)red Grenn:(float)green Blue:(float)blue andButtonSize:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:(red)/255.0 green:(green)/255.0 blue:(blue)/255.0 alpha:1.0] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *imageWithColorFilled = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageWithColorFilled;
}

@end
