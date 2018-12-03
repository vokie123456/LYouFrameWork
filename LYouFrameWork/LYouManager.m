//
//  LYouManager.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouManager.h"
#import "LYouLoginController.h"
#import "LYouOtherPayController.h"
#import "LYouAppPayController.h"

@implementation LYouManager

#pragma mark - 初始化LYouManager
+(instancetype)sharedManager{
    static LYouManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(void)LY_initWithAppkey:(NSString *)appkey{
    NSLog(@"初始化内购");
    [[LYouNetWorkManager instance]initWithAppkey:appkey SuccessBlock:^(NSDictionary *dict) {
        [LYouNetWorkManager instance].onoff = @"1";
    } FailureBock:^(NSString *errorMessage) {
    }];
}

-(void)LY_ShowLoginView:(LoginBlock)loginBlock{
    LYouLoginController *loginVC = [[LYouLoginController alloc]init];
    loginVC.loginBlock = loginBlock;
    loginVC.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    UIViewController *TTop = [LYouTopViewManager topViewController];
    [TTop.view addSubview:loginVC.view];
}

- (void)LY_PayProductName:(NSString *) name
                    Money:(NSString *) money
                ProductID:(NSString *) productId
                  OrderID:(NSString *) orderId
                   Result:(ApplePayResultBlock) result{
    if ([LYouNetWorkManager instance].onoff != nil && [[LYouNetWorkManager instance].onoff isEqualToString:@"1"]) {
        /** 第三方支付 */
        LYouOtherPayController *otherPayVC = [[LYouOtherPayController alloc]init];
        otherPayVC.name = [NSString stringWithFormat:@"%@",name];
        otherPayVC.money = money;
        otherPayVC.orderId = orderId;
        otherPayVC.TT_AppleResultBlock = result;
        UIViewController *TTop = [LYouTopViewManager topViewController];
        otherPayVC.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
        [TTop.view addSubview:otherPayVC.view];
        
    }else{
        /** 内购 */
        [LYouAppPayController shared].money = money;
        [LYouAppPayController shared].LYAppPayResultBlock = result;
        [LYouAppPayController shared].orderId = orderId;
        [[LYouAppPayController shared] buy:productId];
        [LYouUserDefauleManager setLastInPayId:orderId];
        [LYouUserDefauleManager setLastInPayMoney:money];
    }
}

#pragma mark - 加在处理退出当前登录的地方
-(void)LY_handleGameQuitWith:(LY_QuitBlock) LY_QuitBlock{
    
}

-(void)LY_Loginout{
    
}

@end
