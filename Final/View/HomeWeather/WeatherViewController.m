//
//  WeatherViewController.m
//  Final
//
//  Created by pro on 16/3/13.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "WeatherViewController.h"
#import "SelectLocController.h"
#import "SettingsViewController.h"
//#import <AudioToolbox/AudioToolbox.h>

//weather
#import "WeatherData.h"
#import "HeWeather.h"
#import "DailyView.h"

//tools
#import "DateCompare.h"
#import "YYTool.h"
#import "YYKit.h"
#import "UIView+Extension.h"
#import "Settings.h"

//other
#import "RoundView.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

//JSON Path
#define jsonPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"weather.json"]

// RGB颜色
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

//static SystemSoundID shakeSound = 0;如果播放声音的话

@interface WeatherViewController () <RoundViewDelegate>

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
@property (nonatomic, weak)YYLabel *lastUpdTimeLabel;
//view of 7days
@property (nonatomic, weak)DailyView *dailyView;
//ImgV
@property (nonatomic, weak)UIImageView *backgroundImage;
@property (nonatomic, weak)UIImageView *srIcon;
@property (nonatomic, weak)UIImageView *ssIcon;
//weather data
@property (nonatomic, strong)HeWeather *weatherDataInMain;
//round View
@property (nonatomic, weak)RoundView *myRoundView;
//swipe
@property (nonatomic, strong)UISwipeGestureRecognizer *left;
@property (nonatomic, strong)UISwipeGestureRecognizer *right;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    主界面
    [self setupImage];
    [self becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [self initInterface];
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self removeInterface];
}

- (void)removeInterface{
    _weatherDataInMain = nil;
    [_cityLabel removeFromSuperview];
    [_tempLabel removeFromSuperview];
    [_condIcon removeFromSuperview];
    [_nowWindDir removeFromSuperview];
    [_humidityLabel removeFromSuperview];
    [_sunRiseLabel removeFromSuperview];
    [_sunSetLabel removeFromSuperview];
    [_ssIcon removeFromSuperview];
    [_srIcon removeFromSuperview];
    [_dailyView removeFromSuperview];
    [_myRoundView removeFromSuperview];
}

- (void)initInterface{
    NSLog(@"开始显示界面");
    //labels
    [self setupWelcomLabel];
    [self setLabels];
    [self SetupRoundView];
    
    //swipe
    self.left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchToSettings)];
    self.right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popForRefresh)];
    self.left.direction = UISwipeGestureRecognizerDirectionLeft;
    self.right.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.left];
    [self.view addGestureRecognizer:self.right];
    
    //temp
    [Settings isNeedSetWithGPSWillChange:@"0"];
    
    
    //如果第一次登陆 在这里写入plist
    if([Settings isFirstLogin]){
        NSString *cityName = [NSString stringWithFormat:@"%@",self.weatherDataInMain.weather[0].basic.city];
        NSString *cityID   = [NSString stringWithFormat:@"%@",self.weatherDataInMain.weather[0].basic.cityID];
        [Settings cityWillModifiedWithCityID:cityID andCityName:cityName];
        
    }

}

- (HeWeather *)weatherDataInMain{
    if (!_weatherDataInMain) {
        _weatherDataInMain = [YYTool localJSONToModel];
    }
    return _weatherDataInMain;
}

- (BOOL)canBecomeFirstResponder{
    return YES;
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
    
    welcome.text = [NSString stringWithFormat:@"%@天了,加油！！",SinceThatDay];
    welcome.textColor = [UIColor whiteColor];
    
    [self.view addSubview:welcome];
    [UIView animateWithDuration:1.1 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        welcome.transform = CGAffineTransformMakeTranslation(0, 44);
        //        welcome.top = 44;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.1 delay:1.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            welcome.transform = CGAffineTransformMakeTranslation(0, -44);
        } completion:^(BOOL finished) {
            [welcome removeFromSuperview];
            [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _lastUpdTimeLabel.alpha = 1;
            } completion:nil];
        }];
    }];
    
}


