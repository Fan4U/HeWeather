//
//  AppDelegate.m
//  Final
//
//  Created by pro on 16/3/13.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "AppDelegate.h"
#import "Settings.h"
#import "WeatherLoadingController.h"
#import "ZFNavigationController.h"
#import "YYTool.h"
#import "HeWeather.h"

@interface AppDelegate ()

@end
// RGB颜色
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define RandomColor HWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//JSON Path
#define jsonPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"weather.json"]

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor brownColor];
    ZFNavigationController *nav = [[ZFNavigationController alloc] initWithRootViewController:[[WeatherLoadingController alloc] init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    if ([Settings warnOfRain]) {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types != UIUserNotificationTypeNone) {
            [self addLocalNotification];
        }else{
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
        }
    } 
    return YES;
}

#pragma mark - 调用后的方法
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//添加通知
- (void)addLocalNotification{
    //首先本地要有JSON
    if ([[NSFileManager defaultManager] fileExistsAtPath:jsonPath]) {
        NSLog(@"本地有JSON文件，开始判断是否要提醒下雨");
        //拿到天气模型
        HeWeather *tmpWeatherData = [YYTool localJSONToModel];
        //天气ID 第二天的
        int tomorrowWeatherCondID = [tmpWeatherData.weather[0].dailyForecast[1].condDLY.coded intValue];
        //天气名称（中文）
        NSString *tomorrowWeatherCondName = [NSString stringWithFormat:@"%@",tmpWeatherData.weather[0].dailyForecast[1].condDLY.txtd];
        //城市名称
        NSString *cityNameInNotify = [NSString stringWithFormat:@"%@",tmpWeatherData.weather[0].basic.city];
        
        //判断明天是否有雨
        if (tomorrowWeatherCondID >= 300 && tomorrowWeatherCondID <= 313) {
            //拼接准备
            NSString *tomorrowText = [NSString stringWithFormat:@"%@ 今天天气: %@,请做好准备。",cityNameInNotify,tomorrowWeatherCondName];
            NSString *tomorrowDate = [NSString stringWithFormat:@"%@",tmpWeatherData.weather[0].dailyForecast[1].dateDLY];
            //日期相关
            NSDateFormatter *formatterInNotify = [[NSDateFormatter alloc] init];
            [formatterInNotify setDateFormat:@"yyyy-MM-dd"];
            NSInteger secondsToNotify = [[[formatterInNotify dateFromString:tomorrowDate] dateByAddingTimeInterval:60 * 60 * 6] timeIntervalSinceNow];//还有多少秒提醒 也就是距离第二天的早上六点还有多久
            
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:secondsToNotify];
            
            localNotification.alertBody = tomorrowText;
            localNotification.applicationIconBadgeNumber++;
            localNotification.alertAction = @"查看详情";
            localNotification.alertLaunchImage = @"Default";
            localNotification.soundName = @"msg.caf"; //通知声音 系统的
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            NSLog(@"已经添加提醒%ld秒后提醒天气",(long)secondsToNotify);
        }else{
            //并没有雨 不提醒
            return;
        }

    }else{
        //没有本地数据
        return;
    }
    

}
@end
