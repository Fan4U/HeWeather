//
//  WeatherLoadingController.m
//  Final
//
//  Created by pro on 16/3/16.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "WeatherLoadingController.h"
#import "WeatherViewController.h"
#import "WeatherData.h"
#import <CoreLocation/CoreLocation.h>

#import "FLAnimatedImage.h"
#import "YYKit.h"
#import "Masonry.h"
//GIF Path
#define gifPath [[NSBundle mainBundle] pathForResource:@"loading.gif" ofType:nil]

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface WeatherLoadingController () <CLLocationManagerDelegate>

@property (nonatomic, weak)YYLabel *loadingLabel;
@property (nonatomic, weak)YYLabel *okLabel;
@property (nonatomic, weak)FLAnimatedImageView *loadingImgV;

@property (nonatomic, strong)CLLocationManager *locManager;
@end

@implementation WeatherLoadingController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WeatherData loadWeatherData];
    });
    
#pragma mark - 初始化GIF播放view
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:gifPath]];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(0.0, 0.0, ScreenW, ScreenH);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.userInteractionEnabled = NO;//后面动画完了自动跳转
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switch2Main)];
    [imageView addGestureRecognizer:tap];
    
    _loadingImgV = imageView;
    
    [self.view addSubview:_loadingImgV];
    
#pragma mark - 是否隐藏nav
    [self.navigationController setNavigationBarHidden:YES];
    
#pragma mark - init CLLocationManager
    self.locManager = [CLLocationManager new];
    
    [self.locManager requestWhenInUseAuthorization];
    self.locManager.delegate = self;
    [self.locManager startUpdatingLocation];
    self.locManager.distanceFilter = 500;
    self.locManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;

}


- (void)viewWillAppear:(BOOL)animated{
    [self loadingLabels];

    
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)switch2Main{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    WeatherViewController *weather = [[WeatherViewController alloc] init];
    [self.navigationController pushViewController: weather animated:YES];
    
}

- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.font = [UIFont systemFontOfSize:4];
    return pad;
}

- (void)loadingLabels{
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"读取天气中..."];
        one.font = [UIFont boldSystemFontOfSize:20];
        one.color = [UIColor whiteColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.textShadow = shadow;
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
    }
    
    //init tmp YYlabel
    YYLabel *loading = [[YYLabel alloc] initWithFrame:CGRectMake(110, 120, 180, 60)];
    loading.textAlignment = NSTextAlignmentCenter;
    loading.translatesAutoresizingMaskIntoConstraints = NO;
    loading.attributedText = text;
    
    _loadingLabel = loading;
    
    [self.loadingImgV addSubview:_loadingLabel];
    
    
#pragma mark - OK Label
    
    NSMutableAttributedString *textOK = [NSMutableAttributedString new];
    
    {
        NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:@"载入完成！"];
        two.font = [UIFont boldSystemFontOfSize:20];
        two.color = [UIColor whiteColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        two.textShadow = shadow;
        [textOK appendAttributedString:two];
        [textOK appendAttributedString:[self padding]];
    }
    
    //init tmp YYlabel
    YYLabel *tmpOkLabel = [[YYLabel alloc] initWithFrame:CGRectMake(120, 200, 180, 60)];
    tmpOkLabel.textAlignment = NSTextAlignmentCenter;
    tmpOkLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tmpOkLabel.attributedText = textOK;
    tmpOkLabel.alpha = 0;
    
    _okLabel = tmpOkLabel;
    
    [self.loadingImgV addSubview:_okLabel];
    
    [_okLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    [_loadingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_okLabel).offset(- self.view.frame.size.height / 6);
        make.centerX.equalTo(_okLabel);
    }];
    
#pragma mark - 动画部分
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.6 animations:^{
            _loadingLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.6 animations:^{
                _okLabel.alpha = 1;
            } completion:^(BOOL finished) {
                //                imageView.userInteractionEnabled = YES;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self switch2Main];
                    _okLabel.alpha = 0; //得恢复成透明 不然下次回来是直接出现的
                });
            }];
        }];
    });
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations[0];
    NSLog(@"--%@--",location);
    NSString *longtitude = [NSString stringWithFormat:@"%.2f",location.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%.2f",location.coordinate.latitude];
    
    [WeatherData getNameOfCityWithlon:longtitude lat:latitude];
    
    NSLog(@"%@---%@",longtitude,latitude);
    [self.locManager stopUpdatingLocation];

}
@end
