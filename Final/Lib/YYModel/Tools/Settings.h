//
//  Settings.h
//  Final
//
//  Created by pro on 16/3/15.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject


//初始化
+ (void)initializePlist;

//修改城市
+ (BOOL)CitySettingsWillModified:(NSString *)cityID;

//修改城市 拼音来自国外
+ (void)cityModifiedWithNameFromGPS:(NSString *)cityNamePY;

@end
