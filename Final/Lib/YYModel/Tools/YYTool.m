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
//}



@end
