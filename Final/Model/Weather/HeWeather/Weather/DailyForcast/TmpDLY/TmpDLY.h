//
//  TmpDLY.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TmpDLY : NSObject

@property (nonatomic, copy) NSString *max;
@property (nonatomic, copy) NSString *min;

+ (NSDictionary *)modelCustomPropertyMapper;

@end
