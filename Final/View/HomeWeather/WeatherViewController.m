//
//  WeatherViewController.m
//  Final
//
//  Created by pro on 16/3/13.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "WeatherViewController.h"
#import "SelectLocController.h"
#import "DailyView.h"
#import <AudioToolbox/AudioToolbox.h>

//basic of weather
#import "Basic.h"
#import "Update.h"
#import "WeatherData.h"
#import "HeWeather.h"
#import "Weather.h"

//HourlyForecast
#import "HourlyForecast.h"
#import "WindInHour.h"

//DailyForecast
#import "DailyForecast.h"
#import "CondDLY.h"
#import "WindDLY.h"
#import "TmpDLY.h"
#import "AstroDLY.h"

//suggestion
#import "Suggestion.h"
#import "Drsg.h"
#import "Flu.h"
#import "Sport.h"
#import "Comf.h"
#import "Trav.h"
#import "Cw.h"
#import "Uv.h"

//aqi
#import "Aqi.h"

//now
#import "NowWeather.h"
#import "CondInNow.h"
#import "WindInNow.h"

//tools
#import "DateCompare.h"
#import "YYTool.h"
#import "YYKit.h"
#import "UIView+Extension.h"

//other
#import "RoundView.h"
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "CNPGridMenu.h"

//JSON Path
#define jsonPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"weather.json"]

// RGB颜色
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

static SystemSoundID shakeSound = 0;

@interface WeatherViewController () <RoundViewDelegate,CNPGridMenuDelegate>

//on center
@property (nonatomic, weak)YYLabel *tempLabel;
@property (nonatomic, weak)YYLabel *cityLabel;
@property (nonatomic, weak)UIImageView *condIcon;
//on left
@property (nonatomic, weak)YYLabel *nowWindDir;
@property (nonatomic, weak)YYLabel *humidityLabel;
//on right
@property (nonatomic, weak)YYLabel *sunRiseLabel;
@property (nonatomic, weak)YYLabel *sunSetLabel;
//on top left
@property (nonatomic, weak)UILabel *lastUpdTimeLabel;
//on top right
@property (nonatomic, weak)YYLabel *changeCity;

//view
@property (nonatomic, weak)DailyView *dailyView;

//ImgV
@property (nonatomic, weak)UIImageView *backgroundImage;
@property (nonatomic, weak)UIImageView *locLittleIcon;
@property (nonatomic, weak)UIImageView *srIcon;
@property (nonatomic, weak)UIImageView *ssIcon;

//grid
@property (nonatomic, strong) CNPGridMenu *gridMenu;


@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Color(244, 244, 244);//Color(249, 249, 249)
    [self.navigationController setNavigationBarHidden:YES]; //没必要显示
    [WeatherData loadWeatherData];  //测试
    
//    主界面
    [self setupImage];
    [self setupWelcomLabel];
    [self becomeFirstResponder];
  
}


- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setLabels];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self SetupRoundView];
    });
    
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 欢迎条
- (void)setupWelcomLabel{    
    UILabel *welcome = [[UILabel alloc] initWithFrame:CGRectMake(0,-44, self.view.bounds.size.width, 24)];
    welcome.backgroundColor = [UIColor colorWithRed:(30.0/255.0) green:(144.0/255.0) blue:(255.0/255.0) alpha:1];
    welcome.textAlignment = NSTextAlignmentCenter;
    welcome.numberOfLines = 0;
    welcome.textColor = [UIColor blackColor];
    welcome.alpha = 0.75;
    
    //获取日期
//    NSDate *currentDate = [NSDate date];//今天的字符串 备用
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY年 MM月 dd日"];
//    NSString *today = [formatter stringFromDate:currentDate];//今天的字符串 备用
    NSString *SinceThatDay = [DateCompare intervalSinceNow:@"2015-08-27 20:00"];
    
    welcome.text = [NSString stringWithFormat:@"在一起%@天了,加油！！",SinceThatDay];
    welcome.textColor = [UIColor whiteColor];
    
    [self.view addSubview:welcome];
    [UIView animateWithDuration:1.7 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        welcome.transform = CGAffineTransformMakeTranslation(0, 44);
        //        welcome.top = 44;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3.4 delay:1.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            welcome.transform = CGAffineTransformMakeTranslation(0, -44);
        } completion:^(BOOL finished) {
            [welcome removeFromSuperview];
        }];
    }];
    
}

