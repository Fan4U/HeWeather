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

#import <CoreLocation/CoreLocation.h>
//codelist
#define codeList [[NSBundle mainBundle] pathForResource:@"cityID.json" ofType:nil]
//OpenWeatherlist
//文件路径
#define jsonPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"weather.json"]

@implementation YYTool

+ (HeWeather *)jsonToModel{
    if ([[NSFileManager defaultManager] fileExistsAtPath:jsonPath]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:jsonPath];
        return [HeWeather modelWithJSON:data];
    }else{
        [WeatherData requestDataFromHEserver];
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

//
//+ (NSString *)transform:(NSString *)chinese
//{
//    NSMutableString *pinyin = [chinese mutableCopy];
//    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
//    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
//    
//    NSString *str = [NSString stringWithString:pinyin];
//    NSString *strWithoutSpaces = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    NSLog(@"%@", strWithoutSpaces);
//    return strWithoutSpaces;
//    
//    
//}



@end
