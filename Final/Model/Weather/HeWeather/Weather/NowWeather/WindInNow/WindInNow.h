//
//  WindInNow.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WindInNow : NSObject

@property (nonatomic, copy) NSString *dirInNow;
@property (nonatomic, copy) NSString *spdInNow;
@property (nonatomic, copy) NSString *scInNow;

+ (NSDictionary *)modelCustomPropertyMapper;

@end