- (void)setLabels{

#pragma mark - 温度label 也是约束的对照点
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    //设置富文本 ----温度
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@°C %@",self.weatherDataInMain.weather[0].nowWeather.tmpInNow,self.weatherDataInMain.weather[0].nowWeather.condInNow.txtInNow]];
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
    
    // only available after [self.view addSubview:_tempLabel]!
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
        NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.weatherDataInMain.weather[0].basic.city]];
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
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.weatherDataInMain.weather[0].nowWeather.condInNow.codeInNow]]];
    
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
    
    
#pragma mark - 7days Label
    
    DailyView *tmpDailyView = [DailyView loadFromNib];
    tmpDailyView.myWeather = self.weatherDataInMain;
    
    _dailyView = tmpDailyView;
    _dailyView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:_dailyView];
    
    [_dailyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenW, ScreenH / 4));
        make.bottom.equalTo(self.view).offset(- 55);
        make.left.equalTo(self.view);
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.2 animations:^{
                _dailyView.titleDay1.alpha = 1;
                _dailyView.minDay1.alpha = 1;
                _dailyView.maxDay1.alpha = 1;
                _dailyView.condDay1.alpha = 1;
            }];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.2 animations:^{
                _dailyView.titleDay2.alpha = 1;
                _dailyView.minDay2.alpha = 1;
                _dailyView.maxDay2.alpha = 1;
                _dailyView.condDay2.alpha = 1;
            }];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.2 animations:^{
                _dailyView.titleDay3.alpha = 1;
                _dailyView.minDay3.alpha = 1;
                _dailyView.maxDay3.alpha = 1;
                _dailyView.condDay3.alpha = 1;
            }];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.2 animations:^{
                _dailyView.titleDay4.alpha = 1;
                _dailyView.minDay4.alpha = 1;
                _dailyView.maxDay4.alpha = 1;
                _dailyView.condDay4.alpha = 1;
            }];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.2 animations:^{
                _dailyView.titleDay5.alpha = 1;
                _dailyView.minDay5.alpha = 1;
                _dailyView.maxDay5.alpha = 1;
                _dailyView.condDay5.alpha = 1;
            }];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.2 animations:^{
                _dailyView.titleDay6.alpha = 1;
                _dailyView.minDay6.alpha = 1;
                _dailyView.maxDay6.alpha = 1;
                _dailyView.condDay6.alpha = 1;
            }];
        });
});
    


#pragma mark - 风向Label
    NSMutableAttributedString *textofNowWindDir = [NSMutableAttributedString new];
    {
        NSMutableAttributedString *tmpDir = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:%@级",self.weatherDataInMain.weather[0].nowWeather.windInNow.dirInNow,self.weatherDataInMain.weather[0].nowWeather.windInNow.scInNow]];
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
        NSMutableAttributedString *tmpHumidity = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"湿度:%@%%",self.weatherDataInMain.weather[0].nowWeather.humInNow]];
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
        NSString *tmp1 = [NSString stringWithFormat:@"%@",self.weatherDataInMain.weather[0].dailyForecast[0].astroDLY.sr];
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
        NSMutableAttributedString *tmpSunSet = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.weatherDataInMain.weather[0].dailyForecast[0].astroDLY.ss]];
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
    
