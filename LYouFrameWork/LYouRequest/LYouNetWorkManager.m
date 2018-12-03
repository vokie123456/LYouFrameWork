//
//  LYouNetWorkManager.m
//  LYouFrameWork
//
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouNetWorkManager.h"
#import <AdSupport/AdSupport.h>

@implementation LYouNetWorkManager

+ (instancetype)instance {
    static LYouNetWorkManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

#pragma mark -- 初始化
-(void)initWithAppkey:(NSString *)appkey SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    //idfa
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"app_Version = %@, app_build = %@, idfa = %@",app_Version,app_build,idfa);
    [LYouUserDefauleManager setAppkey:appkey];
    
    //3.0不一样的接口版本的接口
    NSString *urlString = [NSString stringWithFormat:@"%@?m=index&c=sales&a=iosinitialize&appid=%@&app_Version=%@",URLPATH,appkey,app_Version];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
    
    
}
#pragma mark -- 账号登录
-(void)LoginWithAppKey:(NSString *)appkey PhoneNumber:(NSString *)number Password:(NSString *)pwd loginSuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    
    NSString *urlString = [NSString stringWithFormat:@"%@?m=index&c=user&a=doLogin&appid=%@&phone=%@&password=%@",URLPATH,appkey,number,pwd];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
    
}
#pragma mark -- 游客登录
-(void)TempUserLoginWithResult: (RequestSuccessBlock)success
                  failureBlock: (RequestFailureBlock) failBlock{
    NSString *name = [LYouUserDefauleManager getTempName];
    NSString *appid = [LYouUserDefauleManager getAppkey];
    NSString *urlString = [NSString stringWithFormat:@"%@?m=index&c=user&a=dooLogin&name=%@&appid=%@",URLPATH,name,appid];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failBlock];
    
    
}

#pragma mark -- 注册游客
-(void)RegisterTempUserWithResult: (RequestSuccessBlock)success
                     failureBlock: (RequestFailureBlock) failBlock{
    
    NSString *urlString = [NSString stringWithFormat:@"%@?m=index&c=user&a=dooRegister&appid=%@",URLPATH,[LYouUserDefauleManager getAppkey]];
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failBlock];
    
}
#pragma mark -- 获取短信验证码
-(void)getVerifyMessageWithPhone:(NSString *)num SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failBlock{
    NSString *urlString =  [NSString stringWithFormat:@"%@?m=index&c=user&a=zhuce1&mobile=%@",URLPATH,num];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failBlock];
}
#pragma mark -- 注册账号
-(void)RegisteredAccountWithPhoneNum:(NSString *)num Password:(NSString *)pwd Verification:(NSString *)verification SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    
    NSString *urlString =  [NSString stringWithFormat:@"%@?m=index&c=user&a=doRegister&phone=%@&password=%@&appid=%@&yzm=%@",URLPATH,num,pwd,[LYouUserDefauleManager getAppkey],verification];
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
}

#pragma mark --忘记密码（需要验证码的重新设置密码）
-(void)GetBackPassWordWithPhoneNum:(NSString *)num Password:(NSString *)pwd Verification:(NSString *)verification SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    NSString *urlString =  [NSString stringWithFormat:@"%@?m=index&c=product&a=hui1&phone=%@&password=%@&yzm=%@",URLPATH,num,pwd,verification];
    
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
}

#pragma mark -- 绑定手机号
-(void)AddPhoneNumberWithPhoneNum:(NSString *)num Password:(NSString *)pwd Verification:(NSString *)verification SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    if ([LYouUserDefauleManager getTempName].length <= 1) {
        failure(@"您还没有游客账号");
        return;
    }
    NSString *urlString =  [NSString stringWithFormat:@"%@?m=index&c=user&a=boundUser&name=%@&phone=%@&password=%@&appid=%@&yzm=%@",URLPATH,[LYouUserDefauleManager getTempName],num,pwd,[LYouUserDefauleManager getAppkey],verification];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
}

#pragma mark -- 修改密码
-(void)ChagePasswordWithPhone:(NSString *)num Password:(NSString *)pwd SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    NSString *urlString = [NSString stringWithFormat:@"%@?m=index&c=user&a=findPassword&phone=%@&password=%@",URLPATH,num,pwd];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
}
-(void)baseRequrestWithURL:(NSString *)url WithSuccess:(RequestSuccessBlock)success WithFailure:(RequestFailureBlock)failure {
    NSString *encodString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *reurl = [NSURL URLWithString:encodString];
    NSURLRequest *request = [NSURLRequest requestWithURL:reurl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    if (request) {
        NSData *userdata = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (userdata) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:userdata options:NSJSONReadingMutableContainers error:nil];
            if ([dictionary[@"isSuccess"] isEqualToString:@"1"]) {
                success(dictionary);
            }else{
                failure(dictionary[@"msg"]);
            }
        }else{
            failure(@"请检查网络");
        }
        
    }else if (error){
        NSLog(@"请求失败  %@",error);
        failure(@"请求失败");
    }
}

@end
