//
//  RoundView.h
//  文字轮播
//
//  Created by 李佳佳 on 16/1/8.
//  Copyright © 2016年 李佳佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RoundViewDelegate <NSObject>

@optional
-(void)RoundViewClickTheTitleWithNumber:(NSInteger)number;

@end

@interface RoundView : UIView
@property(strong,nonatomic)NSArray* titles;
@property(weak,atomic)id<RoundViewDelegate>delegate;
-(void)setLableFont:(UIFont*)font;
-(void)setLableColor:(UIColor*)color;
@end
