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

@interface LYouLoginController ()

@property(nonatomic,strong)LYLoginView *loginView;

@end

@implementation LYouLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.loginView];
    /** 创建登录窗口 */
 self.loginView.sd_layout.centerYEqualToView(self.view).centerXEqualToView(self.view).widthIs(Main_Rotate_Width-80).heightIs(260);
     self.loginView.accountLoginClick = ^(UIView *superView,AccountLoginStyle style){
         if (style==VisitorLogin) {
             /** 游客登录 */
             [superView removeFromSuperview];
         }else{
             /** 账号登录 */
             [superView removeFromSuperview];
             LYouAcountLoginController *accountVC = [LYouAcountLoginController new];
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
