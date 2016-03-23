//
//  ZFNavigationController.m
//  Final
//
//  Created by pro on 16/3/23.
//  Copyright © 2016年 张帆. All rights reserved.
//

#import "ZFNavigationController.h"

@interface ZFNavigationController ()

@end

@implementation ZFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.9f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [super pushViewController:viewController animated:YES];

}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.9f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromLeft;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    return [super popViewControllerAnimated:YES];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.9f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromLeft;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    self.navigationBarHidden = YES;
    
    return [super popToRootViewControllerAnimated:YES];
}

@end
