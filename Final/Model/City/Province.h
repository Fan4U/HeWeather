//
//  Province.h
//  Final
//
//  Created by pro on 16/3/14.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Cities;

@interface Province : NSObject

@property (nonatomic, copy)NSString *proName;
@property (nonatomic, strong)NSArray<Cities *> *cities;

+ (NSDictionary *)modelContainerPropertyGenericClass;

+ (NSDictionary *)modelCustomPropertyMapper;

@end
