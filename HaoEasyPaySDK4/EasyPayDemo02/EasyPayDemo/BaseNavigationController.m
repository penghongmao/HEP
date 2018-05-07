//
//  BaseNavigationController.m
//  EasyPayDemo
//
//  Created by 毛宏鹏 on 2018/4/16.
//  Copyright © 2018年 sfbm. All rights reserved.
//

#import "BaseNavigationController.h"
#import "Commens.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    //    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationBar setShadowImage:[UIImage imageNamed:@""]];
    //导航栏字体
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:17]}];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : BASECOLOR}];
    [self.navigationBar setTintColor:BASECOLOR];
    //设置导航栏背景颜色
    self.navigationBar.barTintColor = BASENAVICOLOR;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationBar.translucent) {
        self.navigationBar.subviews[0].subviews[1].hidden = YES;
    }else{
        self.navigationBar.subviews[0].subviews[0].hidden = YES;
    }
}

-(UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

-(UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
