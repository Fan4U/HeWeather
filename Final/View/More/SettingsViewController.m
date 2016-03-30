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
@interface SettingsViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, weak)UISwitch *styleSwitch;
@property (nonatomic, weak)UISwitch *animationSwitch;
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [super viewWillAppear:YES];

    
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
        [cell removeFromSuperview];
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
        cell.textLabel.text = @"显示图表";
//        cell.imageView.frame = CGRectMake(0, 5, 31, 31);
//        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        cell.imageView.image = [UIImage imageNamed:@"InMonth"];
//        cell.imageView.tintColor = [UIColor grayColor];
        UISwitch *switcher = [[UISwitch alloc]init];//WithFrame:CGRectMake(ScreenW - 80 , 2, 60, 40)
        if ([[Settings styleOfDailyView] isEqualToString:@"chart"]) {
            [switcher setOn:YES animated:YES];
        }else{
            [switcher setOn:NO animated:YES];
        }
        [switcher addTarget:self action:@selector(switchWhichStyleOfDailyView) forControlEvents:UIControlEventValueChanged];
        _styleSwitch = switcher;
        [cell.contentView addSubview:_styleSwitch];
        [_styleSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 40));
            make.right.equalTo(cell.contentView).offset(25);
            make.centerY.equalTo(cell.contentView).offset(5);
        }];
    }
    
    //动画
    if (indexPath.section == 1 && indexPath.row == 1) {
        cell.textLabel.text = @"动画切换";
        UISwitch *switcher = [[UISwitch alloc]init];//WithFrame:CGRectMake(ScreenW - 80 , 2, 60, 40)
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
        if ([Settings warnOfRain]) {
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
    
    return cell;
}




#pragma mark - 点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        SelectLocController *select = [[SelectLocController alloc] init];
        [self.navigationController pushViewController:select animated:YES];
        
    }
    
}

- (void)switchWhichStyleOfDailyView{
    if (_styleSwitch.isOn) {
        [Settings styleOfDailyViewWillChange:@"chart"];
    }else{
        [Settings styleOfDailyViewWillChange:@"cond"];
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
    if (_animationSwitch.isOn) {
        [Settings warnOfRainWillChange:@"1"];
    }else{
        [Settings warnOfRainWillChange:@"0"];
    }
}

@end
