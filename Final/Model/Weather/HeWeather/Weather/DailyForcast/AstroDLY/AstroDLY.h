//
//  AstroDLY.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AstroDLY : NSObject

@property (nonatomic, copy) NSString *ss;
@property (nonatomic, copy) NSString *sr;

+ (NSDictionary *)modelCustomPropertyMapper;

@end
