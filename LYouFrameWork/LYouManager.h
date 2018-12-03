//
//  LYouManager.h
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYouManager : NSObject
typedef void(^LoginBlock)(int code,NSString *uid,NSString *token);

#pragma mark - 初始化LYouManager
+(instancetype)sharedManager;

#pragma mark - 根据appId初始化SDK内购
/**
 *  @from                  v1.0
 *  @brief                 支付
 *  @param appkey          app标识符
 */
-(void)LY_initWithAppkey:(NSString *)appkey;

#pragma mark - 显示登录页面
-(void)LY_ShowLoginView:(LoginBlock)loginBlock;

@end

