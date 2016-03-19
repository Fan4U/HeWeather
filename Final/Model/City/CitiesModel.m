//
//  CitiesModel.m
//  Final
//
//  Created by pro on 16/3/14.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "CitiesModel.h"


@implementation Cities

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"cityName" : @"市名",
             @"cityCode" : @"编码"};
}

@end

@implementation Province

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"cities" : @"市",
             @"proName" : @"省"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"cities" : [Cities class]};
}
@end


@implementation CitiesModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"province" : @"城市代码"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"province" : [Province class]};
}

@end
