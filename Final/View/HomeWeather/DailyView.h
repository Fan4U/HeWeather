//
//  DailyView.h
//  Final
//
//  Created by pro on 16/3/17.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeWeather;

@interface DailyView : UIView
@property (nonatomic, strong)HeWeather *myWeather;
//day1
@property (weak, nonatomic) IBOutlet UILabel *titleDay1;
@property (weak, nonatomic) IBOutlet UILabel *minDay1;
@property (weak, nonatomic) IBOutlet UILabel *maxDay1;
@property (weak, nonatomic) IBOutlet UIImageView *condDay1;

//day2
@property (weak, nonatomic) IBOutlet UILabel *titleDay2;
@property (weak, nonatomic) IBOutlet UILabel *minDay2;
@property (weak, nonatomic) IBOutlet UILabel *maxDay2;
@property (weak, nonatomic) IBOutlet UIImageView *condDay2;

//day3
@property (weak, nonatomic) IBOutlet UILabel *titleDay3;
@property (weak, nonatomic) IBOutlet UILabel *minDay3;
@property (weak, nonatomic) IBOutlet UILabel *maxDay3;
@property (weak, nonatomic) IBOutlet UIImageView *condDay3;

//day4
@property (weak, nonatomic) IBOutlet UILabel *titleDay4;
@property (weak, nonatomic) IBOutlet UILabel *minDay4;
@property (weak, nonatomic) IBOutlet UILabel *maxDay4;
@property (weak, nonatomic) IBOutlet UIImageView *condDay4;

//day5
@property (weak, nonatomic) IBOutlet UILabel *titleDay5;
@property (weak, nonatomic) IBOutlet UILabel *minDay5;
@property (weak, nonatomic) IBOutlet UILabel *maxDay5;
@property (weak, nonatomic) IBOutlet UIImageView *condDay5;

//day6
@property (weak, nonatomic) IBOutlet UILabel *titleDay6;
@property (weak, nonatomic) IBOutlet UILabel *minDay6;
@property (weak, nonatomic) IBOutlet UILabel *maxDay6;
@property (weak, nonatomic) IBOutlet UIImageView *condDay6;


@end
