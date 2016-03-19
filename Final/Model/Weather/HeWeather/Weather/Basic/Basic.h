//
//  Basic.h
//  和风天气
//
//  Created by pro on 16/3/5.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Update;
@interface Basic : NSObject

@property (nonatomic, copy) NSString *cnty;
@property (nonatomic, copy) NSString *cityID;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *lon;
@property (nonatomic, strong) Update *update;


+ (NSDictionary *)modelContainerPropertyGenericClass;
+ (NSDictionary *)modelCustomPropertyMapper;
@end
