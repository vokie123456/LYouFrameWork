//
//  LYForgetPaswordController.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/29.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYFogetPswordController.h"
#import "LYouAcountLoginController.h"
#import "LYForgetPsdView.h"

@interface LYFogetPswordController ()

@property(nonatomic,strong) LYForgetPsdView *forgetView;

@end

@implementation LYFogetPswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.forgetView];
    /** 创建登录窗口 */
 self.forgetView.sd_layout.centerYEqualToView(self.view).centerXEqualToView(self.view).widthIs(Main_Rotate_Width-80).heightIs(334);
     self.forgetView.backClick = ^(UIView *superView){
         [[UIApplication sharedApplication].keyWindow endEditing:YES];
         [superView endEditing:YES];
         [superView removeFromSuperview];
     };
     WeakSelf(weakSelf);
     self.forgetView.sendSMSClick = ^(LYCountDownButton *sender){
         /** 开始倒计时 */
         UITextField *phonefield = (UITextField *)[self.forgetView viewWithTag:10];
         [[LYouNetWorkManager instance]getVerifyMessageWithPhone:phonefield.text withType:@"3" SuccessBlock:^(NSDictionary *dict) {
             [SVProgressHUD showSuccessWithStatus:@"发送成功!"];
             [weakSelf sendSuccess:sender];
         } FailureBock:^(NSString *errorMessage) {
             [SVProgressHUD showErrorWithStatus:errorMessage];
         }];
     };
    /** 完成 */
    self.forgetView.submitPassClick = ^(UIView * _Nonnull superView) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        [superView endEditing:YES];
        UITextField *phonefield = (UITextField *)[superView viewWithTag:10];
        UITextField *verifield = (UITextField *)[superView viewWithTag:11];
        UITextField *pasfield = (UITextField *)[superView viewWithTag:12];
        
        [[LYouNetWorkManager instance]GetBackPassWordWithPhoneNum:phonefield.text Password:pasfield.text Verification:verifield.text SuccessBlock:^(NSDictionary *dict) {
            [SVProgressHUD showSuccessWithStatus:@"密码找回成功!"];
            [LYouUserDefauleManager setIsTempUser:@"0"];
            [LYouUserDefauleManager setUserName:phonefield.text];
            [LYouUserDefauleManager setUserPassword:pasfield.text];
            [[LYouAcountLoginController sharedVC] cheakCurrentAcount];
            [superView removeFromSuperview];
            if (self.forgetSuccess) {
                self.forgetSuccess();
            }
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        [self.view endEditing:YES];
}

#pragma mark - initForgetViewUI
-(LYForgetPsdView *)forgetView{
    if (!_forgetView) {
        _forgetView = [[LYForgetPsdView alloc]init];
    }
    return _forgetView;
}

@end
