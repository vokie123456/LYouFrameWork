//
//  LYouAcountLoginController.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/29.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouAcountLoginController.h"
#import "LYAccountLoginView.h"
#import "LYFogetPswordController.h"
#import "LYRegisterController.h"

@interface LYouAcountLoginController ()

@property(nonatomic,strong) LYAccountLoginView *accountView;

@end

@implementation LYouAcountLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.accountView];
    /** 创建登录窗口 */
 self.accountView.sd_layout.centerYEqualToView(self.view).centerXEqualToView(self.view).widthIs(Main_Rotate_Width-80).heightIs(334);
    /** 忘记密码 */
    self.accountView.forgetPsdClick = ^(UIView *superView){
        LYFogetPswordController *forgetVC = [[LYFogetPswordController alloc]init];
        forgetVC.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
        UIViewController *TTop = [LYouTopViewManager topViewController];
        [TTop.view addSubview:forgetVC.view];
    };
    /** 账号登录 */
    self.accountView.accountLoginClick = ^(UIView *superView){
        self.loginBlock(1, @"123222222222", @"132");
        [superView removeFromSuperview];
    };
    /** 账号注册 */
    self.accountView.registClick = ^(UIView * _Nonnull superView, AccountLoginStyle style){
        if (style==RegistAccount) {
            /** 注册账号 */
            LYRegisterController *registVC = [[LYRegisterController alloc]init];
            registVC.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
            UIViewController *TTop = [LYouTopViewManager topViewController];
            [TTop.view addSubview:registVC.view];
        }else{
            /** 游客登录 */
            [superView removeFromSuperview];
        }
    };
}

#pragma mark - initAccountViewUI
-(LYAccountLoginView *)accountView{
    if (!_accountView) {
        _accountView = [[LYAccountLoginView alloc]init];
    }
    return _accountView;
}

@end
