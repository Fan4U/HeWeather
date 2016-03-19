//
//  CitiesModel.h
//  Final
//
//  Created by pro on 16/3/14.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cities : NSObject

@property (nonatomic, copy)NSString *cityName;
@property (nonatomic, copy)NSString *cityCode;

@end



@interface Province : NSObject

@property (nonatomic, copy)NSString *proName;
@property (nonatomic, strong)NSArray<Cities *> *cities;

@end


@interface CitiesModel : NSObject

@property (nonatomic, strong)NSArray<Province *> *province;

@end
