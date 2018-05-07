//
//  MostCommonIndicatorShow.m
//  EasyPayDemo
//
//  Created by 毛宏鹏 on 2018/4/20.
//  Copyright © 2018年 sfbm. All rights reserved.
//

#import "MostCommonIndicatorShow.h"
#import "MBProgressHUD.h"
@implementation MostCommonIndicatorShow
+(void)showTheMostCommonAlertmessage:(NSString *)message
{
    [self showMessageText:message withLoadMode:MBProgressHUDModeText duration:1.5];
    
    
    
}

+(void)showMessageText:(NSString *)text withLoadMode:(MBProgressHUDMode)mode duration:(NSTimeInterval)second
{
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    //[[[UIApplication sharedApplication] delegate] window]
    if (mode) {
        hud.mode = mode;
    }
    if (text) {
        hud.label.text = text;
    }
    [hud hideAnimated:YES afterDelay:second];
}

@end