#pragma mark - 最后更新
    NSMutableAttributedString *attrTxt4upd = [NSMutableAttributedString new];
    {
        NSMutableAttributedString *tmpAttrTxt4upd = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最后更新:%@",self.weatherDataInMain.weather[0].basic.update.loc]];
        tmpAttrTxt4upd.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightUltraLight];
        tmpAttrTxt4upd.color = [UIColor blackColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        tmpAttrTxt4upd.textShadow = shadow;
        [attrTxt4upd appendAttributedString:tmpAttrTxt4upd];
        [attrTxt4upd appendAttributedString:[self padding]];
    }
    
    //init tmp YYlabel
    YYLabel *updLabelTmp = [[YYLabel alloc] init];
    updLabelTmp.textAlignment = NSTextAlignmentLeft;
    updLabelTmp.translatesAutoresizingMaskIntoConstraints = NO;
    updLabelTmp.attributedText = attrTxt4upd;
    
    
    _lastUpdTimeLabel = updLabelTmp;
    _lastUpdTimeLabel.alpha = 0;
    
    [self.view addSubview:_lastUpdTimeLabel];
    
    [_lastUpdTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置size
        make.size.mas_equalTo(CGSizeMake(200, 20));
        make.left.equalTo(self.view).offset(5);
        make.top.equalTo(self.view).offset(3);
    }];



}

#pragma mark - 轮播
- (void)SetupRoundView{

    if (self.weatherDataInMain.weather[0].suggestion != nil)
    {
        RoundView * round = [[RoundView alloc]initWithFrame:CGRectMake(10, ScreenH - 44, ScreenW - 20, 44)];
        [round setLableFont:[UIFont systemFontOfSize:13.0]];
        [round setLableColor:[UIColor blackColor]];
        
        round.delegate = self;
        
        NSMutableArray *tmpTitles = [NSMutableArray array];
        //  有多少加多少
        if (self.weatherDataInMain.weather[0].suggestion.drsg.txt != nil) {
            [tmpTitles addObject:self.weatherDataInMain.weather[0].suggestion.drsg.txt];
        }
        if (self.weatherDataInMain.weather[0].suggestion.comf.txt != nil) {
            [tmpTitles addObject:self.weatherDataInMain.weather[0].suggestion.comf.txt];
        }
        if (self.weatherDataInMain.weather[0].suggestion.cw.txt != nil) {
            [tmpTitles addObject:self.weatherDataInMain.weather[0].suggestion.cw.txt];
        }
        if (self.weatherDataInMain.weather[0].suggestion.flu.txt != nil) {
            [tmpTitles addObject:self.weatherDataInMain.weather[0].suggestion.flu.txt];
        }
        if (self.weatherDataInMain.weather[0].suggestion.sport.txt != nil) {
            [tmpTitles addObject:self.weatherDataInMain.weather[0].suggestion.sport.txt];
        }
        if (self.weatherDataInMain.weather[0].suggestion.trav.txt != nil) {
            [tmpTitles addObject:self.weatherDataInMain.weather[0].suggestion.trav.txt];
        }
        if (self.weatherDataInMain.weather[0].suggestion.uv.txt != nil) {
            [tmpTitles addObject:self.weatherDataInMain.weather[0].suggestion.uv.txt];
        }
        NSArray *titlesArr = [tmpTitles copy];
        
        round.titles = titlesArr;
        
        _myRoundView = round;
        
        [self.view addSubview:_myRoundView];
    }else{
        NSLog(@"%s----->并没有生活数据",__func__);
    }
}

#pragma mark - 背景图片
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
    if (number == 0) {
    }
    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"%@",self.myRoundView.titles[0]]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

#pragma mark 换行
- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.font = [UIFont systemFontOfSize:4];
    return pad;
}

#pragma mark - 转向设置界面
- (void)switchToSettings{
    
    SettingsViewController *settings = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:settings animated:YES];

}

#pragma mark - 摇动事件
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //如果是摇手机类型的事件
    if(motion == UIEventSubtypeMotionShake){
        NSLog(@"%s----->摇一摇",__func__);
        [self popForRefresh];
    }
}

- (void)popForRefresh{
    
    [Settings setWhatToDoAfterLoading:@"updateByRefresh"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//不播放声音
//- (void)playSoundofShake{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake" ofType:@"wav"];
//    if (path) {
//        //注册声音到系统
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shakeSound);
//        AudioServicesPlaySystemSound(shakeSound);
//        }
//    
//    AudioServicesPlaySystemSound(shakeSound);   //播放注册的声音
////    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);}
//}


@end