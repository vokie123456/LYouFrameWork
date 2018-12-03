//
//  ViewController.m
//  LYouFrameWorkApp
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "ViewController.h"
#import <LYouFrameWork/LYouManager.h>

@interface ViewController ()

@property(nonatomic,strong) UIButton *loginButton;
@property(nonatomic,strong) UIButton *payButton;
@property(nonatomic,strong) UIButton *loginOutButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    /** 登录 */
    [self.view addSubview:self.loginButton];
    /** 支付 */
    [self.view addSubview:self.payButton];
    /** 退出 */
    [self.view addSubview:self.loginOutButton];
}

#pragma mark - ===========登录模块==========
-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc]init];
        _loginButton.frame = CGRectMake(60, 80, 200, 60);
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor blueColor]];
        _loginButton.layer.borderWidth = 1;
        [_loginButton addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(void)loginClick:(UIButton *)sender
{
    [[LYouManager sharedManager] LY_ShowLoginView:^(int code, NSString *uid, NSString *token) {
        NSLog(@"=====%d====%@======%@",code,uid,token);
    }];
}

#pragma mark - ===========支付模块==========
-(UIButton *)payButton{
    if (!_payButton) {
        _payButton = [[UIButton alloc]init];
        _payButton.frame = CGRectMake(60, 160, 200, 60);
        [_payButton setTitle:@"支付" forState:UIControlStateNormal];
        [_payButton setBackgroundColor:[UIColor blueColor]];
        _payButton.layer.borderWidth = 1;
        [_payButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

-(void)payButtonClick:(UIButton *)sender
{
    
}

#pragma mark - ===========退出模块==========
-(UIButton *)loginOutButton{
    if (!_loginOutButton) {
        _loginOutButton = [[UIButton alloc]init];
        _loginOutButton.frame = CGRectMake(60, 240, 200, 60);
        [_loginOutButton setTitle:@"退出" forState:UIControlStateNormal];
        [_loginOutButton setBackgroundColor:[UIColor blueColor]];
        _loginOutButton.layer.borderWidth = 1;
        [_loginOutButton addTarget:self action:@selector(loginOutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginOutButton;
}

-(void)loginOutButtonClick:(UIButton *)sender
{
    
}

@end
