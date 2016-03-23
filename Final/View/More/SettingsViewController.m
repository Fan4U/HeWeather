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

@interface SettingsViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor  = [UIColor grayColor];
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
    if (section == 0 || section == 2) {
        return 3;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    // Configure the cell...
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组--第%ld行",(long)indexPath.section,(long)indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"当前城市";
        NSString *currentCityInLocal = [Settings cityName];
        cell.detailTextLabel.text = currentCityInLocal;
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"本地化存储的四种方法";
    }
    
    
    return cell;
}



#pragma mark - 点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        SelectLocController *select = [[SelectLocController alloc] init];
        [self.navigationController pushViewController:select animated:YES];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
    }
    
}


@end
