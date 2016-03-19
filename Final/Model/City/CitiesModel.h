//
//  CitiesModel.h
//  Final
//
//  Created by pro on 16/3/14.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Province;;
@interface CitiesModel : NSObject

@property (nonatomic, strong)NSArray<Province *> *province;

+ (NSDictionary *)modelContainerPropertyGenericClass;

+ (NSDictionary *)modelCustomPropertyMapper;

@end
