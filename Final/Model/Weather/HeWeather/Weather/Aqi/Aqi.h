//
//  Aqi.h
//  Final
//
//  Created by pro on 16/3/15.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class City;
@interface Aqi : NSObject
@property (nonatomic, strong)City *city;

+ (NSDictionary *)modelCustomPropertyMapper;
+ (NSDictionary *)modelContainerPropertyGenericClass;
@end
