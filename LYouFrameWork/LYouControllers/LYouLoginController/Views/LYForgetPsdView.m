//
//  LYForgetPsdView.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/29.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYForgetPsdView.h"
#import "UIView+FTCornerdious.h"
#import "UtilityFunction.h"

@implementation LYForgetPsdView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius = 5;
//        self.backgroundColor = ColorWithHexRGB(0xEAEAEA);
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    UIImageView *headImageView = [UIImageView new];
    headImageView.frame = CGRectMake(0, 0, Main_Rotate_Width-80, 65);
    [headImageView setFtCornerdious:5 Corners:UIRectCornerTopLeft|UIRectCornerTopRight];
    headImageView.layer.masksToBounds = YES;
    [self addSubview:headImageView];
    headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@head_image",LY_ImagePath]];
    /** 标题 */
    UILabel *titleLable = [UILabel new];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"忘记密码";
    titleLable.textColor = [UIColor blackColor];
    titleLable.font = LYFont_Medium(20);
    [self addSubview:titleLable];
    titleLable.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 2).heightIs(65);
    /** 返回按钮 */
    UIButton *backButton = [UIButton new];
    [backButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@back_image",LY_ImagePath]] forState:UIControlStateNormal];
    [self addSubview:backButton];
    backButton.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, 22).widthIs(25).heightIs(25);
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    /**  手机号/验证码/密码 */
    NSArray *titleArray = @[@"请输入手机号",@"请输入验证码",@"请输入密码"];
    for (int i=0; i<3; i++) {
        UIButton *forgetBgView = [UIButton new];
        forgetBgView.layer.cornerRadius = 20;
        forgetBgView.tag = i+100;
        [forgetBgView setBackgroundColor:ColorWithHexRGB(0xD5BAEE)];
        forgetBgView.layer.borderWidth = 1;
        forgetBgView.layer.borderColor = ColorWithHexRGB(0x85A9F5).CGColor;
        [self addSubview:forgetBgView];
        forgetBgView.sd_layout.leftSpaceToView(self, 25).rightSpaceToView(self, 25).topSpaceToView(headImageView,25+i*55).heightIs(40);
        /** 输入框 */
        UITextField *forgetFiled = [UITextField new];
        forgetFiled.placeholder = titleArray[i];
        [forgetFiled setValue:ColorWithHexRGB(0x85A9F5) forKeyPath:@"_placeholderLabel.textColor"];
        forgetFiled.textAlignment = NSTextAlignmentLeft;
        forgetFiled.font = LYFont_Medium(17);
        forgetFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        forgetFiled.textColor = UIColorBlackTheme;
        forgetFiled.tag = i+10;
        [forgetBgView addSubview:forgetFiled];
        forgetFiled.sd_layout.leftSpaceToView(forgetBgView, 25).rightSpaceToView(forgetBgView, 25).topSpaceToView(forgetBgView,0).heightIs(40);
        if (forgetFiled.tag==11) {
            /** 验证码 */
            forgetFiled.sd_layout.rightSpaceToView(forgetBgView, 90);
            [self addSNSView:forgetBgView];
        }
        if (forgetFiled.tag==12) {
            /** 密码 */
            forgetFiled.secureTextEntry = YES;
            forgetFiled.sd_layout.rightSpaceToView(forgetBgView, 50);
            [forgetBgView addSubview:self.checkPsdBtn];
            self.checkPsdBtn.sd_layout.rightSpaceToView(forgetBgView, 25).topSpaceToView(forgetBgView, 10).widthIs(20).heightIs(20);
        }
    }
    /** 完成按钮 */
    UIButton *submitBtn = [UIButton new];
    submitBtn.layer.cornerRadius = 22;
    [submitBtn setTitle:@"完成" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = LYFont_Medium(20);
    [submitBtn setBackgroundColor:ColorWithHexRGB(0x9932CC)];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:submitBtn];
    submitBtn.sd_layout.leftSpaceToView(self, 25).rightSpaceToView(self, 25).bottomSpaceToView(self, 28).heightIs(44);
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 获取验证码
-(void)addSNSView:(UIView *)superView
{
    self.button = [LYCountDownButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.button.titleLabel.font = LYFont_Medium(14);
    self.button.layer.cornerRadius = 20;
    [self.button setBackgroundColor:ColorWithHexRGB(0x5C3BFE)];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [superView addSubview:self.button];
    self.button.sd_layout.rightSpaceToView(superView,0).topSpaceToView(superView,0).heightIs(40).widthIs(90);
    WeakSelf(weakSelf);
    [self.button addToucheHandler:^(LYCountDownButton*sender, NSInteger tag) {
        /*! 验证手机号 */
        UITextField *phonefield = (UITextField *)[weakSelf viewWithTag:10];

        if ([UtilityFunction isMobileNumber:phonefield.text]==NO) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
            return;
        }
        if (weakSelf.sendSMSClick) {
            weakSelf.sendSMSClick(sender);
        }
    }];
}

#pragma mark - 提交
-(void)submitBtnClick:(UIButton *)sender{
    UITextField *phonefield = (UITextField *)[self viewWithTag:10];
    UITextField *yanZhfield = (UITextField *)[self viewWithTag:11];
    UITextField *passfield = (UITextField *)[self viewWithTag:12];
    if ([UtilityFunction isMobileNumber:phonefield.text]==NO) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    if (yanZhfield.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (passfield.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    if (self.submitPassClick) {
        self.submitPassClick(self.superview);
    }
}

#pragma mark - 查看密码
-(UIButton *)checkPsdBtn{
    if (!_checkPsdBtn) {
        _checkPsdBtn = [UIButton new];
        [_checkPsdBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@TT_eye_open",LY_ImagePath]] forState:UIControlStateNormal];
        [_checkPsdBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@TT_eye_close",LY_ImagePath]] forState:UIControlStateSelected];
        [_checkPsdBtn setSelected:NO];
        [_checkPsdBtn addTarget:self action:@selector(checkPsdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkPsdBtn;
}

-(void)checkPsdBtnClick:(UIButton *)sender
{
    UITextField *passfield = (UITextField *)[self viewWithTag:12];
    if (sender.isSelected) {
        [sender setSelected:NO];
        passfield.secureTextEntry=YES;
    }else{
        [sender setSelected:YES];
        passfield.secureTextEntry=NO;
    }
}

#pragma mark - 返回
-(void)backButtonClick:(UIButton *)sender
{
    if (self.backClick) {
        self.backClick(self.superview);
    }
}



@end
