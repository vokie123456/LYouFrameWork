//
//  LY_BindPhoneController.m
//  LYouFrameWork
//
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LY_BindPhoneController.h"
#import "LYCountDownButton.h"
#import "UtilityFunction.h"

@interface LY_BindPhoneController ()

@property(nonatomic,strong) UIImageView *bindPhoneView;
@property(nonatomic,strong) LYCountDownButton *button;

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
    self.bindPhoneView.userInteractionEnabled = YES;
    self.bindPhoneView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@kuang",LY_ImagePath]];
    [self.view addSubview:self.bindPhoneView];
    self.bindPhoneView.sd_layout.leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(self.view, Main_Screen_Height/2-100).heightIs(270);
    /** 标题 */
    NSArray *titleArray = @[@"手机号:",@"验证码:",@"新密码:"];
    NSArray *placeArray = @[@"请输入手机号",@"验证码",@"请输入新密码"];
    for (int i=0; i<3; i++) {
        UILabel *titleLable = [[UILabel alloc]init];
        titleLable.font = LYFont_Medium(17);
        titleLable.text = titleArray[i];
        titleLable.textColor = ColorWithHexRGB(0x684CD7);
        [self.bindPhoneView addSubview:titleLable];
        titleLable.sd_layout.leftSpaceToView(self.bindPhoneView , 15).topSpaceToView(self.bindPhoneView, 35+i*40).widthIs(60).autoHeightRatio(0);
        /** 输入框 */
        UITextField *textFiled = [[UITextField alloc]init];
        textFiled.font = LYFont_Medium(16);
        textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        textFiled.tag = i+10;
        textFiled.placeholder = placeArray[i];
        [textFiled setValue:ColorWithHexRGB(0x85A9F5) forKeyPath:@"_placeholderLabel.textColor"];
        [self.bindPhoneView addSubview:textFiled];
        textFiled.sd_layout.leftSpaceToView(self.bindPhoneView , 78).topSpaceToView(self.bindPhoneView, 36+i*40).rightSpaceToView(self.bindPhoneView, 15).heightIs(25);
        if (textFiled.tag==11) {
            /** 验证码 */
            textFiled.sd_layout.rightSpaceToView(self.bindPhoneView, 80);
            [self addSNSView:self.bindPhoneView];
        }
        if (textFiled.tag==10||textFiled.tag==11) {
            textFiled.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (textFiled.tag==12) {
            textFiled.secureTextEntry = YES;
        }
        /** 分割线 */
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = ColorWithHexRGB(0x684CD7);
        [self.bindPhoneView addSubview:line];
        line.sd_layout.leftSpaceToView(self.bindPhoneView, 78).topSpaceToView(self.bindPhoneView, 62+i*40).rightSpaceToView(self.bindPhoneView, 15).heightIs(1.5);
    }
    /** 确认 */
    UIButton *sureButton = [[UIButton alloc]init];
    [sureButton setBackgroundColor:ColorWithHexRGB(0x684CD7)];
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    sureButton.titleLabel.font = LYFont_Medium(16);
    sureButton.layer.cornerRadius = 5;
    [self.bindPhoneView addSubview:sureButton];
    UITextField *laseField = (UITextField *)[self.view viewWithTag:12];
    sureButton.sd_layout.leftSpaceToView(self.bindPhoneView, 40).rightSpaceToView(self.bindPhoneView, 40).topSpaceToView(laseField, 20).heightIs(35);
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 获取验证码
-(void)addSNSView:(UIView *)superView
{
    self.button = [LYCountDownButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.button.titleLabel.font = LYFont_Medium(12);
    self.button.layer.cornerRadius = 5;
    [self.button setBackgroundColor:ColorWithHexRGB(0x5C3BFE)];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [superView addSubview:self.button];
    self.button.sd_layout.rightSpaceToView(superView,15).topSpaceToView(superView,70).heightIs(30).widthIs(70);
    WeakSelf(weakSelf);
    [self.button addToucheHandler:^(LYCountDownButton*sender, NSInteger tag) {
        /*! 验证手机号 */
        UITextField *phonefield = (UITextField *)[weakSelf.view viewWithTag:10];
        if ([UtilityFunction isMobileNumber:phonefield.text]==NO) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
            return;
        }
        /** 发送验证码 */
        [[LYouNetWorkManager instance] getVerifyMessageWithPhone:phonefield.text withType:@"2" SuccessBlock:^(NSDictionary *dict) {
            [SVProgressHUD showSuccessWithStatus:@"发送成功!"];
            /** 开始倒计时 */
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
        } FailureBock:^(NSString *errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
    }];
}

#pragma mark - 确认
-(void)sureButtonClick:(UIButton *)sender
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self.view endEditing:YES];
    UITextField *phonefield = (UITextField *)[self.view viewWithTag:10];
    UITextField *verfield = (UITextField *)[self.view viewWithTag:11];
    UITextField *pasfield = (UITextField *)[self.view viewWithTag:12];
    [[LYouNetWorkManager instance] AddPhoneNumberWithPhoneNum:phonefield.text Password:pasfield.text Verification:verfield.text SuccessBlock:^(NSDictionary *dict) {
        if (self.bindSuccess) {
            self.bindSuccess();
        }
        [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
        [LYouUserDefauleManager setUserName:phonefield.text];
        [LYouUserDefauleManager setUserPassword:pasfield.text];
        [LYouUserDefauleManager setIsTempUser:@"0"];
        [LYouUserDefauleManager setTempName:@""];
        [self.view removeFromSuperview];

    } FailureBock:^(NSString *errorMessage) {

        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

#pragma mark - 返回
-(void)backButtonClick:(UIButton *)sender
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self.view endEditing:YES];
    [self.view removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self.view endEditing:YES];
}

@end
