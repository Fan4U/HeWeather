//
//  CodeModel.h
//  Final
//
//  Created by pro on 16/3/15.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeModel : NSObject

@property (nonatomic, copy)NSString *properties;
@property (nonatomic, copy)NSString *settings;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)CodeModelWithDict:(NSDictionary *)dict;

@end
