//
//  WeatherData.m
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "WeatherData.h"
#import "HeWeather.h"
#import "Settings.h"
#import "CodeModel.h"
#import "OpenWeatherModel.h"

//工具
#import "YYKit.h"
#import "YYTool.h"
#import "DateCompare.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"

//Json
#define path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"weather.json"]
//Plist
#define plistPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"settings.plist"]
//baidu api keys
#define baiduAK @"420c56ebf46b7a335b385152ff7cc28"
@interface WeatherData ()

@end

@implementation WeatherData

/**
 *  判断，并发送给获取数据方法。
 *  byPicker pick获取
 *  byName 用城市拼音 (来自定位)
 */
+ (void)loadWeatherData{
//    目前只在weatherLoading中调用

    //初始化
    [Settings initializePlist];
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath] mutableCopy];
    
    //    拿出保存城市名称的那个字典
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    
    //    取出其中settings的value并用参数pinyin来替换
//    NSString *valueOfCityID = [cityOfWeather objectForKey:@"cityID"];
//    NSString *valueOfNameFromGPS = [cityOfWeather objectForKey:@"nameFromGPS"];
    NSString *valueOfIsFirstLogin = [cityOfWeather objectForKey:@"isFirstLogin"];
    if ([valueOfIsFirstLogin isEqualToString:@"1"]) 

    //如果是第一次登陆 考虑用拼音定位
    if ([valueOfIsFirstLogin isEqualToString:@"1"]) {
        [self requestDataFromHEserverWithWhat:@"byName"];
    }
    

}



+ (void)requestDataFromHEserverWithWhat:(NSString *)requestType{
    

    
    NSString *finalURL = [[NSString alloc] init];

    if ([requestType isEqualToString:@"byName"]) {

        NSMutableDictionary *infolist= [[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath] mutableCopy];
        NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
        NSString *valueOfNameFromGPS = [cityOfWeather objectForKey:@"nameFromGPS"];
        
        NSString *http1 = @"https://api.heweather.com/x3/weather";
        NSString *http2 = @"city=";
        NSString *http3 = @"key=cdbb0dd11c3949c88248b270c58d737c";
        
        finalURL = [NSString stringWithFormat:@"%@?%@%@&%@",http1,http2,valueOfNameFromGPS,http3];//第三个参数是传进来的城市
        NSLog(@"使用拼音城市名%@请求数据",valueOfNameFromGPS);
        
    }else if ([requestType isEqualToString:@"byID"]){
        
        NSMutableDictionary *infolist= [[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath] mutableCopy];
        NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
        NSString *valueOfCityID = [cityOfWeather objectForKey:@"cityID"];
        NSLog(@"%s准备以ID名为%@的城市代码向服务器getJSON",__func__,valueOfCityID);

        NSString *http1 = @"https://api.heweather.com/x3/weather";
        NSString *http2 = @"cityid=CN";
        NSString *http3 = @"key=cdbb0dd11c3949c88248b270c58d737c";

        finalURL = [NSString stringWithFormat:@"%@?%@%@&%@",http1,http2,valueOfCityID,http3];
        
    }else if([requestType isEqualToString:@"byRefresh"]){
        HeWeather *tmp = [YYTool jsonToModel];
        NSString *preCityID = tmp.weather[0].basic.cityID;
        
        NSLog(@"向服务器刷新JSON");
        
        NSString *http1 = @"https://api.heweather.com/x3/weather";
        NSString *http2 = @"cityid=";
        NSString *http3 = @"key=cdbb0dd11c3949c88248b270c58d737c";
        
        finalURL = [NSString stringWithFormat:@"%@?%@%@&%@",http1,http2,preCityID,http3];

    }else{
        NSLog(@"Error Occured");
    }
    
    //这里是最终的URL
    NSURL *url = [NSURL URLWithString: finalURL];
     	NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
     	[request setHTTPMethod: @"GET"];

     	[NSURLConnection sendAsynchronousRequest: request
          	queue: [NSOperationQueue mainQueue]
          	completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                if (error) {
                   NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);

               }else {
                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                   NSLog(@"%s----->%@",__func__,responseString);
                   NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                   [jsonData writeToFile:path atomically:YES];
                   NSLog(@"%s----->新的JSON数据已经写入",__func__);
                   
                   [Settings isLocalJSONSavedWillChange:@"1"];
                   
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"JSONCOMPLETE" object:@"yes"];

               }
            }];
    
}

/**
 *  拿到地理坐标通过API换取所在地拼音
 *
 *  @param lon
 *  @param lat
 */
+ (void)getNameOfCityWithlon:(NSString *)lon lat:(NSString *)lat{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSString *url = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"APPID"] = @"1ab4d87f94a564708b2f164b4d344f83";
    params[@"lat"] = lat;
    params[@"lon"] = lon;

    [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        OpenWeatherModel *model = [OpenWeatherModel modelWithJSON:responseObject];
        NSString * nameOfCity = model.cityInOpen.name;
        NSLog(@"用收到的经纬度发送请求返回城市名称-->%@，并传递给Settings保存到plist",nameOfCity);
        [Settings cityWillModifiedWithNameFromGPS:nameOfCity];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%s错误 ----->%@",__func__,error);
    }];
}


@end
