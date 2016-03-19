//
//  Update.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Update : NSObject

@property (nonatomic, copy) NSString *loc;
@property (nonatomic, copy) NSString *utc;

+ (NSDictionary *)modelCustomPropertyMapper;
@end
