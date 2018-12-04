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

#pragma mark -- 获取短信验证码
-(void)getVerifyMessageWithPhone:(NSString *)num withType:(NSString *)type SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failBlock{
    NSString *urlString =  [NSString stringWithFormat:@"%@/getcaptcha?type=%@&username=%@",LY_URLPAYPATH,type,num];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failBlock];
}

#pragma mark -- 账号登录
-(void)LoginWithAppKey:(NSString *)appkey PhoneNumber:(NSString *)number Password:(NSString *)pwd loginSuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    NSString *urlString = @"";
    NSString *token = [LYouUserDefauleManager getToken];
    if (token.length==0||token==nil) {
        urlString = [NSString stringWithFormat:@"%@/user/apilogin?username=%@&pass=%@",LY_URLPATH,number,pwd];
    }else{
        urlString = [NSString stringWithFormat:@"%@/user/apilogin?token=%@",LY_URLPATH,[LYouUserDefauleManager getToken]];
    }
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
    
}
#pragma mark -- 游客登录
-(void)TempUserLoginWithResult: (RequestSuccessBlock)success
                  failureBlock: (RequestFailureBlock) failBlock{
    NSString *name = [LYouUserDefauleManager getTempName];
    NSString *appid = [LYouUserDefauleManager getAppkey];
    NSString *urlString = [NSString stringWithFormat:@"%@/user/apilogin?m=index&c=user&a=dooLogin&name=%@&appid=%@",LY_URLPATH,name,appid];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failBlock];
    
    
}

#pragma mark -- 注册游客
-(void)RegisterTempUserWithResult: (RequestSuccessBlock)success
                     failureBlock: (RequestFailureBlock) failBlock{
    
    NSString *urlString = [NSString stringWithFormat:@"%@/user/apiregister?tourist=1&deviceid=%@",LY_URLPATH,[LYouUserDefauleManager getAppkey]];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failBlock];
    
}

#pragma mark -- 注册账号
-(void)RegisteredAccountWithPhoneNum:(NSString *)num Password:(NSString *)pwd Verification:(NSString *)verification SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    
    NSString *urlString =  [NSString stringWithFormat:@"%@/user/apiregister?username=%@&pass=%@&deviceid=%@&captcha=%@&tourist=2",LY_URLPATH,num,pwd,[LYouUserDefauleManager getAppkey],verification];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
}

#pragma mark --忘记密码（需要验证码的重新设置密码）
-(void)GetBackPassWordWithPhoneNum:(NSString *)num Password:(NSString *)pwd Verification:(NSString *)verification SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    NSString *urlString =  [NSString stringWithFormat:@"%@/user/apiforgetpassword?telphone=%@&newpass=%@&captcha=%@",LY_URLPATH,num,pwd,verification];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
}

#pragma mark -- 校验用户是否绑定手机号
-(void)checkPhoneNumberWithPhoneToken:(NSString *)token SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    NSString *urlString =  [NSString stringWithFormat:@"%@/user/apicheckbindphone?token=%@",LY_URLPATH,token];
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
}

#pragma mark -- 绑定手机号
-(void)AddPhoneNumberWithPhoneNum:(NSString *)num Password:(NSString *)pwd Verification:(NSString *)verification SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    if ([LYouUserDefauleManager getTempName].length <= 1) {
        failure(@"您还没有游客账号");
        return;
    }
    NSString *urlString =  [NSString stringWithFormat:@"%@/user/apibindphone?name=%@&telphone=%@&pass=%@&captcha=%@",LY_URLPATH,[LYouUserDefauleManager getTempName],num,pwd,verification];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
}

#pragma mark -- 修改密码
-(void)ChagePasswordWithPhone:(NSString *)num Password:(NSString *)pwd SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    NSString *urlString = [NSString stringWithFormat:@"%@?m=index&c=user&a=findPassword&phone=%@&password=%@",URLPATH,num,pwd];
    
    [self baseRequrestWithURL:urlString WithSuccess:success WithFailure:failure];
}

#pragma mark -- 退出游戏
-(void)LY_LoginOutGame:(NSString *)token SuccessBlock:(RequestSuccessBlock)success FailureBock:(RequestFailureBlock)failure{
    NSString *urlString = [NSString stringWithFormat:@"%@/user/apilogout?token=%@",LY_URLPATH,token];
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
            
            if ([dictionary[@"code"] isEqualToString:@"0"]) {
                success(dictionary);
            }else{
                failure(dictionary[@"message"]);
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
