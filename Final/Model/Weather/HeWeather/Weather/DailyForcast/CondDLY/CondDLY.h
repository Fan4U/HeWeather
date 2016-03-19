//
//  CondDLY.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CondDLY : NSObject

@property (nonatomic, copy) NSString *txtd;
@property (nonatomic, copy) NSString *coden;
@property (nonatomic, copy) NSString *coded;
@property (nonatomic, copy) NSString *txtn;


+ (NSDictionary *)modelCustomPropertyMapper;

@end
