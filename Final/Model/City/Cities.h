//
//  Cities.h
//  Final
//
//  Created by pro on 16/3/14.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cities : NSObject

@property (nonatomic, copy)NSString *cityName;
@property (nonatomic, copy)NSString *cityCode;

+ (NSDictionary *)modelCustomPropertyMapper;

@end
