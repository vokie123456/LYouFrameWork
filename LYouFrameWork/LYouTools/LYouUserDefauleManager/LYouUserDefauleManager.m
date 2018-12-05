//
//  LYouUserDefauleManager.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouUserDefauleManager.h"

@implementation LYouUserDefauleManager

//注册成功token
+(NSString *)getToken{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"Token"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"Token"];
    }else{
        
        return @"";
    }
}
+(void)setToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"Token"];
}

//游客名
+(NSString *)getTempName{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:TEMPNAME]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:TEMPNAME];
    }else{
        return @"";
    }
}
+(void)setTempName:(NSString *)tempname{
    
    [[NSUserDefaults standardUserDefaults] setObject:tempname forKey:TEMPNAME];
}
//用户名
+(NSString *)getUserName{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:USERNAME]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:USERNAME];
    }else{
        return @"";
    }
}
+(void)setUserName:(NSString *)username{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:USERNAME];
}



//是否游客
+(NSString *)getIsTempUser{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"IsTemp"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"IsTemp"];
    }else{
        return @"";
    }
}
+(void)setIsTempUser:(NSString *)isTempUser{
    [[NSUserDefaults standardUserDefaults] setObject:isTempUser forKey:@"IsTemp"];
}

//用户名密码
+(NSString *)getUserPassword{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"UserPassword"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"UserPassword"];
    }else{
        return @"";
    }
}
+(void)setUserPassword:(NSString *)password{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"UserPassword"];
}

//Appid
+(NSString *)getAppkey{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"LY_Appkey"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"LY_Appkey"];
    }else{
        return @"";
    }
}
+(void)setAppkey:(NSString *)appkey{
    [[NSUserDefaults standardUserDefaults] setObject:appkey forKey:@"LY_Appkey"];
}

//banid
+(NSString *)getBanid{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"LY_Banid"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"LY_Banid"];
    }else{
        return @"";
    }
}
+(void)setBanid:(NSString *)banid{
    [[NSUserDefaults standardUserDefaults] setObject:banid forKey:@"LY_Banid"];
}

+(NSString *)getDeviceId{
    UIDevice *device = [UIDevice currentDevice];//创建设备对象
    NSString *deviceUID = [[device identifierForVendor]UUIDString];
    return deviceUID;
}

#pragma mark 客服
+(NSString *)getKF_qq{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"LY_KF_qq"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"LY_KF_qq"];
    }else{
        return @"";
    }
}
+(void)setKF_qq:(NSString *)KF_qq{
    [[NSUserDefaults standardUserDefaults] setObject:KF_qq forKey:@"LY_KF_qq"];
}
+(NSString *)getKF_qqq{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"LY_KF_qqq"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"LY_KF_qqq"];
    }else{
        return @"";
    }
}
+(void)setKF_qqq:(NSString *)KF_qqq{
    [[NSUserDefaults standardUserDefaults] setObject:KF_qqq forKey:@"LY_KF_qqq"];
}
+(NSString *)getKF_phone{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"LY_KF_phone"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"LY_KF_phone"];
    }else{
        return @"";
    }
}
+(void)setKF_phone:(NSString *)KF_phone{
    [[NSUserDefaults standardUserDefaults] setObject:KF_phone forKey:@"LY_KF_phone"];
}
+(NSString *)getKF_sitime{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"LY_KF_sitime"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"LY_KF_sitime"];
    }else{
        return @"";
    }
}
+(void)setKF_sitime:(NSString *)KF_sitime{
    [[NSUserDefaults standardUserDefaults] setObject:KF_sitime forKey:@"LY_KF_sitime"];
}



//
+(NSString *)getLastInPayId{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"LY_LastInPayId"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"LY_LastInPayId"];
    }else{
        return @"";
    }
}
+(void)setLastInPayId:(NSString *)InPayId{
    [[NSUserDefaults standardUserDefaults] setObject:InPayId forKey:@"LY_LastInPayId"];
}
+(NSString *)getLastInPayMoney{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"LY_LastInPayMoeny"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"LY_LastInPayMoeny"];
    }else{
        return @"";
    }
}
+(void)setLastInPayMoney:(NSString *)money{
    [[NSUserDefaults standardUserDefaults] setObject:money forKey:@"LY_LastInPayMoeny"];
}


#pragma mark 初始化状态
+(BOOL)isInitSuccess{
    BOOL is = [[NSUserDefaults standardUserDefaults] boolForKey:@"LY_isInitSuccess"];
    return is;
}
+(void)setInitSuccess:(BOOL)isScuess{
    [[NSUserDefaults standardUserDefaults] setBool:isScuess forKey:@"LY_isInitSuccess"];
}

//是否第一次
+(NSString *)isFirstLongin{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"LY_isFirst"]) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"LY_isFirst"];
    }else{
        return @"0";
    }
}
+(void)setisFirstLongin:(NSString *)isFirst{
    [[NSUserDefaults standardUserDefaults] setObject:isFirst forKey:@"LY_isFirst"];
}

@end
