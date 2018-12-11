//
//  LYouLoginController.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouLoginController.h"
#import "LYouAcountLoginController.h"
#import "LYLoginView.h"
#import "SDAutoLayout.h"
#import "LYUserCenterManager.h"

@interface LYouLoginController ()

@property(nonatomic,strong)LYLoginView *loginView;

@end

@implementation LYouLoginController

+(instancetype)sharedVC{
    static LYouLoginController *instence = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instence = [[LYouLoginController alloc] init];
    });
    return instence;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.loginView];
    /** 创建登录窗口 */
 self.loginView.sd_layout.centerYEqualToView(self.view).centerXEqualToView(self.view).widthIs(Main_Rotate_Width-80).heightIs(260);
     self.loginView.accountLoginClick = ^(UIView *superView,AccountLoginStyle style){
         if (style==VisitorLogin) {
             NSString *tempName =  [LYouUserDefauleManager getTempName];
             if ([tempName length] > 1) {
                 //游客登录
                 [[LYouNetWorkManager instance] TempUserLoginWithResult:^(NSDictionary *dict) {
                     NSLog(@"======%@",[LYouUserDefauleManager getTempName]);
                     [superView removeFromSuperview];
                     [[LYUserCenterManager instance] showFuBiao];
                     [LYouUserDefauleManager setTempName:dict[@"data"][@"username"]];
                     [LYouUserDefauleManager setToken:dict[@"data"][@"token"]];
                     [LYouUserDefauleManager setIsTempUser:@"1"];
                     [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                     self.loginBlock(2,dict[@"data"][@"token"]);
                 } failureBlock:^(NSString *errorMessage) {
                     [SVProgressHUD showErrorWithStatus:errorMessage];
                 }];
             }else{
                 //注册游客
                 [[LYouNetWorkManager instance] RegisterTempUserWithResult:^(NSDictionary *dict) {
                     NSLog(@"=====%@",dict[@"data"][@"token"]);
                     [LYouUserDefauleManager setTempName:dict[@"data"][@"username"]];
                     [LYouUserDefauleManager setToken:dict[@"data"][@"token"]];
                     [LYouUserDefauleManager setIsTempUser:@"1"];
                     [superView removeFromSuperview];
                     [[LYUserCenterManager instance] showFuBiao];
                     self.loginBlock(2,dict[@"data"][@"token"]);
                 } failureBlock:^(NSString *errorMessage) {
                     [SVProgressHUD showErrorWithStatus:errorMessage];
                 }];
             }
         }else{
             /** 账号登录 */
             [superView removeFromSuperview];
             LYouAcountLoginController *accountVC = [LYouAcountLoginController sharedVC];
             accountVC.loginBlock = self.loginBlock;
             UIViewController *TTop = [LYouTopViewManager topViewController];
             [TTop.view addSubview:accountVC.view];
         }
     };
}



#pragma mark - initAccountViewUI
-(LYLoginView *)loginView{
    if (!_loginView) {
        _loginView = [[LYLoginView alloc]init];
    }
    return _loginView;
}

@end
