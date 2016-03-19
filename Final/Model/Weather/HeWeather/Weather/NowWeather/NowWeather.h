//
//  NowWeather.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CondInNow,WindInNow;
@interface NowWeather : NSObject

@property (nonatomic, strong) CondInNow *condInNow;
@property (nonatomic, strong) WindInNow *windInNow;
@property (nonatomic, copy) NSString *humInNow;
@property (nonatomic, copy) NSString *pcpnInNow;
@property (nonatomic, copy) NSString *tmpInNow;

+ (NSDictionary *)modelCustomPropertyMapper;
+ (NSDictionary *)modelContainerPropertyGenericClass;
@end
