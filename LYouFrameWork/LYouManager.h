//
//  LYouManager.h
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYouManager : NSObject
typedef void(^LoginBlock)(int style,NSString *token);
typedef void(^ApplePayResultBlock)(int code,NSString *reason);
typedef void(^LY_QuitBlock)(NSString *message);

#pragma mark - 初始化LYouManager
+(instancetype)sharedManager;

#pragma mark - 根据appId初始化SDK内购
/**
 *  @from                  v1.0
 *  @brief                 支付
 *  @param appkey          app游戏key
 *  @param banid          app游戏渠道id
 */
-(void)LY_initWithAppkey:(NSString *)appkey withBanid:(NSString *)banid;


#pragma mark - 显示登录页面
-(void)LY_ShowLoginView:(LoginBlock)loginBlock;

/**
 *  @from                  v1.0
 *  @brief                 支付模块
 *  @param name            产品名称
 *  @param money           产品金额
 *  @param productId       商品ID
 *  @param orderId         订单号
 *  0 支付失败
 *  1 支付成功
 *  2 用户取消
 *  3 结果不明
 */
#pragma mark - 根据金额 和 产品名称支付
- (void)LY_PayProductId:(NSString *) proId
                    ServerId:(NSString *) server_id
                    Roleid:(NSString *) roleid
                    Money:(NSString *) money
                  OrderID:(NSString *) orderId
                   Custom:(NSString *)custom
                   Result:(ApplePayResultBlock) result;


#pragma mark - 退出账号
-(void)LY_Loginout:(LY_QuitBlock) ly_QuitBlock;

@end

