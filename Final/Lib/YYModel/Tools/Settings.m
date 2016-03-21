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

#pragma mark - 初始化模型
//- (NSArray *)settings{
//    
//    if (!_settingsModel) {
//        
//        NSArray *prpts = [NSArray arrayWithContentsOfFile:plistPath];
//        
//        //        NSLog(@"本地设置-属性%@ ",prpts);
//        
//        NSMutableArray *setM = [NSMutableArray array];
//        
//        for (NSDictionary *dict in prpts) {
//            CodeModel *pro = [CodeModel CodeModelWithDict:dict];
//            [setM addObject:pro];
//        }
//        _settingsModel = setM;
//        NSLog(@"_settings本地模型  %@  ",_settingsModel);
//    }
//    return _settingsModel;
//}
//
#pragma mark - 初始化Plist
+ (void)initializePlist{
//本地没有plist就新建
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSLog(@"%s-----本地没有Plist",__func__);
        NSMutableDictionary *dictplist = [[NSMutableDictionary alloc ] init];
        
        //定义第一个字典
        
        NSMutableDictionary *plugin1 = [[NSMutableDictionary alloc]init];
        
        [plugin1 setObject:@"cityID" forKey:@"properties"];
        
        [plugin1 setObject:@"101010100" forKey:@"settings"]; //默认北京 测试定位结果
        
        [plugin1 setObject:@"none" forKey:@"nameFromGPS"]; //拼音
        
        [plugin1 setObject:@"1" forKey:@"isFirstLogin"];
        
        //定义第二个字典
        
        //    NSMutableDictionary *plugin2 = [[NSMutableDictionary alloc]init];
        //
        //    [plugin2 setObject:@"properties" forKey:@"name1"];
        //
        //    [plugin2 setObject:@"content" forKey:@"name2"];
        
        //设置属性值
        
        [dictplist setObject:plugin1 forKey:@"cityOfWeather"];
        
        //    [dictplist setObject:plugin2 forKey:@"初二班"];
        
        //写入文件
        NSLog(@"%s---写入了新的值--新的字典为:%@",__func__,dictplist);
        [dictplist writeToFile:plistPath atomically:YES];

    }else{
        NSLog(@"%s----->本地有plist不用新建，返回",__func__);
    }
    return;
    
}
#pragma mark - 修改城市名称值
/**
 *  判断是否要修改plist里的城市
 *
 *  @param cityID 传进来的城市id
 *
 *  @return 是否要修改 为页面跳转提供依据
 */
+ (BOOL)CitySettingsWillModified:(NSString *)cityID{
  
//    取出整个
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath] mutableCopy];
    
//    拿出保存城市名称的那个字典
    NSMutableDictionary *cityPY = [infolist objectForKey:@"cityOfWeather"];
    
//    取出其中settings的value并用参数pinyin来替换
    NSString *value = [cityPY objectForKey:@"settings"];
    NSLog(@"%s当前Plist中的城市ID----->%@",__func__,value);
    
//    如果递交过来的结果相同就返回
    if ([value isEqualToString:cityID]) {
        NSLog(@"%s----->收到的城市ID和Plist中的相同，返回",__func__);
        return NO;
    }else{
        NSLog(@"%s----->收到的城市ID和Plist中的不同，开始修改",__func__);
        //    赋值
        value = cityID;
        
        //  写回去
        [cityPY setValue:value forKey:@"settings"];
        [infolist setValue:cityPY forKey:@"cityOfWeather"];
        
        //    保存
        NSLog(@"%s---%@---保存Plist中新的城市ID",__func__,infolist);
        [infolist writeToFile:plistPath atomically:YES];
        [WeatherData requestDataFromHEserver];
        return YES;
    }
}

+ (void)cityModifiedWithNameFromGPS:(NSString *)cityNamePY{
    //    取出整个
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath] mutableCopy];
    
    //    拿出保存城市名称的那个字典
    NSMutableDictionary *cityPY = [infolist objectForKey:@"cityOfWeather"];
    
    //    取出其中settings的value并用参数pinyin来替换
    NSString *value = [cityPY objectForKey:@"nameFromGPS"];
    NSLog(@"%s当前Plist中的城市ID----->%@",__func__,value);
    
    //    如果递交过来的结果相同就返回
    if ([value isEqualToString:cityNamePY]) {
        NSLog(@"%s----->收到的城市ID和Plist中的相同，返回",__func__);
    }else{
        NSLog(@"%s----->收到的城市ID和Plist中的不同，开始修改",__func__);
        //    赋值
        value = cityNamePY;
        
        //  写回去
        [cityPY setValue:value forKey:@"nameFromGPS"];
        [infolist setValue:cityPY forKey:@"cityOfWeather"];
        
        //    保存
        NSLog(@"%s---%@---保存Plist中新的城市ID",__func__,infolist);
        [infolist writeToFile:plistPath atomically:YES];
        [WeatherData requestDataFromHEserver];
    }

}
//#pragma mark - 拿出城市拼音
//- (NSString *)getCityPY{
//    return self.settingsModel[0].
//}
@end
