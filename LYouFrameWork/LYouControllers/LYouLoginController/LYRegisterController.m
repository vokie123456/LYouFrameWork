//
//  LYRegisterController.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/29.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYRegisterController.h"
#import "LYouAcountLoginController.h"
#import "LYRegistView.h"

@interface LYRegisterController ()

@property(nonatomic,strong) LYRegistView *registView;

@end

@implementation LYRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.registView];
    /** 注册页面 */
    self.registView.sd_layout.centerYEqualToView(self.view).centerXEqualToView(self.view).widthIs(Main_Rotate_Width-80).heightIs(334);
    /** 返回 */
    self.registView.backClick = ^(UIView * _Nonnull superView) {
        [superView removeFromSuperview];
    };
    self.registView.sendSMSClick = ^(LYCountDownButton *sender){
        /** 开始倒计时 */
        UITextField *phonefield = (UITextField *)[self.registView viewWithTag:10];
        [[LYouNetWorkManager instance]getVerifyMessageWithPhone:phonefield.text withType:@"1" SuccessBlock:^(NSDictionary *dict) {
            [SVProgressHUD showSuccessWithStatus:@"发送成功!"];
            [self sendSuccess:sender];
        } FailureBock:^(NSString *errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
    };
    /** 注册 */
    self.registView.submitPassClick = ^(UIView * _Nonnull superView) {
        UITextField *phonefield = (UITextField *)[self.registView viewWithTag:10];
        UITextField *verififield = (UITextField *)[self.registView viewWithTag:11];
        UITextField *pasfield = (UITextField *)[self.registView viewWithTag:12];
        [[LYouNetWorkManager instance] RegisteredAccountWithPhoneNum:phonefield.text Password:pasfield.text Verification:verififield.text SuccessBlock:^(NSDictionary *dict) {
            [LYouUserDefauleManager setUserName:phonefield.text];
            [LYouUserDefauleManager setUserPassword:pasfield.text];
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [LYouUserDefauleManager setIsTempUser:@"0"];
            [[LYouAcountLoginController sharedVC] cheakCurrentAcount];
            [superView removeFromSuperview];
        } FailureBock:^(NSString *errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
    };
}

-(void)sendSuccess:(LYCountDownButton *)sender{
    sender.enabled = NO;
    [sender startWithSecond:60.0];
    [sender didChange:^NSString *(LYCountDownButton *countDownButton,int second) {
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor lightGrayColor]];
        NSString *title = [NSString stringWithFormat:@"%ds",second];
        return title;
    }];
    [sender didFinished:^NSString *(LYCountDownButton *countDownButton, int second) {
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sender setBackgroundColor:ColorWithHexRGB(0x5C3BFE)];
        countDownButton.enabled = YES;
        return @"重新获取";
    }];
}

#pragma mark - initRegistViewUI
-(LYRegistView *)registView{
    if (!_registView) {
        _registView = [[LYRegistView alloc]init];
    }
    return _registView;
}

@end
