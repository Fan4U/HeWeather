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

//修改城市ID
+ (BOOL)cityWillModifiedWithCityID:(NSString *)cityID;

//修改城市 拼音来自国外
+ (void)cityWillModifiedWithNameFromGPS:(NSString *)cityNamePY;

//修改是否首次登陆
+ (void)isFirstLoginWillChange:(NSString *)yesOrNo;
+ (BOOL)isFirstLogin;

//修改本地是否保存了Json
+ (void)isLocalJSONSavedWillChange:(NSString *)yesOrNo;

//是否需要定位
+ (void)isNeedSetWithGPSWillChange:(NSString *)yesOrNo;
+ (BOOL)isNeedSetWithGPS;

//跳转前判断
+ (NSString *)whatToDoAfterLoading;
+ (void)setWhatToDoAfterLoading:(NSString *)action;


@end