#pragma mark - 设置主要控件
- (void)setLabels{

//取数据
    HeWeather *MyWeather = [YYTool jsonToModel:jsonPath];
    NSLog(@"%s----->%@",__func__,MyWeather);
    

#pragma mark - 温度label 也是约束的对照点
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    //设置富文本 ----温度
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@° %@",MyWeather.weather[0].nowWeather.tmpInNow,MyWeather.weather[0].nowWeather.condInNow.txtInNow]];
        one.font = [UIFont systemFontOfSize:30.0];
        one.color = [UIColor blackColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.textShadow = shadow;
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
    }
    
    YYLabel *tmpLabel = [[YYLabel alloc] init];

    tmpLabel.attributedText = text;
    tmpLabel.textAlignment = NSTextAlignmentCenter;
    tmpLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    _tempLabel = tmpLabel;
    
    [self.view addSubview:_tempLabel];
    
    // only be available after [self.view addSubview:_tempLabel]! why?
    [tmpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);//make the centerx of label equal to self.view
        make.centerY.equalTo(self.view).with.offset(-100);
        make.size.mas_equalTo(CGSizeMake(220, 60));
    }];
    
#pragma mark - 城市Label
    //attributestring
    NSMutableAttributedString *text1 = [NSMutableAttributedString new];
    //设置富文本 ----城市名称的
    {
        NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",MyWeather.weather[0].basic.city]];
        two.font = [UIFont boldSystemFontOfSize:45];
        two.color = [UIColor blackColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        two.textShadow = shadow;
        [text1 appendAttributedString:two];
        [text1 appendAttributedString:[self padding]];
    }
    
    YYLabel *tmpCityLabel = [[YYLabel alloc] init];//WithFrame:CGRectMake(100, 50, 120, 90) abandon after masonry
    tmpCityLabel.attributedText = text1;
    tmpCityLabel.textAlignment = NSTextAlignmentCenter;
    tmpCityLabel.translatesAutoresizingMaskIntoConstraints = NO; //if yes, the label will appear in the top left corner of self.view
    _cityLabel = tmpCityLabel;
    
    [self.view addSubview:_cityLabel];
    
    [tmpCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 60));//如果有四个字的城市 所以宽点
        make.centerX.equalTo(_tempLabel);//中心对齐
        make.centerY.equalTo(_tempLabel).with.offset(-60); //往上挪动50
    }];
    
#pragma mark - 天气状态图
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",MyWeather.weather[0].nowWeather.condInNow.codeInNow]]];
    imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGridMenu)];
    [imgV addGestureRecognizer:tap];
    
    _condIcon = imgV;
    [self.view addSubview:_condIcon];
    _condIcon.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(_tempLabel);
        make.centerY.equalTo(_tempLabel).with.offset(80);
    }];
   
    [UIView animateWithDuration:1.2 animations:^{
        _condIcon.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
#pragma mark - 选择城市Label
    NSMutableAttributedString *text2 = [NSMutableAttributedString new];
    NSMutableAttributedString *changeCityStr = [[NSMutableAttributedString alloc] initWithString:@"选择城市"];
    {
    changeCityStr.font = [UIFont boldSystemFontOfSize:15.0];
    changeCityStr.underlineColor = changeCityStr.color;
    changeCityStr.underlineStyle = NSUnderlineStyleSingle;
    
    [changeCityStr setTextHighlightRange:changeCityStr.rangeOfAll
                         color:[UIColor blackColor]
               backgroundColor:[UIColor clearColor]
                     tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                         [self tapChangeLocBtn];
                     }];
    
    [text2 appendAttributedString:changeCityStr];
    [text2 appendAttributedString:[self padding]];
    }
    
    //init tmp YYlabel
    YYLabel *tmpChangeCityLabel = [[YYLabel alloc] init];
    tmpChangeCityLabel.textAlignment = NSTextAlignmentCenter;
    tmpChangeCityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tmpChangeCityLabel.attributedText = changeCityStr;
    
    _changeCity = tmpChangeCityLabel;
    
    [self.view addSubview:_changeCity];
    
    [_changeCity mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置size
        make.size.mas_equalTo(CGSizeMake(75, 55));
        make.right.equalTo(self.view).offset(-2);
        make.top.equalTo(self.view).offset(10);
    }];
    
    
    
