//
//  AppDelegate.m
//  EasyPayDemo
//
//  Created by 毛宏鹏 on 2018/4/16.
//  Copyright © 2018年 sfbm. All rights reserved.
//

#import "AppDelegate.h"
//微信支付注册
#import "WXApi.h"
#import "WXApiManager.h"
#import <HaoEasyPaySDK/HaoEasyPaySDK.h>

//#import "WXApiManager.h"

#import <AlipaySDK/AlipaySDK.h>
#import "Commens.h"
#import "MostCommonIndicatorShow.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //导航栏 文字颜色 白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    //向微信注册
    [WXApi registerApp:WEIXINPAY_appId enableMTA:NO];
    self.paySuccess = @"";

    //获取易支付appId
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString * EasyPayId = [infoDic valueForKey:@"EasyPayId"];
    NSLog(@"EasyPayId==%@",EasyPayId);
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//微信支付 商户ios端 回调代码实现
// 注意:iOS4.2 ~ 9.0使用的 API接口
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
//    MYNSLog(@"url0==%@--sourceApplication==%@",url,sourceApplication)

    //微信支付
//    if ([urlStr containsString:@"ret=0"]) {
//        [MostCommonIndicatorShow showTheMostCommonAlertmessage:@"支付成功"];
//        self.paySuccess = @"1";
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"SFBMpaySecurityControllerPop" object:nil];
//        return YES;
//    }else if ([urlStr containsString:@"ret=-2"]){
//        [MostCommonIndicatorShow showTheMostCommonAlertmessage:@"商户取消支付"];
//    }
    // 支付跳转支付宝钱包进行支付，处理支付结果

    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            MYNSLog(@"result0 =2= %@",resultDic);
            NSString *resultStatus = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
            if ([resultStatus isEqualToString:@"9000"]) {
                [MostCommonIndicatorShow showTheMostCommonAlertmessage:@"支付成功"];
                self.paySuccess = @"1";

                [[NSNotificationCenter defaultCenter] postNotificationName:@"SFBMpaySecurityControllerPop" object:nil];

            }else if ([resultStatus isEqualToString:@"4000"]){//支付宝签名错误导致
                [MostCommonIndicatorShow showTheMostCommonAlertmessage:@"支付失败"];
            }
            else{
                [MostCommonIndicatorShow showTheMostCommonAlertmessage:@"支付失败"];
            }
        }];
        
        return YES;
    }
    
    //微信支付回调
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

// 注意:iOS 9.0以后使用这个API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    MYNSLog(@"app端url0==%@",url)
//    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
//    if ([urlStr containsString:@"ret=0"]) {
//        [MostCommonIndicatorShow showTheMostCommonAlertmessage:@"支付成功"];
//        self.paySuccess = @"1";
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"SFBMpaySecurityControllerPop" object:nil];
//        return YES;
//    }else if ([urlStr containsString:@"ret=-2"]){
//        [MostCommonIndicatorShow showTheMostCommonAlertmessage:@"商户取消支付"];
//    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            MYNSLog(@"result0 =2= %@",resultDic);
            NSString *resultStatus = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
            if ([resultStatus isEqualToString:@"9000"]) {
                [MostCommonIndicatorShow showTheMostCommonAlertmessage:@"支付成功"];
                self.paySuccess = @"1";
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"SFBMpaySecurityControllerPop" object:nil];
            }else if ([resultStatus isEqualToString:@"4000"]){//支付宝签名错误导致
                [MostCommonIndicatorShow showTheMostCommonAlertmessage:@"支付失败"];
            }
            else{
                [MostCommonIndicatorShow showTheMostCommonAlertmessage:@"支付失败"];
            }
        }];
        
        return YES;
    }
    
       //微信支付回调
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}


@end
