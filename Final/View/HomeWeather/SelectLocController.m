//
//  SelectLocController.m
//  Final
//
//  Created by pro on 16/3/15.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "SelectLocController.h"
#import "Settings.h"
#import "WeatherLoadingController.h"
#import "SettingsViewController.h"


//citiesModel
#import "CitiesModel.h"

//weather data
#import "WeatherData.h"

//tool
#import "Masonry.h"
#import "YYTool.h"
#import "SVProgressHUD.h"

//locdata
#import "HeWeather.h"

//codelist
#define codeList [[NSBundle mainBundle] pathForResource:@"cityID.json" ofType:nil]
// RGB颜色
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define RecentChoiceButtonW ([UIScreen mainScreen].bounds.size.width - 25) / 4
#define choicePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"recent.plist"]

@interface SelectLocController () <UIPickerViewDelegate,UIPickerViewDataSource>

//picker for choose location
@property (nonatomic, weak)UIPickerView *locPicker;
@property (nonatomic, assign)int provinceIndex;
//buttons
@property (nonatomic, weak)UIButton *ok;
@property (nonatomic, weak)UIButton *back;
//model
@property (nonatomic, strong)CitiesModel *citiesModelInSel;
//recentChoiceButton
@property (nonatomic, weak)UIButton *recentChoiceButton;
@property (nonatomic, weak)UIButton *recentChoiceButton1;
@property (nonatomic, strong)NSArray *recentChoicesArr;

@end

