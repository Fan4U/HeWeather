//
//  Settings.m
//  Final
//
//  Created by pro on 16/3/15.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "Settings.h"
#import "CodeModel.h"
#import "WeatherData.h"
//Macro
#define plistPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"settings.plist"]

@interface Settings()
//@property (nonatomic, strong)NSArray *settingsModel;
@end

@implementation Settings

#pragma mark - 初始化Plist
+ (void)initializePlist{
//本地没有plist就新建
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSLog(@"%s-----本地没有Plist",__func__);
        NSMutableDictionary *dictplist = [[NSMutableDictionary alloc ] init];
        NSMutableDictionary *settings = [[NSMutableDictionary alloc]init];
        
        [settings setObject:@"101010100" forKey:@"cityID"]; //城市ID 来自本地模型
        
        [settings setObject:@"北京" forKey:@"cityName"]; //城市ID 来自本地模型
        
        [settings setObject:@"none" forKey:@"nameFromGPS"]; //本地城市拼音 来自GPS
        
        [settings setObject:@"1" forKey:@"isFirstLogin"];//是否首次登陆
        
        [settings setObject:@"1" forKey:@"needSetWithGPS"];//是否需要GPS定位
        
        [settings setObject:@"1st" forKey:@"whatToDoAfterLoading"];//updateByRefresh, updateByID, 1st 首次登陆
        
        [settings setObject:@"cond" forKey:@"styleOfDailyView"];//cond,chart
        
        [settings setObject:@"1" forKey:@"useCoreAnimation"];//是否使用动画
        
        //设置属性值
        
        [dictplist setObject:settings forKey:@"cityOfWeather"];
        
        //写入文件
        NSLog(@"%s---写入了新的值--新的字典为:%@",__func__,dictplist);
        [dictplist writeToFile:plistPath atomically:YES];

    }else{
        NSLog(@"%s----->本地有plist不用新建，返回",__func__);
    }
    return;
    
}

#pragma mark - 城市ID
/**
 *  判断是否要修改plist里的城市
 *
 *  @param cityID 传进来的城市id
 *
 *  @return 是否要修改 为页面跳转提供依据
 */
+ (BOOL)cityWillModifiedWithCityID:(NSString *)cityID andCityName:(NSString *)cityname{
  

    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    NSString *localValueOfCityID = [cityOfWeather objectForKey:@"cityID"];

    
    if ([localValueOfCityID isEqualToString:cityID]) {
        return NO;
    }else{
        NSLog(@"将把ID:%@ 城市名:%@ 写入配置文件",cityID,cityname);
        [cityOfWeather setValue:cityID forKey:@"cityID"];
        [cityOfWeather setValue:cityname forKey:@"cityName"];//顺便把ID对应的中文城市名也保存到plist
        [infolist setValue:cityOfWeather forKey:@"cityOfWeather"];
        [infolist writeToFile:plistPath atomically:YES];
        
        
        return YES;
    }

}
#pragma mark - 城市名称
+ (NSString *)cityName{
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    return [cityOfWeather objectForKey:@"cityName"];
}


+ (void)cityWillModifiedWithNameFromGPS:(NSString *)cityNamePY{

    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];

    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    
    NSString *localValueOfNameFromGPS = [cityOfWeather objectForKey:@"nameFromGPS"];
    
    if ([localValueOfNameFromGPS isEqualToString:cityNamePY]) {
        return; //定位结果和本地相同返回
    }else{
        
        localValueOfNameFromGPS = cityNamePY;
        
        [cityOfWeather setValue:localValueOfNameFromGPS forKey:@"nameFromGPS"];
        [infolist setValue:cityOfWeather forKey:@"cityOfWeather"];
        [infolist writeToFile:plistPath atomically:YES];
        NSLog(@"保存完毕 nameFromGPS--->%@",cityNamePY);
        [WeatherData requestDataFromHEserverWithWhat:@"byName"];//交给获取方法，参数种类为城市名，
    }
}

#pragma mark - 是否首次登陆
+ (void)isFirstLoginWillChange:(NSString *)yesOrNo{
    
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    
    [cityOfWeather setValue:yesOrNo forKey:@"isFirstLogin"];
    [infolist setValue:cityOfWeather forKey:@"cityOfWeather"];
    [infolist writeToFile:plistPath atomically:YES];
    NSLog(@"保存完毕 isFirstLogin--->%@",yesOrNo);
}

+ (BOOL)isFirstLogin{
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    NSString *value = [cityOfWeather objectForKey:@"isFirstLogin"];
    if ([value isEqualToString:@"1"]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 是否要定位
+ (void)isNeedSetWithGPSWillChange:(NSString *)yesOrNo{
    
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    
    [cityOfWeather setValue:yesOrNo forKey:@"needSetWithGPS"];
    [infolist setValue:cityOfWeather forKey:@"cityOfWeather"];
    [infolist writeToFile:plistPath atomically:YES];
    NSLog(@"保存完毕 needSetWithGPS--->%@",yesOrNo);
    
}

+ (BOOL)isNeedSetWithGPS{
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    NSString *value = [cityOfWeather objectForKey:@"needSetWithGPS"];
    if ([value isEqualToString:@"1"]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 跳转逻辑
+ (void)setWhatToDoAfterLoading:(NSString *)action{
    
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    
    [cityOfWeather setValue:action forKey:@"whatToDoAfterLoading"];
    [infolist setValue:cityOfWeather forKey:@"cityOfWeather"];
    [infolist writeToFile:plistPath atomically:YES];
    NSLog(@"保存完毕 whatToDoAfterLoading--->%@",action);
}

+ (NSString *)whatToDoAfterLoading{
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    NSString *value = [cityOfWeather objectForKey:@"whatToDoAfterLoading"];
    return value;
}

#pragma mark - dailyView界面
+ (void)styleOfDailyViewWillChange:(NSString *)style{
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    
    [cityOfWeather setValue:style forKey:@"styleOfDailyView"];
    [infolist setValue:cityOfWeather forKey:@"cityOfWeather"];
    [infolist writeToFile:plistPath atomically:YES];
    NSLog(@"保存完毕 styleOfDailyView--->%@",style);
}

+ (NSString *)styleOfDailyView{
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    NSString *value = [cityOfWeather objectForKey:@"styleOfDailyView"];
    return value;
}

#pragma mark - 是否开启动画
+ (BOOL)useCoreAnimation{
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    NSString *value = [cityOfWeather objectForKey:@"useCoreAnimation"];
    if ([value isEqualToString:@"1"]) {
        return YES;
    }else{
        return NO;
    }
}

+ (void)useCoreAnimationWillChange:(NSString *)yesOrNo{
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    
    [cityOfWeather setValue:yesOrNo forKey:@"useCoreAnimation"];
    [infolist setValue:cityOfWeather forKey:@"cityOfWeather"];
    [infolist writeToFile:plistPath atomically:YES];
}
@end
