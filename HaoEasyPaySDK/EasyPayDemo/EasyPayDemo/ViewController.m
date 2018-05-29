//
//  ViewController.m
//  EasyPayDemo
//
//  Created by 毛宏鹏 on 2018/4/16.
//  Copyright © 2018年 sfbm. All rights reserved.
//

#import "ViewController.h"
#import "SFBMDeveloperController.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";

    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)openEasyPayVC:(id)sender {
    SFBMDeveloperController *payVC = [[SFBMDeveloperController alloc] init];
    
    [self.navigationController pushViewController:payVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
