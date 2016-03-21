//
//  OpenWeatherModel.h
//  Final
//
//  Created by pro on 16/3/21.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CityInOpen : NSObject
@property (nonatomic, copy)NSString *name;
@end

@interface OpenWeatherModel : NSObject
@property (nonatomic, strong)CityInOpen *cityInOpen;
@end
