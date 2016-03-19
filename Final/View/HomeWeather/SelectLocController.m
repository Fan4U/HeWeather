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


//citiesModel
#import "CitiesModel.h"
//#import "Province.h"
//#import "Cities.h"
//weather data
#import "WeatherData.h"

#import "Masonry.h"
#import "YYTool.h"

//locdata
#import "HeWeather.h"

//codelist
#define codeList [[NSBundle mainBundle] pathForResource:@"cityID.json" ofType:nil]
// RGB颜色
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface SelectLocController () <UIPickerViewDelegate,UIPickerViewDataSource>

//picker for choose location
@property (nonatomic, strong)UIPickerView *locPicker;
@property (nonatomic, assign)int provinceIndex;
//@property (nonatomic, strong)CitiesModel *cityModel;

//buttons
@property (nonatomic, strong)UIButton *ok;
@property (nonatomic, strong)UIButton *back;

@property (nonatomic, strong)CitiesModel *citiesModelInSel;
@end

@implementation SelectLocController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgSelect"]];

    [self setupPickerView];
    [self setupBtns];
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
    return YES;
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
//    [tmpPicker setBackgroundColor:[UIColor blackColor]];
 
    _locPicker = tmpPicker;
    
    [self.view addSubview:_locPicker];
    
    [_locPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(320, 180));
        make.center.equalTo(self.view);
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
        
        self.provinceIndex = row;
        //        刷新右边数据
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}


- (void)setupBtns{
    
#pragma mark - OK
    UIButton *tmpOK = [[UIButton alloc] init];
    [tmpOK setTitle:@"确定" forState:UIControlStateNormal];
    [tmpOK setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tmpOK setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(6, 6, 6, 6);
    UIImage *btnImg = [[UIImage imageNamed:@"btn"] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    [tmpOK addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
    [tmpOK setBackgroundImage:btnImg forState:UIControlStateNormal];
    
    _ok = tmpOK;
    [self.view addSubview:_ok];
    

#pragma mark - Back
    UIButton *tmpBack = [[UIButton alloc] init];
    [tmpBack setTitle:@"返回" forState:UIControlStateNormal];
    [tmpBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tmpBack setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    UIEdgeInsets insets2 = UIEdgeInsetsMake(6, 6, 6, 6);
    UIImage *btnImg2 = [[UIImage imageNamed:@"btn"] resizableImageWithCapInsets:insets2 resizingMode:UIImageResizingModeStretch];
    
    [tmpBack addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [tmpBack setBackgroundImage:btnImg2 forState:UIControlStateNormal];
    
    _back = tmpBack;
    [self.view addSubview:_back];
    

#pragma mark - Masonry
    [_ok mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 44));
        make.centerY.equalTo(_locPicker).offset(150);
        make.centerX.equalTo(self.view).offset(-80);

    }];
    
    [_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 44));
        make.centerY.mas_equalTo(_locPicker).offset(150);
        make.centerX.equalTo(self.view).offset(80);
    }];
  
}

#pragma mark - 点击方法
- (void)okClick{

        CitiesModel *model = [YYTool listToModel:codeList];
        NSInteger proNum = [_locPicker selectedRowInComponent:0];  //左边的编号
        NSInteger cityNum = [_locPicker selectedRowInComponent:1];  //右边的编号
        
        //通过编号去模型里找出那个城市的code string
        NSString *selectedCity = [NSString stringWithFormat:@"%@",model.province[proNum].cities[cityNum].cityCode];
        [Settings initializePlist];
        [Settings CitySettingsWillModified:selectedCity];
        NSLog(@"%s----->交由Setting判断是否需要修改城市ID",__func__);
//        if ([Settings CitySettingsWillModified:selectedCity]) {
            CATransition *transition = [CATransition animation];
            transition.duration = 1.0f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = @"cube";
            transition.subtype = kCATransitionFromRight;
            transition.delegate = self;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
//        }
#warning 想法并没有错 只是问题出在重绘label以及轮播，待解决
//        else
//        {
//            NSLog(@"%s----->所选城市与本地相同，返回",__func__);
//            [self.navigationController popViewControllerAnimated:YES];
//        }

#warning 用工具转成拼音并去空格  成都会转化成chengdou 目前无解， 换新的api后采用城市id来保存
//    NSString *result = [YYTool transform:selectedCity];

}

- (void)backClick{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
