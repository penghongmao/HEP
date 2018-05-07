//
//  Commens.h
//  EasyPayDemo
//
//  Created by 毛宏鹏 on 2018/4/16.
//  Copyright © 2018年 sfbm. All rights reserved.
//

#ifndef Commens_h
#define Commens_h

//判断是否为iOS10
//#define IS_IOS_10 ([[UIDevice currentDevice] systemVersion].floatValue >= 10.0? YES : NO)
//#define IS_IOS_11 ([[UIDevice currentDevice] systemVersion].floatValue >= 11.0? YES : NO)

#ifdef DEBUG

#define MYNSLog(FORMAT, ...)  fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define MYNSLog(...)
#endif

//颜色
#define RGBA(r,g,b,a)      [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#define BASECOLOR  RGBA(142,195,31,1)
#define BASEVIEWBORDERCOLOR RGBA(30,45,57,1)
#define BASENAVICOLOR  RGBA(23,33,43,1)

#define BASENAVIGREENCOLOR  RGBA(160,215,74,1)
#define BASEYELLOWCOLOR  RGBA(226,158,80,1)


//屏幕的SIZE
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//导航栏高度
#define kNavigationBarHeight 64
#define kTabbarHeight 49
#define kStatusBarHeight 20


//微信支付appid
#define WEIXINPAY_appId  @"wxa833091477c207c2"//十分便民超市 app
//#define WEIXINPAY_appId  @"wx64567239d04412e1"//随便充 app



#endif /* Commens_h */
