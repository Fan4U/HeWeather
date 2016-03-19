//
//  Suggestion.h
//  和风Weather
//
//  Created by pro on 16/3/4.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Drsg,Flu,Sport,Comf,Trav,Cw,Uv;
@interface Suggestion : NSObject

@property (nonatomic, strong) Drsg *drsg;
@property (nonatomic, strong) Flu *flu;
@property (nonatomic, strong) Sport *sport;
@property (nonatomic, strong) Comf *comf;
@property (nonatomic, strong) Trav *trav;
@property (nonatomic, strong) Cw *cw;
@property (nonatomic, strong) Uv *uv;


+ (NSDictionary *)modelCustomPropertyMapper;
+ (NSDictionary *)modelContainerPropertyGenericClass;
@end
