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

+(instancetype)sharedVC{
    static LYouAcountLoginController *instence = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instence = [[LYouAcountLoginController alloc] init];
    });
    return instence;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self cheakCurrentAcount];
}

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
    WeakSelf(weakSelf);
    self.accountView.accountLoginClick = ^(UIView *superView){
        UITextField *accountFiled = (UITextField *)[weakSelf.accountView viewWithTag:10];
        UITextField *pasFiled = (UITextField *)[weakSelf.accountView viewWithTag:11];
        
        [[LYouNetWorkManager instance] LoginWithAppKey:[LYouUserDefauleManager getAppkey] PhoneNumber:accountFiled.text Password:pasFiled.text loginSuccessBlock:^(NSDictionary *dict) {
            NSString *token = [NSString stringWithFormat:@"%@",dict[@"data"][@"token"]];
            [LYouUserDefauleManager setToken:token];
            [LYouUserDefauleManager setUserName:accountFiled.text];
            [LYouUserDefauleManager setUserPassword:pasFiled.text];
            [LYouUserDefauleManager setIsTempUser:@"0"];
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [superView removeFromSuperview];
            [[LYUserCenterManager instance] showFuBiao];
            NSLog(@"登陆成功：%@",dict);
            self.loginBlock(1,dict[@"uid"],dict[@"token"]);
        } FailureBock:^(NSString *errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
            NSLog(@"登录失败：%@",errorMessage);
        }];
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
                    self.loginBlock(2,@"",dict[@"data"][@"token"]);
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
                    self.loginBlock(2,@"",dict[@"data"][@"token"]);
                } failureBlock:^(NSString *errorMessage) {
                    [SVProgressHUD showErrorWithStatus:errorMessage];
                }];
            }
        }
    };
}

-(void)cheakCurrentAcount{
    UITextField *accountFiled = (UITextField *)[self.accountView viewWithTag:10];
    UITextField *pasFiled = (UITextField *)[self.accountView viewWithTag:11];
    
    if ([LYouUserDefauleManager getTempName].length!=0) {
        NSString *tempName = [LYouUserDefauleManager getTempName];
        accountFiled.text = tempName;
        pasFiled.text = @"123456";
        return;
    }
    if ([LYouUserDefauleManager getUserName].length!=0) {
        NSString *username = [LYouUserDefauleManager getUserName];
        accountFiled.text = username;
    }
    if ([LYouUserDefauleManager getUserPassword].length >1) {
        NSString *pwd = [LYouUserDefauleManager getUserPassword];
        pasFiled.text = pwd;
    }
}

#pragma mark - initAccountViewUI
-(LYAccountLoginView *)accountView{
    if (!_accountView) {
        _accountView = [[LYAccountLoginView alloc]init];
    }
    return _accountView;
}

@end
