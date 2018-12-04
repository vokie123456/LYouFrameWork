//
//  LYouNetWorkManager.h
//  LYouFrameWork
//
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^RequestSuccessBlock)(NSDictionary * dict); //请求成功后的回调
typedef void(^RequestFailureBlock)(NSString * errorMessage); //请求成功后的回调

NS_ASSUME_NONNULL_BEGIN

@interface LYouNetWorkManager : NSObject

@property(nonatomic,copy)NSString *onoff;
@property(nonatomic,copy)NSString *ccurl;
@property(nonatomic,copy)NSString *string;

+ (instancetype)instance;

#pragma mark -- 初始化
-(void)initWithAppkey:(NSString *)appkey SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure;

#pragma mark -- 获取短信验证码(新后台地址)
-(void)getVerifyMessageWithPhone:(NSString *)num withType:(NSString *)type SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failBlock;

#pragma mark -- 注册游客(新后台地址)
-(void)RegisterTempUserWithResult: (RequestSuccessBlock)success
                     failureBlock: (RequestFailureBlock) failBlock;

#pragma mark -- 游客登录
-(void)TempUserLoginWithResult: (RequestSuccessBlock)success
                  failureBlock: (RequestFailureBlock) failBlock;

#pragma mark -- 注册账号(新后台地址)
-(void)RegisteredAccountWithPhoneNum:(NSString *)num Password:(NSString *)pwd Verification:(NSString *)verification SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure;

#pragma mark -- 账号登录(新后台地址)
-(void)LoginWithAppKey:(NSString *)appkey PhoneNumber:(NSString *)number Password:(NSString *)pwd loginSuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure;

#pragma mark --忘记密码（需要验证码的重新设置密码）(新后台地址)
-(void)GetBackPassWordWithPhoneNum:(NSString *)num Password:(NSString *)pwd Verification:(NSString *)verification SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure;

#pragma mark -- 校验用户是否绑定手机号 (新后台地址)
-(void)checkPhoneNumberWithPhoneToken:(NSString *)token SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure;

#pragma mark -- 绑定手机号
-(void)AddPhoneNumberWithPhoneNum:(NSString *)num Password:(NSString *)pwd Verification:(NSString *)verification SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure;

#pragma mark -- 修改密码
-(void)ChagePasswordWithPhone:(NSString *)num Password:(NSString *)pwd SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure;

#pragma mark -- 退出游戏(新后台接口)
-(void)LY_LoginOutGame:(NSString *)token SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure;


@end

NS_ASSUME_NONNULL_END
