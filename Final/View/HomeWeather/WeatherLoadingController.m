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
#import "Settings.h"
#import <CoreLocation/CoreLocation.h>

#import "FLAnimatedImage.h"
#import "YYKit.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

//GIF Path
#define gifPath [[NSBundle mainBundle] pathForResource:@"loading.gif" ofType:nil]

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

//Plist
#define plistPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"settings.plist"]

@interface WeatherLoadingController () <CLLocationManagerDelegate>

@property (nonatomic, weak)YYLabel *loadingLabel;
@property (nonatomic, weak)FLAnimatedImageView *loadingImgV;

@property (nonatomic, strong)CLLocationManager *locManager;
@end

@implementation WeatherLoadingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
#pragma mark - 初始化GIF播放view
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:gifPath]];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(0.0, 0.0, ScreenW, ScreenH);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _loadingImgV = imageView;
    
    [self.view addSubview:_loadingImgV];

    [self.navigationController setNavigationBarHidden:YES];

#pragma mark - 判断是否需要申请开启定位
    [Settings initializePlist];
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath] mutableCopy];
    NSMutableDictionary *cityOfWeather = [infolist objectForKey:@"cityOfWeather"];
    
    NSString *valueOfNeedSetGPS = [cityOfWeather objectForKey:@"needSetWithGPS"];
    NSString *valueOfIsFirstLogin = [cityOfWeather objectForKey:@"isFirstLogin"];

    if ([valueOfIsFirstLogin isEqualToString:@"1"] || ([valueOfIsFirstLogin isEqualToString:@"0"] && [valueOfNeedSetGPS isEqualToString:@"1"])){
        NSLog(@"第一次登陆，或者设置了需要定位");
        [self initCLLocationManager];//开始定位--获得经纬度--发送给api换拼音--发送给setting来保存到plist
        [Settings isFirstLoginWillChange:@"0"];

    }else{
        NSLog(@"直接读取本地的数据并跳转");

        [self switch2Main];
    }
}

- (void)initCLLocationManager{
    /*
    ALAuthorizationStatusNotDetermined NS_ENUM_DEPRECATED_IOS(6_0, 9_0) = 0, // User has not yet made a choice with regards to this application
    ALAuthorizationStatusRestricted NS_ENUM_DEPRECATED_IOS(6_0, 9_0),        // This application is not authorized to access photo data.
    // The user cannot change this application’s status, possibly due to active restrictions
    //  such as parental controls being in place.
    ALAuthorizationStatusDenied NS_ENUM_DEPRECATED_IOS(6_0, 9_0),            // User has explicitly denied this application access to photos data.
    ALAuthorizationStatusAuthorized NS_ENUM_DEPRECATED_IOS(6_0, 9_0)        // User has authorized this application to access photos data.
     */

    
    _locManager = [[CLLocationManager alloc] init];
    
    
    //iOS 8
    if (![CLLocationManager locationServicesEnabled]) {//如果没有开启系统定位服务
        NSLog(@"定位服务没有开启");
        [_locManager requestWhenInUseAuthorization];//那就申请alert让用户去设置开启
        
        //10s后检查如果没有授权则请求用户授权
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
                NSLog(@"向用户申请定位权限");
                [_locManager requestWhenInUseAuthorization];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
                    _locManager.delegate = self;
                    _locManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
                    [_locManager startUpdatingLocation];
                    
                }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
                    [SVProgressHUD setAnimationDuration:1.0];
                    [SVProgressHUD showErrorWithStatus:@"未能获取定位"];
                    [Settings setWhatToDoAfterLoading:@"updateByID"];
                    
                    [self switch2Main];
                }
            });
        });
    }else{//如果系统定位服务已经开启
            //判断是否得到权限 没有的话申请
        NSLog(@"系统定位已开启，将申请定位权限");
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
                [_locManager requestWhenInUseAuthorization];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //4s后判断用户是否授权使用定位
                if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
                    _locManager.delegate = self;
                    _locManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
                    
                    [_locManager startUpdatingLocation];
                }else{//如果没有允许
                    NSLog(@"用户没有通过定位权限");
                    [Settings setWhatToDoAfterLoading:@"updateByID"];
                    [self switch2Main];
                }
            });
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [self loadingLabels];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)switch2Main{
    NSString *action = [Settings whatToDoAfterLoading];
    if (![action isEqualToString:@"1st"]) {
        if ([action isEqualToString:@"updateByRefresh"]) {
            NSLog(@"byRefresh");
            [WeatherData requestDataFromHEserverWithWhat:@"byRefresh"];
        }else if([action isEqualToString:@"updateByID"]){
            NSLog(@"byId");
            [WeatherData requestDataFromHEserverWithWhat:@"byID"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WeatherViewController *weather = [[WeatherViewController alloc] init];
            [self.navigationController pushViewController: weather animated:YES];
        });
    }else{
        NSLog(@"第一次登陆 等待数据结果");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstPush) name:@"JSON GET" object:nil];
        }
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
    
    

}

#pragma mark - 更新位置
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations[0];
    NSLog(@"--%@--",location);
    NSString *longtitude = [NSString stringWithFormat:@"%.2f",location.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%.2f",location.coordinate.latitude];
    
    [WeatherData getNameOfCityWithlon:longtitude lat:latitude];//把地理坐标传递出去
    
    NSLog(@"地理坐标经度%@,纬度%@交给OpenWeatherAPI来获取城市名字",longtitude,latitude);
    [self.locManager stopUpdatingLocation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"来自定位中的方法，开始跳转到主界面");
        [self switch2Main];
    });
}

- (void)firstPush{
//    [SVProgressHUD showErrorWithStatus:@"获取定位信息失败，请在设置中选择城市"];
    WeatherViewController *weather = [[WeatherViewController alloc] init];
    [self.navigationController pushViewController:weather animated:YES];
}
@end
