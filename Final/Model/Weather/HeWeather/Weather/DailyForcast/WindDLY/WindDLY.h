//
//  WindDLY.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WindDLY : NSObject

@property (nonatomic, copy) NSString *dirDLY;
@property (nonatomic, copy) NSString *degDLY;
@property (nonatomic, copy) NSString *scDLY;
@property (nonatomic, copy) NSString *spdDLY;

+ (NSDictionary *)modelCustomPropertyMapper;

@end
