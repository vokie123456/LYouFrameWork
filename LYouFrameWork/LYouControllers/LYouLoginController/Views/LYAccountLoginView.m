//
//  LYAccountLoginView.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/29.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYAccountLoginView.h"
#import "UIView+FTCornerdious.h"

@implementation LYAccountLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius = 5;
        self.backgroundColor = ColorWithHexRGB(0xEAEAEA);
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
    titleLable.text = @"账号登录";
    titleLable.textColor = [UIColor blackColor];
    titleLable.font = LYFont_Medium(20);
    [self addSubview:titleLable];
    titleLable.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 2).heightIs(65);
    /**  账号/密码 */
    NSArray *titleArray = @[@"请输入账号",@"请输入密码"];
    for (int i=0; i<2; i++) {
        UIButton *accountBgView = [UIButton new];
        accountBgView.layer.cornerRadius = 20;
        accountBgView.tag = i+100;
        [accountBgView setBackgroundColor:ColorWithHexRGB(0xD5BAEE)];
        accountBgView.layer.borderWidth = 1;
        accountBgView.layer.borderColor = ColorWithHexRGB(0x85A9F5).CGColor;
        [self addSubview:accountBgView];
        accountBgView.sd_layout.leftSpaceToView(self, 25).rightSpaceToView(self, 25).topSpaceToView(headImageView,15+i*50).heightIs(40);
        /** 输入框 */
        UITextField *accountFiled = [UITextField new];
        accountFiled.placeholder = titleArray[i];
        [accountFiled setValue:ColorWithHexRGB(0x85A9F5) forKeyPath:@"_placeholderLabel.textColor"];
        accountFiled.textAlignment = NSTextAlignmentCenter;
        accountFiled.font = LYFont_Medium(17);
        accountFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        accountFiled.textColor = UIColorBlackTheme;
        accountFiled.tag = i+10;
        [accountBgView addSubview:accountFiled];
        accountFiled.sd_layout.leftSpaceToView(accountBgView, 25).rightSpaceToView(accountBgView, 25).topSpaceToView(accountBgView,0).heightIs(40);
        if (accountFiled.tag==11) {
            accountFiled.secureTextEntry = YES;
        }
    }
    /** 忘记密码 */
    UIButton *fogetPswBtn = [UIButton new];
    fogetPswBtn.titleLabel.font = LYFont_Medium(14);
    [fogetPswBtn setTitleColor:UIColorLightTheme forState:UIControlStateNormal];
    [fogetPswBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self addSubview:fogetPswBtn];
    UIButton *lastButton = (UIButton *)[self viewWithTag:101];
    fogetPswBtn.sd_layout.rightSpaceToView(self, 20).topSpaceToView(lastButton,10).widthIs(100).heightIs(20);
    [fogetPswBtn addTarget:self action:@selector(fogetPswBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    /** 账号登录 */
    UIButton *accountLoginBtn = [UIButton new];
    accountLoginBtn.layer.cornerRadius = 20;
    [accountLoginBtn setTitle:@"账号登录" forState:UIControlStateNormal];
    accountLoginBtn.titleLabel.font = LYFont_Medium(15);
    [accountLoginBtn setBackgroundColor:ColorWithHexRGB(0x9932CC)];
    [accountLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:accountLoginBtn];
    accountLoginBtn.sd_layout.leftSpaceToView(self, 25).rightSpaceToView(self, 25).topSpaceToView(fogetPswBtn,10).heightIs(40);
    [accountLoginBtn addTarget:self action:@selector(accountLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    
    /** 注册账号/游客登录 */
    UIView *registBgView = [UIView new];
    registBgView.backgroundColor = ColorWithHexRGB(0x5C3BFE);
    [self addSubview:registBgView];
    registBgView.frame = CGRectMake(0, 334-70, Main_Rotate_Width-80, 70);
    [registBgView setFtCornerdious:5 Corners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
    /**  账号/密码 */
    NSArray *registImageArray = @[@"login_phone_zhuce",@"login_account_zhuce"];
    NSArray *registArray = @[@"注册账号",@"游客登录"];
    for (int i=0; i<2; i++) {
        UIButton *registButton = [UIButton new];
        registButton.tag = i+1000;
        [registBgView addSubview:registButton];
        registButton.sd_layout.leftSpaceToView(registBgView, i*(Main_Rotate_Width-80)/2).topSpaceToView(registBgView,0).widthIs((Main_Rotate_Width-80)/2).heightIs(65);
        [registButton addTarget:self action:@selector(registButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        /** 注册图片 */
        UIImageView *registImage = [UIImageView new];
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",LY_ImagePath,registImageArray[i]];
        registImage.image = [UIImage imageNamed:imagePath];
        [registButton addSubview:registImage];
    registImage.sd_layout.centerXEqualToView(registButton).bottomSpaceToView(registButton, 25).widthIs(35).heightIs(30);
        /** 注册标题 */
        UILabel *registTitle = [UILabel new];
        registTitle.text = registArray[i];
        registTitle.font = LYFont_Medium(13);
        registTitle.textAlignment = NSTextAlignmentCenter;
        registTitle.textColor = [UIColor whiteColor];
        [registButton addSubview:registTitle];
    registTitle.sd_layout.centerXEqualToView(registButton).bottomSpaceToView(registButton, 3).widthIs(100).autoHeightRatio(0);
    }
}

#pragma mark - 忘记密码
-(void)fogetPswBtnClick:(UIButton *)sender
{
    if (self.forgetPsdClick) {
        self.forgetPsdClick(self.superview);
    }
}

#pragma mark - 账户登录
-(void)accountLoginClick:(UIButton *)sender
{
    UITextField *accountfield = (UITextField *)[self viewWithTag:10];
    UITextField *passfield = (UITextField *)[self viewWithTag:11];
    if (accountfield.text.length==0) {
        [SVProgressHUD showInfoWithStatus:@"账号不能为空"];
        return;
    }
    if (passfield.text.length==0) {
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        return;
    }
    if (self.accountLoginClick) {
        self.accountLoginClick(self.superview);
    }
}

#pragma mark - 注册用户/游客登录
-(void)registButtonClick:(UIButton *)sender
{
    if (self.registClick) {
        sender.tag==1000 ? self.registClick(self.superview,RegistAccount) : self.registClick(self.superview,VisitorLogin);
    }
}

@end
