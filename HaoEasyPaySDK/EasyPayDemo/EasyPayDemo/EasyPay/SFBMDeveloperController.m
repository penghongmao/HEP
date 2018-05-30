//
//  SFBMDeveloperController.m
//  Battery
//
//  Created by 毛宏鹏 on 2018/4/12.
//  Copyright © 2018年 SFBM. All rights reserved.
//

#import "SFBMDeveloperController.h"
//#import "HaoEasyPayChannelController.h"
//#import "EasyPayFailedController.h"
//#import "EasyPaySuccessController.h"
#import <HaoEasyPaySDK/HaoEasyPaySDK.h>

#import "Commens.h"
@interface SFBMDeveloperController ()
@property (weak, nonatomic) IBOutlet UITextField *body;//支付的标题内容例如“手机充值”
@property (weak, nonatomic) IBOutlet UITextField *mchId;//商户ID
@property (weak, nonatomic) IBOutlet UITextField *appId;//appID
@property (weak, nonatomic) IBOutlet UITextField *mchOrderNo;//商户订单号
@property (weak, nonatomic) IBOutlet UITextField *amount;//金额（单位：分）特别提醒：金额精确到 分（一分钱），所以必须为整数，不允许出现小数，例如（如果是1元那么合法参数 100 ，不合法参数是100.0等出现小数点的数据）
@property (weak, nonatomic) IBOutlet UITextField *appScheme;//应用注册scheme,在Info.plist定义URL types 保证每个app的URL types唯一就可以了，微信的appId 肯定是唯一的，所以此处可以使用


@end

@implementation SFBMDeveloperController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"易支付demo";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EASYPAYSUCCESSNOTIFICATION" object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *orderNumber = [self getRandomStringWithNum:20];
    self.mchOrderNo.text = orderNumber;
  //添加通知接收
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFinishResult:) name:@"EASYPAYSUCCESSNOTIFICATION" object:nil];
    MYNSLog(@"测试有咩有输出");
}
- (void)payFinishResult:(NSNotification *)noti
{
    NSDictionary *result = (NSDictionary *)noti.object;
    NSLog(@"result=%@",result);
    if ([[result objectForKey:@"retCode"] isEqualToString:@"0"]) {
        NSLog(@"支付成功啦，可以在此添加代码处理逻辑");
    }else if ([[result objectForKey:@"retCode"] isEqualToString:@"1"]){
        NSLog(@"支付失败啦，可以在此添加代码处理逻辑");
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EASYPAYSUCCESSNOTIFICATION" object:nil];
}
- (NSString *)getRandomStringWithNum:(NSInteger)num
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}
//跳转SDK支付
- (IBAction)nextBtnClick:(id)sender {
    if ([self.amount.text intValue]<1) {
        [self showEassyPayAlertMessage:@"输入金额单位为分，必须大于等于1"];
        return;
    }
    
if(self.body.text.length>0&&self.mchId.text.length>0&&self.appId.text.length>0&&self.mchOrderNo.text.length>0&&self.amount.text.length>0&&self.appScheme.text.length>0)
    {
        HaoEasyPayChannelController *payVC = [[HaoEasyPayChannelController alloc] init];
        payVC.channels = @[@"weixin",@"alipay"];
        payVC.body = self.body.text;
        payVC.mchId = self.mchId.text;
        payVC.appId = self.appId.text;
        payVC.mchOrderNo = self.mchOrderNo.text;
        payVC.amount = self.amount.text;
        payVC.appScheme = self.appScheme.text;

        [self.navigationController pushViewController:payVC animated:YES];
        
    }else{
        [self showEassyPayAlertMessage:@"参数不可以为空"];
    }


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
