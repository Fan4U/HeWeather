//
//  UIView+Extension.h
//  Final
//
//  Created by pro on 16/3/13.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

+ (id)loadFromNib;
+ (id)loadFromNibNamed:(NSString*) nibName;
+ (id)loadFromNibNoOwner;
@end
