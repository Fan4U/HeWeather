//
//  HourlyForecast.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WindInHour;
@interface HourlyForecast : NSObject

@property (nonatomic, copy) NSString *presInHour;
@property (nonatomic, strong) WindInHour *windInHour;
@property (nonatomic, copy) NSString *humInHour;
@property (nonatomic, copy) NSString *tmpInHour;
@property (nonatomic, copy) NSString *popInHour;
@property (nonatomic, copy) NSString *dateInHour;


+ (NSDictionary *)modelCustomPropertyMapper;
+ (NSDictionary *)modelContainerPropertyGenericClass;
@end