#pragma mark - 7days Label
    
    DailyView *tmpDailyView = [DailyView loadFromNib];
    tmpDailyView.myWeather = MyWeather;
    
    _dailyView = tmpDailyView;
    _dailyView.frame = CGRectMake(10, 300, 300, 115);
    
    [self.view addSubview:_dailyView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.7 animations:^{
                _dailyView.titleDay1.alpha = 1;
                _dailyView.minDay1.alpha = 1;
                _dailyView.maxDay1.alpha = 1;
                _dailyView.condDay1.alpha = 1;
            }];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.7 animations:^{
                _dailyView.titleDay2.alpha = 1;
                _dailyView.minDay2.alpha = 1;
                _dailyView.maxDay2.alpha = 1;
                _dailyView.condDay2.alpha = 1;
            }];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.7 animations:^{
                _dailyView.titleDay3.alpha = 1;
                _dailyView.minDay3.alpha = 1;
                _dailyView.maxDay3.alpha = 1;
                _dailyView.condDay3.alpha = 1;
            }];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.7 animations:^{
                _dailyView.titleDay4.alpha = 1;
                _dailyView.minDay4.alpha = 1;
                _dailyView.maxDay4.alpha = 1;
                _dailyView.condDay4.alpha = 1;
            }];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.7 animations:^{
                _dailyView.titleDay5.alpha = 1;
                _dailyView.minDay5.alpha = 1;
                _dailyView.maxDay5.alpha = 1;
                _dailyView.condDay5.alpha = 1;
            }];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.7 animations:^{
                _dailyView.titleDay6.alpha = 1;
                _dailyView.minDay6.alpha = 1;
                _dailyView.maxDay6.alpha = 1;
                _dailyView.condDay6.alpha = 1;
            }];
        });
});
    
    
    
#pragma mark - locLittelIcon 选择城市按钮左侧图标
    UIImageView *tmpSRIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"locIcon"]];
    tmpSRIcon.contentMode = UIViewContentModeScaleAspectFill;
    
    _locLittleIcon = tmpSRIcon;
    
    [self.view addSubview:_locLittleIcon];
    
    [_locLittleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerY.equalTo(self.changeCity);
        make.left.equalTo(self.changeCity).offset(-34);
    }];

#pragma mark - 风向Label
    NSMutableAttributedString *textofNowWindDir = [NSMutableAttributedString new];
    {
        NSMutableAttributedString *tmpDir = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:%@级",MyWeather.weather[0].nowWeather.windInNow.dirInNow,MyWeather.weather[0].nowWeather.windInNow.scInNow]];
        tmpDir.font = [UIFont boldSystemFontOfSize:15.0];
        tmpDir.color = [UIColor blackColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        tmpDir.textShadow = shadow;
        [textofNowWindDir appendAttributedString:tmpDir];
        [textofNowWindDir appendAttributedString:[self padding]];
    }
    
    YYLabel *tmpWindDir = [[YYLabel alloc] init];
    tmpWindDir.attributedText = textofNowWindDir;
    tmpWindDir.textAlignment = NSTextAlignmentLeft;
    tmpWindDir.translatesAutoresizingMaskIntoConstraints = NO;
    _nowWindDir = tmpWindDir;
    
    [self.view addSubview:_nowWindDir];
    
    [_nowWindDir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 35));
        make.left.equalTo(self.view).offset(-110);
        make.top.equalTo(self.condIcon).offset(45);
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.8 animations:^{
                _nowWindDir.transform = CGAffineTransformMakeTranslation(120, 0);
            }];
        });
    });
    
