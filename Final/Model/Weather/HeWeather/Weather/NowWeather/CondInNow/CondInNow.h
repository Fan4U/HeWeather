//
//  CondInNow.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CondInNow : NSObject

@property (nonatomic, copy) NSString *txtInNow;
@property (nonatomic, copy) NSString *codeInNow;


+ (NSDictionary *)modelCustomPropertyMapper;

@end
