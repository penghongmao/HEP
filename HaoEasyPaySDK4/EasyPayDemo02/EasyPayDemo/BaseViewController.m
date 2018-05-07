//
//  BaseViewController.m
//  EasyPayDemo
//
//  Created by 毛宏鹏 on 2018/4/16.
//  Copyright © 2018年 sfbm. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}

//点击空白处键盘消失
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
+ (void)showEassyPayAlertMessage:(NSString *)message
{
    [self showEassyPayAlertMessage:message];
}
- (void)showEassyPayAlertMessage:(NSString *)message
{
    CGFloat wide = [self caculateTextSize:message];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wide, 45)];
    label.layer.cornerRadius = 22;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor grayColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:17];
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    label.center = window.center;
    label.alpha = 0;
    [window addSubview:label];
    window.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 1;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 delay:1 usingSpringWithDamping:0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
            window.userInteractionEnabled = YES;
            
        }];
    }];
    
}
- (CGFloat )caculateTextSize:(NSString *)message
{
    CGSize textSize = [message boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 45)
                                            options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                            context:nil].size;
    return textSize.width + 40;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    ///这里设置白色
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
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
