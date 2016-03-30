//
//  SettingsViewController.m
//  Final
//
//  Created by pro on 16/3/23.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "SettingsViewController.h"
#import "SelectLocController.h"
#import "YYTool.h"
#import "Settings.h"
#import "Masonry.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define Blue [UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]

@interface SettingsViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, weak)UISegmentedControl *styleSwitch;
@property (nonatomic, weak)UISwitch *animationSwitch;
@property (nonatomic, weak)UISwitch *warnOfRainSwitch;
//城市选择
@property (nonatomic, strong)SelectLocController *selectCityPicker;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.tableView.backgroundColor  = [UIColor grayColor];
    self.navigationItem.title  = @"设置";
    self.navigationController.navigationBarHidden = NO;
    
//    tableView
    UITableView *tmp           = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tmp.backgroundColor        = [UIColor whiteColor];
    self.tableView             = tmp;
    self.tableView.delegate    = self;
    self.tableView.dataSource  = self;
    
    [self.view addSubview:_tableView];
    
    SelectLocController *select = [[SelectLocController alloc] init];
    select.view.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH / 2);
    _selectCityPicker = select;
    [self.view addSubview:_selectCityPicker.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadData)
                                                 name:@"NeedReload" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"NeedReload"
                                                  object:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 1) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];  //删除并进行重新分配
        }
    }
    cell.textLabel.text = [NSString stringWithFormat:@"待定"];
    
    //选择城市
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"当前城市";
        cell.imageView.frame = CGRectMake(0, 5, 31, 31);
        cell.detailTextLabel.text = [Settings cityName];
    }
    
    //图表
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"一周视图";
        NSArray *styleArray = @[@"高低温度",@"平均气温"];
        UISegmentedControl *segOfDailyViewStyle = [[UISegmentedControl alloc] initWithItems:styleArray];
        if ([[Settings styleOfDailyView] isEqualToString:@"cond"]) {
            segOfDailyViewStyle.selectedSegmentIndex = 0;
        }else{
            segOfDailyViewStyle.selectedSegmentIndex = 1;
        }
//        segOfDailyViewStyle.frame = CGRectMake(ScreenW - 130, 5, 120, 30);
        segOfDailyViewStyle.tintColor = Blue;
        [segOfDailyViewStyle addTarget:self action:@selector(switchWhichStyleOfDailyView:) forControlEvents:UIControlEventValueChanged];

        _styleSwitch = segOfDailyViewStyle;
        
        [cell.contentView addSubview:_styleSwitch];
        [_styleSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 30));
            make.right.equalTo(cell.contentView).offset(- 10);
            make.centerY.equalTo(cell.contentView);
        }];
    }
    
    //动画
    if (indexPath.section == 1 && indexPath.row == 1) {
        cell.textLabel.text = @"动画切换";
        UISwitch *switcher = [[UISwitch alloc]init];//WithFrame:CGRectMake(ScreenW - 80 , 2, 60, 40)
        switcher.onTintColor = Blue;
        if ([Settings useCoreAnimation]) {
            [switcher setOn:YES animated:YES];
        }else{
            [switcher setOn:NO animated:YES];
        }
        [switcher addTarget:self action:@selector(switchWhetherUsingCoreAnimation) forControlEvents:UIControlEventValueChanged];
        _animationSwitch = switcher;
        [cell.contentView addSubview:_animationSwitch];
        [_animationSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 40));
            make.right.equalTo(cell.contentView).offset(25);
            make.centerY.equalTo(cell.contentView).offset(5);
        }];
    }
    
    //雨天提醒
    if (indexPath.section == 1 && indexPath.row == 2) {
        cell.textLabel.text = @"雨天提醒";
        UISwitch *switcher = [[UISwitch alloc]init];//WithFrame:CGRectMake(ScreenW - 80 , 2, 60, 40)
        switcher.onTintColor = Blue;
        if ([Settings warnOfRain]) {
            [switcher setOn:YES animated:YES];
        }else{
            [switcher setOn:NO animated:YES];
        }
        [switcher addTarget:self action:@selector(switchWhetherWarnOfRain) forControlEvents:UIControlEventValueChanged];
        _warnOfRainSwitch = switcher;

        [cell.contentView addSubview:_warnOfRainSwitch];
        [_warnOfRainSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 40));
            make.right.equalTo(cell.contentView).offset(25);
            make.centerY.equalTo(cell.contentView).offset(5);
        }];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}




#pragma mark - 点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        [UIView animateWithDuration:1.0 animations:^{
            _selectCityPicker.view.transform = CGAffineTransformMakeTranslation(0, - ScreenH / 2);
        } completion:^(BOOL finished) {
        
        }];
    }
}

- (void)switchWhichStyleOfDailyView:(UISegmentedControl *)segmentControl{
    NSInteger styleID = segmentControl.selectedSegmentIndex;
    switch (styleID) {
        case 0:
            [Settings styleOfDailyViewWillChange:@"cond"];
            break;
        case 1:
            [Settings styleOfDailyViewWillChange:@"chart"];
            break;
        default:
            break;
    }
}

- (void)switchWhetherUsingCoreAnimation{
    if (_animationSwitch.isOn) {
        [Settings useCoreAnimationWillChange:@"1"];
    }else{
        [Settings useCoreAnimationWillChange:@"0"];
    }
}

- (void)switchWhetherWarnOfRain{
    if (_warnOfRainSwitch.isOn) {
        [Settings warnOfRainWillChange:@"1"];
    }else{
        [Settings warnOfRainWillChange:@"0"];
    }
}

- (void)reloadData{
    [self.tableView reloadData];
}
@end
