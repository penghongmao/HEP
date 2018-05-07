//
//  EasyPaySuccessController.h
//  EasyPayDemo
//
//  Created by 毛宏鹏 on 2018/4/24.
//  Copyright © 2018年 sfbm. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FinishBlock)(NSString *finish);

@interface HaoEasyPaySuccessController : UIViewController
@property (nonatomic,copy) FinishBlock finishBlock;

-(void)showFinshBlock:(FinishBlock)block;
@end
