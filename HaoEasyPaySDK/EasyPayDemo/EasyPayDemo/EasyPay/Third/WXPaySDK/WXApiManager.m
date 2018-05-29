//
//  WXApiManager.m
//  Battery
//
//  Created by 毛宏鹏 on 17/4/26.
//  Copyright © 2017年 SFBM. All rights reserved.
//

#import "WXApiManager.h"
#import <HaoEasyPaySDK/HaoEasyPaySDK.h>
#import "MostCommonIndicatorShow.h"
//#import "HaoEasyPaySuccessController.h"
//#import "HaoEasyPayFailedController.h"
@implementation WXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvMessageResponse:)]) {
            SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
            [_delegate managerDidRecvMessageResponse:messageResp];
        }
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)]) {
            SendAuthResp *authResp = (SendAuthResp *)resp;
            [_delegate managerDidRecvAuthResponse:authResp];
        }
    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAddCardResponse:)]) {
            AddCardToWXCardPackageResp *addCardResp = (AddCardToWXCardPackageResp *)resp;
            [_delegate managerDidRecvAddCardResponse:addCardResp];
        }
    }else if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
//        NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
        NSString *strMsg = [NSString stringWithFormat:@""];
        NSLog(@"支付结果－errCode = %d，errStr = %@, type = %d",resp.errCode,resp.errStr,resp.type);

        switch (resp.errCode) {
            case WXSuccess:
            {
                
                strMsg = @"支付成功！";
//                NSLog(@"支付成功－PaySuccess，retcode ");
                UIViewController *vc = [self topViewController];
                HaoEasyPaySuccessController *succedVC = [[HaoEasyPaySuccessController alloc] init];
                [vc.navigationController pushViewController:succedVC animated:YES];
            }
                break;
            case WXErrCodeUserCancel:
            {
                strMsg = @"用户取消支付！";
//                UIViewController *vc = [self topViewController];
//                [vc.navigationController popViewControllerAnimated:YES];
                UIViewController *vc = [self topViewController];
                HaoEasyPayFailedController *succedVC = [[HaoEasyPayFailedController alloc] init];
                [vc.navigationController pushViewController:succedVC animated:YES];
                
            }
                
                break;
            default:{
                UIViewController *vc = [self topViewController];
                HaoEasyPayFailedController *succedVC = [[HaoEasyPayFailedController alloc] init];
                [vc.navigationController pushViewController:succedVC animated:YES];
                
            }
                strMsg = [NSString stringWithFormat:@"支付失败！错误码 = %d", resp.errCode];
//                NSLog(@"错误，retcode = , retstr =");
                break;
        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
        [MostCommonIndicatorShow showTheMostCommonAlertmessage:strMsg];
    }
    
}

- (void)onReq:(BaseReq *)req {
    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvGetMessageReq:)]) {
            GetMessageFromWXReq *getMessageReq = (GetMessageFromWXReq *)req;
            [_delegate managerDidRecvGetMessageReq:getMessageReq];
        }
    } else if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageReq:)]) {
            ShowMessageFromWXReq *showMessageReq = (ShowMessageFromWXReq *)req;
            [_delegate managerDidRecvShowMessageReq:showMessageReq];
        }
    } else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvLaunchFromWXReq:)]) {
            LaunchFromWXReq *launchReq = (LaunchFromWXReq *)req;
            [_delegate managerDidRecvLaunchFromWXReq:launchReq];
        }
    }
}

#pragma mark--获取当前视图所在控制器2
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