#pragma mark - 湿度Label
    NSMutableAttributedString *textofHumidity = [NSMutableAttributedString new];
    {
        NSMutableAttributedString *tmpHumidity = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"湿度:%@%%",MyWeather.weather[0].nowWeather.humInNow]];
        tmpHumidity.font = [UIFont boldSystemFontOfSize:15.0];
        tmpHumidity.color = [UIColor blackColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        tmpHumidity.textShadow = shadow;
        [textofHumidity appendAttributedString:tmpHumidity];
        [textofHumidity appendAttributedString:[self padding]];
    }
    
    YYLabel *tmpHumidityLabel = [[YYLabel alloc] init];
    tmpHumidityLabel.attributedText = textofHumidity;
    tmpHumidityLabel.textAlignment = NSTextAlignmentLeft;
    tmpHumidityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _humidityLabel = tmpHumidityLabel;
    
    [self.view addSubview:_humidityLabel];
    
    [_humidityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 35));
        make.left.equalTo(self.view).offset(-110);
        make.top.equalTo(self.condIcon).offset(80);
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.8 animations:^{
                _humidityLabel.transform = CGAffineTransformMakeTranslation(120, 0);
            }];
        });
    });
    
#pragma mark - 日出Label
    NSMutableAttributedString *textofSunRise = [NSMutableAttributedString new];
    {
        NSString *tmp1 = [NSString stringWithFormat:@"%@",MyWeather.weather[0].dailyForecast[0].astroDLY.sr];
        NSString *tmp2 = [tmp1 substringFromIndex:1];
        NSMutableAttributedString *tmpSunRise = [[NSMutableAttributedString alloc] initWithString:tmp2];
        tmpSunRise.font = [UIFont boldSystemFontOfSize:15.0];
        tmpSunRise.color = [UIColor blackColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        tmpSunRise.textShadow = shadow;
        [textofSunRise appendAttributedString:tmpSunRise];
        [textofSunRise appendAttributedString:[self padding]];
    }
    
    YYLabel *tmpSunSetLabel = [[YYLabel alloc] init];
    tmpSunSetLabel.attributedText = textofSunRise;
    tmpSunSetLabel.textAlignment = NSTextAlignmentCenter;
    tmpSunSetLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _sunRiseLabel = tmpSunSetLabel;
    
    [self.view addSubview:_sunRiseLabel];
    
    [_sunRiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55, 35));
        make.right.equalTo(self.view).offset(99);
        make.top.equalTo(self.condIcon).offset(45);
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.8 animations:^{
                _sunRiseLabel.transform = CGAffineTransformMakeTranslation(-109, 0);
            }];
        });
    });
    
#pragma mark - 日落Label
    NSMutableAttributedString *textofSunSet = [NSMutableAttributedString new];
    {
        NSMutableAttributedString *tmpSunSet = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",MyWeather.weather[0].dailyForecast[0].astroDLY.ss]];
        tmpSunSet.font = [UIFont boldSystemFontOfSize:15.0];
        tmpSunSet.color = [UIColor blackColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        tmpSunSet.textShadow = shadow;
        [textofSunSet appendAttributedString:tmpSunSet];
        [textofSunSet appendAttributedString:[self padding]];
    }
    
    YYLabel *tmpSSetLabel = [[YYLabel alloc] init];
    tmpSSetLabel.attributedText = textofSunSet;
    tmpSSetLabel.textAlignment = NSTextAlignmentCenter;
    tmpSSetLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _sunSetLabel = tmpSSetLabel;
    
    [self.view addSubview:_sunSetLabel];
    
    [_sunSetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55, 35));
        make.right.equalTo(self.view).offset(99);
        make.top.equalTo(self.condIcon).offset(80);
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.8 animations:^{
                _sunSetLabel.transform = CGAffineTransformMakeTranslation(-109, 0);
            }];
        });
    });
    
