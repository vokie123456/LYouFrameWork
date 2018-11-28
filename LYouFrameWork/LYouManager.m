//
//  LYouManager.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouManager.h"
#import "LYouLoginController.h"

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
}

-(void)LY_ShowLoginView{
    LYouLoginController *loginVC = [[LYouLoginController alloc]init];
    loginVC.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    UIViewController *TTop = [LYouTopViewManager topViewController];
    [TTop.view addSubview:loginVC.view];
}

@end
