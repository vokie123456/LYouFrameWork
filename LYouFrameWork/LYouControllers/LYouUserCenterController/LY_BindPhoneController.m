//
//  LY_BindPhoneController.m
//  LYouFrameWork
//
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LY_BindPhoneController.h"

@interface LY_BindPhoneController ()

@property(nonatomic,strong) UIImageView *bindPhoneView;

@end

@implementation LY_BindPhoneController

+(instancetype)shared{
    static LY_BindPhoneController *instence = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instence = [[LY_BindPhoneController alloc] init];
    });
    return instence;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /** 返回按钮 */
    UIButton *backButton = [[UIButton alloc]init];
    [backButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@regist_back",LY_ImagePath]] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    backButton.sd_layout.topSpaceToView(self.view, 30).rightSpaceToView(self.view, 15).widthIs(30).heightIs(30);
    /** 绑定手机号 */
    self.bindPhoneView = [[UIImageView alloc]init];
    self.bindPhoneView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@kuang",LY_ImagePath]];
    [self.view addSubview:self.bindPhoneView];
    self.bindPhoneView.sd_layout.leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(self.view, Main_Screen_Height/2-100).heightIs(260);
}

#pragma mark - 返回
-(void)backButtonClick:(UIButton *)sender
{
    [self.view removeFromSuperview];
}

@end
