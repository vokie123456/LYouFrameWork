//
//  ViewController.m
//  LYouFrameWorkApp
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "ViewController.h"
#import <LYouFrameWork/LYouManager.h>
#import "SDAutoLayout.h"

@interface ViewController ()

@property(nonatomic,strong) UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    /** 登录 */
    [self.view addSubview:self.loginButton];

}

-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc]init];
        _loginButton.frame = CGRectMake(60, 100, 200, 60);
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor blueColor]];
        _loginButton.layer.borderWidth = 1;
        [_loginButton addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(void)loginClick:(UIButton *)sender
{
    [[LYouManager sharedManager] LY_ShowLoginView];
}

@end
