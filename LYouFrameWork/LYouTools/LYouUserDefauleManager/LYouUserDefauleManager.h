//
//  LYouUserDefauleManager.h
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYouUserDefauleManager : NSObject

#pragma mark  本地数据

//注册成功Token
+(NSString *)getToken;
+(void)setToken:(NSString *)token;

//游客名
+(NSString *)getTempName;
+(void)setTempName:(NSString *)tempname;

//用户名
+(NSString *)getUserName;
+(void)setUserName:(NSString *)username;
//是否游客
+(NSString *)getIsTempUser;
+(void)setIsTempUser:(NSString *)isTempUser;
//用户名密码
+(NSString *)getUserPassword;
+(void)setUserPassword:(NSString *)password;
//Appid
+(NSString *)getAppkey;
+(void)setAppkey:(NSString *)appkey;
//banid
+(NSString *)getBanid;
+(void)setBanid:(NSString *)appkey;

//客服信息

+(NSString *)getKF_qq;
+(void)setKF_qq:(NSString *)KF_qq;
+(NSString *)getKF_qqq;
+(void)setKF_qqq:(NSString *)KF_qqq;
+(NSString *)getKF_phone;
+(void)setKF_phone:(NSString *)KF_phone;
+(NSString *)getKF_sitime;
+(void)setKF_sitime:(NSString *)KF_sitime;


//
+(NSString *)getLastInPayId;
+(void)setLastInPayId:(NSString *)InPayId;
+(NSString *)getLastInPayMoney;
+(void)setLastInPayMoney:(NSString *)money;
#pragma mark 初始化状态
+(BOOL)isInitSuccess;
+(void)setInitSuccess:(BOOL)isScuess;



//是否第一次
+(NSString *)isFirstLongin;
+(void)setisFirstLongin:(NSString *)isFirst;

@end

NS_ASSUME_NONNULL_END