#pragma mark - SR icon
    UIImageView *tmpsrIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sunRise"]];
    tmpsrIcon.contentMode = UIViewContentModeScaleAspectFill;
    
    _srIcon = tmpsrIcon;
    
    [self.view addSubview:_srIcon];
    
    [_srIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerY.equalTo(self.sunRiseLabel);
        make.left.equalTo(self.sunRiseLabel).offset(-34);
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.8 animations:^{
                _srIcon.transform = CGAffineTransformMakeTranslation(-109, 0);
            }];
        });
    });
    
#pragma mark - SS icon
    UIImageView *tmpssIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sunSet"]];
    tmpssIcon.contentMode = UIViewContentModeScaleAspectFill;
    
    _ssIcon = tmpssIcon;
    
    [self.view addSubview:_ssIcon];
    
    [_ssIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerY.equalTo(self.sunSetLabel);
        make.left.equalTo(self.sunSetLabel).offset(-34);
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.8 animations:^{
                _ssIcon.transform = CGAffineTransformMakeTranslation(-109, 0);
            }];
        });
    });
    
}

#pragma mark - 轮播
- (void)SetupRoundView{
    //suggestion
    // 服务器返回的生活建议不稳定 经常有空字典 没有办法
    HeWeather *MyWeather = [YYTool jsonToModel:jsonPath];
    if (MyWeather.weather[0].suggestion != nil)
    {
        RoundView * round = [[RoundView alloc]initWithFrame:CGRectMake(0, 429, 320, 44)];
        [round setLableFont:[UIFont systemFontOfSize:13.0]];
        [round setLableColor:[UIColor blackColor]];
        
        round.delegate = self;
        
        NSMutableArray *tmpTitles = [NSMutableArray array];
        //  有多少加多少
        if (MyWeather.weather[0].suggestion.drsg.txt != nil) {
            [tmpTitles addObject:MyWeather.weather[0].suggestion.drsg.txt];
        }
        if (MyWeather.weather[0].suggestion.comf.txt != nil) {
            [tmpTitles addObject:MyWeather.weather[0].suggestion.comf.txt];
        }
        if (MyWeather.weather[0].suggestion.cw.txt != nil) {
            [tmpTitles addObject:MyWeather.weather[0].suggestion.cw.txt];
        }
        if (MyWeather.weather[0].suggestion.flu.txt != nil) {
            [tmpTitles addObject:MyWeather.weather[0].suggestion.flu.txt];
        }
        if (MyWeather.weather[0].suggestion.sport.txt != nil) {
            [tmpTitles addObject:MyWeather.weather[0].suggestion.sport.txt];
        }
        if (MyWeather.weather[0].suggestion.trav.txt != nil) {
            [tmpTitles addObject:MyWeather.weather[0].suggestion.trav.txt];
        }
        if (MyWeather.weather[0].suggestion.uv.txt != nil) {
            [tmpTitles addObject:MyWeather.weather[0].suggestion.uv.txt];
        }
        NSArray *titlesArr = [tmpTitles copy];
        
        round.titles = titlesArr;
        
        [self.view addSubview:round];
    }else{
        //        [SVProgressHUD showErrorWithStatus:@"没有生活建议数据" maskType:SVProgressHUDMaskTypeClear];
        NSLog(@"%s----->并没有生活数据",__func__);
    }
}

/**
 *  bgImage
 */
- (void)setupImage{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgDay"]];
    imgV.frame = [UIScreen mainScreen].bounds;
    _backgroundImage = imgV;
    [self.view addSubview:_backgroundImage];
    [self.view sendSubviewToBack:_backgroundImage];
    
    
}
#pragma mark - roundView
- (void)RoundViewClickTheTitleWithNumber:(NSInteger)number
{
    NSLog(@"我点击了第%ld个标签",(long)number);
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}
//换行
- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.font = [UIFont systemFontOfSize:4];
    return pad;
}

