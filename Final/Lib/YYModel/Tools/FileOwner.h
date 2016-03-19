//
//  FileOwner.h
//  LoadNibViewDemo
//
//  Created by Haven on 7/2/14.
//  Copyright (c) 2014 LF. All rights reserved.
//F

#import <Foundation/Foundation.h>
#import "DailyView.h"
@interface FileOwner : NSObject
@property (nonatomic, weak) IBOutlet DailyView *view;

+(id)viewFromNibNamed:(NSString*) nibName;
@end