@implementation SelectLocController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(248, 248, 248);
    self.view.frame = CGRectMake(0, 0, ScreenW, ScreenH / 2);
    self.view.alpha = 0.95;

    [self setupPickerView];
    [self setupBtns];

}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (CitiesModel *)citiesModelInSel{
    if (!_citiesModelInSel) {
        CitiesModel *model = [YYTool listToModel:codeList];
        _citiesModelInSel = model;
    }
    return _citiesModelInSel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

#pragma mark - Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

/**
 *  PickerView
 */
- (void)setupPickerView{
    UIPickerView *tmpPicker = [[UIPickerView alloc] init];
    tmpPicker.delegate = self;
    tmpPicker.dataSource = self;
 
    _locPicker = tmpPicker;
    
    [self.view addSubview:_locPicker];
    
    [_locPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenW, ScreenH / 3));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(40);
    }];
    
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
//    CitiesModel *model = [YYTool listToModel:codeList];
    if (component == 0 ) {
        return self.citiesModelInSel.province.count;
    }else{
        Province *pro = self.citiesModelInSel.province[self.provinceIndex];
        return pro.cities.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{


//    CitiesModel *model = [YYTool listToModel:codeList];
    if (component == 0) {
        return self.citiesModelInSel.province[row].proName;
    }else{
        return self.citiesModelInSel.province[self.provinceIndex].cities[row].cityName;
    }
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    CitiesModel *model = [YYTool listToModel:codeList];
    
    if (component == 0) {
//        Province *province = model.province[row];
        
        self.provinceIndex = (int)row;
        //        刷新右边数据
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}


- (void)setupBtns{
    
#pragma mark - OK
    UIButton *tmpOK = [UIButton buttonWithType:UIButtonTypeCustom];

    tmpOK.layer.cornerRadius  = 5.0f;
    tmpOK.layer.borderColor = Color(20, 155, 213).CGColor;
    tmpOK.layer.borderWidth = 1.5f;
    tmpOK.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
    
    [tmpOK setTitle:@"确定" forState:UIControlStateNormal];
    [tmpOK setTitleColor:Color(20, 155, 213) forState:UIControlStateNormal];
    [tmpOK setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [tmpOK addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
    [tmpOK addTarget:self action:@selector(changeColorTouchDown:) forControlEvents:UIControlEventTouchDown];
    [tmpOK addTarget:self action:@selector(changeColorTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
    _ok = tmpOK;
    [self.view addSubview:_ok];
    

#pragma mark - Back
    UIButton *tmpBack = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpBack.backgroundColor = Color(248, 248, 248);
    tmpBack.layer.cornerRadius  = 5.0f;
    tmpBack.layer.borderColor = Color(20, 155, 213).CGColor;
    tmpBack.layer.borderWidth = 1.5f;
    tmpBack.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
    
    [tmpBack setTitle:@"返回" forState:UIControlStateNormal];
    [tmpBack setTitleColor:Color(20, 155, 213) forState:UIControlStateNormal];
    [tmpBack setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    
    [tmpBack addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [tmpBack addTarget:self action:@selector(changeColorTouchDown:) forControlEvents:UIControlEventTouchDown];
    [tmpBack addTarget:self action:@selector(changeColorTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
    _back = tmpBack;
    [self.view addSubview:_back];
    
#pragma mark - recent

    {

        if (![[Settings getRecentChoicedCityInfo][0] isEqualToString:@"0"]) {
            UIButton *recent = [UIButton buttonWithType:UIButtonTypeCustom];
            recent.backgroundColor = Color(248, 248, 248);
            recent.layer.cornerRadius  = 5.0f;
            recent.layer.borderColor = Color(20, 155, 213).CGColor;
            recent.layer.borderWidth = 1.5f;
            recent.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightLight];
            
            NSString *cityName = [Settings getRecentChoicedCityInfo][0];
            [recent setTitle:cityName forState:UIControlStateNormal];
            [recent setTitleColor:Color(20, 155, 213) forState:UIControlStateNormal];
            [recent setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            recent.tag = 1;
            
            [recent addTarget:self action:@selector(recentCityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [recent addTarget:self action:@selector(changeColorTouchDown:) forControlEvents:UIControlEventTouchDown];
            [recent addTarget:self action:@selector(changeColorTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
            _recentChoiceButton = recent;
            [self.view addSubview:_recentChoiceButton];
            
            [_recentChoiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(RecentChoiceButtonW, 25));
                make.centerX.equalTo(self.view).offset(- RecentChoiceButtonW / 2 - 5);
                make.centerY.equalTo(_ok);
            }];
        }

    }
    
    {
        if (![[Settings getRecentChoicedCityInfo][2] isEqualToString:@"0"]) {
            UIButton *recent = [UIButton buttonWithType:UIButtonTypeCustom];
            recent.backgroundColor = Color(248, 248, 248);
            recent.layer.cornerRadius  = 5.0f;
            recent.layer.borderColor = Color(20, 155, 213).CGColor;
            recent.layer.borderWidth = 1.5f;
            recent.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightLight];
            
            NSString *cityName = [Settings getRecentChoicedCityInfo][2];
            [recent setTitle:cityName forState:UIControlStateNormal];
            [recent setTitleColor:Color(20, 155, 213) forState:UIControlStateNormal];
            [recent setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            recent.tag = 2;
            
            
            [recent addTarget:self action:@selector(recentCityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [recent addTarget:self action:@selector(changeColorTouchDown:) forControlEvents:UIControlEventTouchDown];
            [recent addTarget:self action:@selector(changeColorTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
            _recentChoiceButton1 = recent;
            [self.view addSubview:_recentChoiceButton1];
            
            [_recentChoiceButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(RecentChoiceButtonW, 25));
                make.centerX.equalTo(self.view).offset(RecentChoiceButtonW / 2 + 5);
                make.centerY.equalTo(_ok);
            }];
        }

    }
    
#pragma mark - Masonry
    [_ok mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.right.equalTo(self.view).offset(-5);
        make.top.equalTo(self.view).offset(5);

    }];
    
    [_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.left.equalTo(self.view).offset(5);
        make.top.equalTo(self.view).offset(5);
    }];
    

}

#pragma mark - 点击方法
- (void)okClick:(UIButton *)sender{
    sender.backgroundColor = [UIColor whiteColor];
    CitiesModel *model = [YYTool listToModel:codeList];
    NSInteger proNum = [_locPicker selectedRowInComponent:0];  //左边的编号
    NSInteger cityNum = [_locPicker selectedRowInComponent:1];  //右边的编号
    
    //通过编号去模型里找出那个城市的code string
    NSString *selectedCityCode = [NSString stringWithFormat:@"%@",model.province[proNum].cities[cityNum].cityCode];
    NSString *selectedCityName = [NSString stringWithFormat:@"%@",model.province[proNum].cities[cityNum].cityName];

    [self doSomethingWithChoicedCityName:selectedCityName andCityCode:selectedCityCode];
}

//主要的确定方法
- (void)doSomethingWithChoicedCityName:(NSString*)cityName andCityCode:(NSString *)cityCode{
    
    [Settings cityWillModifiedWithCityID:cityCode andCityName:cityName];
    [Settings setRecentChoicedCityName:cityName andCityCode:cityCode];
    
    [Settings setWhatToDoAfterLoading:@"updateByID"];
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WeatherData requestDataFromHEserverWithWhat:@"byID"];
        });
    });
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ScreenH / 2);
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedReload" object:nil];
    }];
}

- (void)backClick:(UIButton *)sender{
    sender.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ScreenH / 2);
    } completion:^(BOOL finished) {
    }];
}

- (void)recentCityButtonClick:(UIButton *)sender{

    if (sender.tag == 1) {
        [self doSomethingWithChoicedCityName:[Settings getRecentChoicedCityInfo][0] andCityCode:[Settings getRecentChoicedCityInfo][1]];
    }else if (sender.tag == 2){
        [self doSomethingWithChoicedCityName:[Settings getRecentChoicedCityInfo][2] andCityCode:[Settings getRecentChoicedCityInfo][3]];
    }
}

- (void)changeColorTouchDown:(UIButton *)sender{
    sender.backgroundColor = Color(20, 155, 213);
}

- (void)changeColorTouchUp:(UIButton *)sender{
    sender.backgroundColor = [UIColor whiteColor];
}
@end