#pragma mark - 点击切换选择城市
- (void)tapChangeLocBtn{

    NSLog(@"%s----->卧槽？",__func__);
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    SelectLocController *select = [[SelectLocController alloc] init];
    [self.navigationController pushViewController:select animated:YES];

}

#pragma mark - 用来测试的
- (void)nothing{
    NSLog(@"%s----->你点到我了",__func__);
}

#pragma mark - Grid
- (void)showGridMenu{
    
    CNPGridMenuItem *laterToday = [[CNPGridMenuItem alloc] init];
    laterToday.icon = [UIImage imageNamed:@"LaterToday"];
    laterToday.title = @"Later Today";
    
    CNPGridMenuItem *thisEvening = [[CNPGridMenuItem alloc] init];
    thisEvening.icon = [UIImage imageNamed:@"ThisEvening"];
    thisEvening.title = @"This Evening";
    
    CNPGridMenuItem *tomorrow = [[CNPGridMenuItem alloc] init];
    tomorrow.icon = [UIImage imageNamed:@"Tomorrow"];
    tomorrow.title = @"Tomorrow";
    
    CNPGridMenuItem *thisWeekend = [[CNPGridMenuItem alloc] init];
    thisWeekend.icon = [UIImage imageNamed:@"ThisWeekend"];
    thisWeekend.title = @"This Weekend";
    
    CNPGridMenuItem *nextWeek = [[CNPGridMenuItem alloc] init];
    nextWeek.icon = [UIImage imageNamed:@"NextWeek"];
    nextWeek.title = @"Next Week";
    
    CNPGridMenuItem *inAMonth = [[CNPGridMenuItem alloc] init];
    inAMonth.icon = [UIImage imageNamed:@"InMonth"];
    inAMonth.title = @"In A Month";
    
    CNPGridMenuItem *someday = [[CNPGridMenuItem alloc] init];
    someday.icon = [UIImage imageNamed:@"Someday"];
    someday.title = @"Someday";
    
    CNPGridMenuItem *desktop = [[CNPGridMenuItem alloc] init];
    desktop.icon = [UIImage imageNamed:@"Desktop"];
    desktop.title = @"Desktop";
    
    CNPGridMenuItem *pickDate = [[CNPGridMenuItem alloc] init];
    pickDate.icon = [UIImage imageNamed:@"PickDate"];
    pickDate.title = @"Pick Date";
    
    CNPGridMenu *gridMenu = [[CNPGridMenu alloc] initWithMenuItems:@[laterToday, thisEvening, tomorrow, thisWeekend, nextWeek, inAMonth, someday, desktop, pickDate]];
    gridMenu.delegate = self;
    [self presentGridMenu:gridMenu animated:YES completion:^{
        NSLog(@"Grid Menu Presented");
    }];
}

- (void)gridMenuDidTapOnBackground:(CNPGridMenu *)menu {
    [self dismissGridMenuAnimated:YES completion:^{
        NSLog(@"Grid Menu Dismissed With Background Tap");
    }];
}

- (void)gridMenu:(CNPGridMenu *)menu didTapOnItem:(CNPGridMenuItem *)item {
    [self dismissGridMenuAnimated:YES completion:^{
        NSLog(@"Grid Menu Did Tap On Item: %@", item.title);
        if ([item.title isEqualToString:@"This Evening"]) {
            [self tapChangeLocBtn];
        }
    }];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //如果是摇手机类型的事件
    if(motion == UIEventSubtypeMotionShake){
        NSLog(@"%s----->摇一摇",__func__);
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = @"cube";
        transition.subtype = kCATransitionFromRight;
        transition.delegate = self;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        
        [self playSoundofShake];
        [WeatherData requestDataFromHEserver];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (void)playSoundofShake{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake" ofType:@"wav"];
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shakeSound);
        AudioServicesPlaySystemSound(shakeSound);
        }
    
    AudioServicesPlaySystemSound(shakeSound);   //播放注册的声音
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);}
}
@end
