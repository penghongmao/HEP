//
//  EasyPayFailedController.h
//  EasyPayDemo
//
//  Created by 毛宏鹏 on 2018/4/24.
//  Copyright © 2018年 sfbm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FinishBlock2)(NSString *finish);

@interface HaoEasyPayFailedController : UIViewController
@property (nonatomic,copy) FinishBlock2 finishBlock2;

-(void)showFinshBlock2:(FinishBlock2)block;
@end
