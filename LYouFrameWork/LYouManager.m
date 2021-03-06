//
//  LYouManager.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouManager.h"
#import "LYouLoginController.h"
#import "LYouAppPayController.h"
#import "LY_UserViewController.h"
#import "LY_OtherPayViewController.h"

@interface LYouManager(){
    NSString *appKeyStr;
    NSString *banidStr;
}

@end

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

-(void)LY_initWithAppkey:(NSString *)appkey withBanid:(NSString *)banid{
    NSLog(@"初始化内购");
    appKeyStr = appkey;
    banidStr = banid;
    [[LYouNetWorkManager instance]initWithAppkey:appkey SuccessBlock:^(NSDictionary *dict) {
            [[LYouAppPayController shared]initInPay];
            /** 保存AppKey */
            [LYouUserDefauleManager setAppkey:appkey];
            /** 保存Banid */
            [LYouUserDefauleManager setBanid:banid];
            /** 是否初始化成功 */
            [LYouUserDefauleManager setInitSuccess:YES];
            /** 是否打开iOS内购 1为开启 2为关闭 */
            [LYouNetWorkManager instance].onoff = [NSString stringWithFormat:@"%@",dict[@"data"][@"ios_pay"]];
            /** 获取三方支付链接 */
            [LYouNetWorkManager instance].ccurl = dict[@"data"][@"pay_url"];

    } FailureBock:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

-(void)LY_ShowLoginView:(LoginBlock)loginBlock{
    //检测SKDK初始化状态
    if (![LYouUserDefauleManager isInitSuccess]) {
        [self performSelectorInBackground:@selector(reInitWithAppkey:) withObject:[LYouUserDefauleManager getAppkey]];
    }
    LYouLoginController *loginVC = [[LYouLoginController alloc]init];
    loginVC.loginBlock = loginBlock;
    loginVC.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    UIViewController *TTop = [LYouTopViewManager topViewController];
    [TTop.view addSubview:loginVC.view];
}

- (void)LY_PayProductId:(NSString *) proId
                 ServerId:(NSString *) server_id
                   Roleid:(NSString *) roleid
                    Money:(NSString *) money
                  OrderID:(NSString *) orderId
                   Custom:(NSString *)custom
                   Result:(ApplePayResultBlock) result{
    if ([LYouUserDefauleManager getToken].length==0) {
        [SVProgressHUD showInfoWithStatus:@"请先登录游戏"];
        return;
    }
    if ([[LYouNetWorkManager instance].onoff isEqualToString:@"2"]) {
        /** 第三方支付 */
        LY_OtherPayViewController *otherPayVC = [LY_OtherPayViewController shared];
        otherPayVC.proId = [NSString stringWithFormat:@"%@",proId];
        otherPayVC.serverId = server_id;
        otherPayVC.roleid = roleid;
        otherPayVC.money = money;
        otherPayVC.orderId = orderId;
        otherPayVC.custom = custom;
        otherPayVC.ly_AppleResultBlock = result;
        UIViewController *TTop = [LYouTopViewManager topViewController];
        otherPayVC.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
        [TTop.view addSubview:otherPayVC.view];
    }else{
        /** 内购 */
        [LYouAppPayController shared].proId = [NSString stringWithFormat:@"%@",proId];
        [LYouAppPayController shared].serverId = server_id;
        [LYouAppPayController shared].roleid = roleid;
        [LYouAppPayController shared].money = money;
        [LYouAppPayController shared].orderId = orderId;
        [LYouAppPayController shared].custom = custom;
        [LYouAppPayController shared].LYAppPayResultBlock = result;
        [[LYouAppPayController shared] buy:proId];
        [LYouUserDefauleManager setLastInPayId:orderId];
        [LYouUserDefauleManager setLastInPayMoney:money];
    }
//    /** 内购 */
//    [LYouAppPayController shared].proId = [NSString stringWithFormat:@"%@",proId];
//    [LYouAppPayController shared].serverId = server_id;
//    [LYouAppPayController shared].roleid = roleid;
//    [LYouAppPayController shared].money = money;
//    [LYouAppPayController shared].orderId = orderId;
//    [LYouAppPayController shared].custom = custom;
//    [LYouAppPayController shared].LYAppPayResultBlock = result;
//    [[LYouAppPayController shared] buy:proId];
//    [LYouUserDefauleManager setLastInPayId:orderId];
//    [LYouUserDefauleManager setLastInPayMoney:money];
}


-(void)LY_Loginout:(LY_QuitBlock) ly_QuitBlock{
    /** 如果是游客 */
    if ([LYouUserDefauleManager getTempName].length>0) {
        [LYouUserDefauleManager setToken:@""];
        [[LY_UserViewController sharedUserVC].view removeFromSuperview];
        [[LYUserCenterManager instance] hideFuBiao];
        [[LYUserCenterManager instance] closedUserCenter];
        [[LYUserCenterManager instance] QuitGame];
        ly_QuitBlock(@"退出成功");
        return;
    }
    [[LYouNetWorkManager instance] LY_LoginOutGame:[LYouUserDefauleManager getToken] SuccessBlock:^(NSDictionary *dict) {
        [LYouUserDefauleManager setToken:@""];
        [[LY_UserViewController sharedUserVC].view removeFromSuperview];
        [[LYUserCenterManager instance] hideFuBiao];
        [[LYUserCenterManager instance] closedUserCenter];
        [[LYUserCenterManager instance] QuitGame];
        ly_QuitBlock(dict[@"message"]);
    } FailureBock:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:@"退出失败"];
    }];
}

#pragma mark - 重新初始化SDK
-(void)reInitWithAppkey:(NSString *)appkey{
    [[LYouAppPayController shared] initInPay];
    
    [[LYouNetWorkManager instance] initWithAppkey:appkey SuccessBlock:^(NSDictionary *dict){
        [[LYouAppPayController shared]initInPay];
        /** 保存AppKey */
        [LYouUserDefauleManager setAppkey:appkey];
        /** 保存Banid */
        [LYouUserDefauleManager setBanid:self->banidStr];
        /** 是否初始化成功 */
        [LYouUserDefauleManager setInitSuccess:YES];
        /** 是否打开iOS内购 1为开启 2为关闭 */
        [LYouNetWorkManager instance].onoff = dict[@"data"][@"ios_pay"];
        /** 获取三方支付链接 */
        [LYouNetWorkManager instance].ccurl = @"https://sdkpaylist.lygames.cc/index.php?m=admin&c=zfh5&a=zf";
        //[LYouNetWorkManager instance].ccurl = dict[@"data"][@"pay_url"];
        
    } FailureBock:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
        return ;
    }];
}


@end
