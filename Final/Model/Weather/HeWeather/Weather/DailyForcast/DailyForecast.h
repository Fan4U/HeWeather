//
//  DailyForecast.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AstroDLY,TmpDLY,WindDLY,CondDLY;
@interface DailyForecast : NSObject


@property (nonatomic, strong) AstroDLY *astroDLY;
@property (nonatomic, copy) NSString *presDLY;
@property (nonatomic, strong) TmpDLY *tmpDLY;
@property (nonatomic, strong) WindDLY *windDLY;
@property (nonatomic, copy) NSString *humDLY;
@property (nonatomic, copy) NSString *dateDLY;
@property (nonatomic, copy) NSString *visDLY;
@property (nonatomic, strong) CondDLY *condDLY;
@property (nonatomic, copy) NSString *pcpnDLY;
@property (nonatomic, copy) NSString *popDLY;

+ (NSDictionary *)modelCustomPropertyMapper;
+ (NSDictionary *)modelContainerPropertyGenericClass;
@end
