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

//工具
#import "YYKit.h"
#import "YYTool.h"
#import "DateCompare.h"
#import "SVProgressHUD.h"



//Json
#define path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"weather.json"]
//Plist
#define plistPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"settings.plist"]

@interface WeatherData()

@end

@implementation WeatherData

/**
 *  先判读本地是否有数据，YYModel转模型后测试。 如果没有数据就去网络获取json。
 */
+ (void)loadWeatherData{

    NSString *filePath = path;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
               
        //YYModel转模型
        HeWeather *heWeather = [YYTool jsonToModel:filePath];
        //取出时间字符串
        NSString *updateTimeStr = heWeather.weather[0].basic.update.loc;
        
        //交给工具类方法进行比较 返回的差距小时数的String 转换成int
        NSInteger hoursFromLastUpdate = [[DateCompare intervalSinceNow:updateTimeStr] integerValue];
        
        NSLog(@"来自本地判断数据时间--compareResult-->%ld",(long)hoursFromLastUpdate);
        //这里也是没有办法 不知道数据更新的间隔 先设置成20小时 如果20小时没更新数据就重新获取数据
        if (hoursFromLastUpdate > 3) {
            NSLog(@"已经过去3小时 尝试更新数据");
            [self requestDataFromHEserver];//重新获取并保存json
                                //循环一次 再load本句 这次应该会直接return最新的data应该不会执行if语句 结果会无限循环。。因为服务器数据不是准时更新 所以写死3小时
        }
    }else{
        NSLog(@"%s----->本地没有Json，尝试更新数据",__func__);
        [self requestDataFromHEserver];
    }
}



+ (void)requestDataFromHEserver{
//拿出城市名
    //    取出整个 先初始化
    [Settings initializePlist];
    
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath] mutableCopy];
    //    拿出保存城市名称的那个字典
    NSMutableDictionary *cityID = [infolist objectForKey:@"cityOfWeather"];
    
    //    取出其中settings的value并用参数pinyin来替换
    NSString *value = [cityID objectForKey:@"settings"];
    NSLog(@"%s准备以ID名为%@的城市代码向服务器getJSON",__func__,value);
    
    //    做成请求参数
//    NSString *httpArg = [NSString stringWithFormat:@"city=%@",value];

    NSString *http1 = @"https://api.heweather.com/x3/weather";
    NSString *http2 = @"cityid=CN";
    NSString *http3 = @"key=cdbb0dd11c3949c88248b270c58d737c";
    
    NSString *httpURL = [NSString stringWithFormat:@"%@?%@%@&%@",http1,http2,value,http3];

    
    NSURL *url = [NSURL URLWithString: httpURL];
     	NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
     	[request setHTTPMethod: @"GET"];
     	[NSURLConnection sendAsynchronousRequest: request
          	queue: [NSOperationQueue mainQueue]
          	completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                if (error) {
                   NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);
               }else {
                   //                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                   //NSLog(@"HttpResponseCode:%ld", responseCode);
                   NSLog(@"%s----->%@",__func__,responseString);
                   
                   NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                   [jsonData writeToFile:path atomically:YES];
//                   [SVProgressHUD showSuccessWithStatus:@"数据已更新!"];
                   NSLog(@"%s----->新的数据已经写入",__func__);
               }
            }];
}
@end
