//
//  HaoEasyPayChannelController.h
//  Battery
//  Created by 毛宏鹏 on 2018/4/10.
//  Copyright © 2018年 SFBM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HaoEasyPayChannelController : UIViewController

@property (strong, nonatomic)  NSArray *channels;//在平台开通的支付渠道，按照顺序填写“weixin,alipay,yinlian” 数组中的顺序 决定了界面支付方式的上下排版顺序  如果商户没有设置支付方式，默认支持 微信支付、支付宝支付 两种支付方式
@property (strong, nonatomic)  NSString *body;//支付的标题内容例如“手机充值”
@property (strong, nonatomic)  NSString *mchId;//商户ID
@property (strong, nonatomic)  NSString *appId;//appID
@property (strong, nonatomic)  NSString *mchOrderNo;//商户订单号(后台唯一不重复的订单标志)
@property (strong, nonatomic)  NSString *amount;//金额（单位：分）特别提醒：金额精确到 分（一分钱），所以必须为整数，不允许出现小数，例如（如果是1元那么合法参数 100 ，不合法参数是100.0等出现小数点的数据）
@property (strong, nonatomic)  NSString *appScheme;//应用注册scheme,在Info.plist定义URL types 保证每个app的URL types唯一就可以了，微信的appId 肯定是唯一的，所以此处可以使用
@end
