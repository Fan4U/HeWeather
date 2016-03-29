//
//  DateCompare.m
//  和风天气
//
//  Created by pro on 16/3/6.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "DateCompare.h"

@implementation DateCompare
/**
 *  距离今天的日期
 *
 *  @param fromWhen 从某一天开始
 *
 *  @return 距今已有多少天
 */
+ (NSString *)intervalSinceNow:(NSString *)fromWhen{
//    NSString *timeString = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm]"];
    NSDate *fromDate = [formatter dateFromString:fromWhen];//传参数
    NSTimeZone *fromZone = [NSTimeZone systemTimeZone];
    NSInteger fromInterval = [fromZone secondsFromGMTForDate:fromDate];
    NSDate *fromDateA = [fromDate dateByAddingTimeInterval:fromInterval];
    
    NSDate *now = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:now];
    NSDate *localDate = [now dateByAddingTimeInterval:interval];
    
    double timeInterval = [fromDateA timeIntervalSinceReferenceDate] - [localDate timeIntervalSinceReferenceDate];//取差
    long ITime = fabs((long)timeInterval);//绝对值
    NSLog(@"计算了一次时间差-单位秒-->%ld",ITime);//调试
    
    //过去了几个整小时
    NSInteger iMinutes = ITime / 60 / 60;
    
    //过去了几个整天
    NSInteger iDays = ITime / 60 / 60 / 24;

    
    if (ITime > 10800.0 && ITime <= 86400.0) {
        return [NSString stringWithFormat:@"%d",iMinutes];//返回的数值大于3 也就是超过3小时候 就会选择刷新数据
    }else{
        return [NSString stringWithFormat:@"%ld",(long)iDays];//这个是纪念日与现在差了多少天
    }
    
    
}
@end
