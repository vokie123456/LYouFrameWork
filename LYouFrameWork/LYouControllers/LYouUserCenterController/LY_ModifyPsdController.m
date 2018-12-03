//
//  LY_ModifyPsdController.m
//  LYouFrameWork
//
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LY_ModifyPsdController.h"

@interface LY_ModifyPsdController ()

@property(nonatomic,strong) UIImageView *modifyImage;

@end

@implementation LY_ModifyPsdController

+(instancetype)shared{
    static LY_ModifyPsdController *instence = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instence = [[LY_ModifyPsdController alloc] init];
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
    /** 修改密码 */
    self.modifyImage = [[UIImageView alloc]init];
    self.modifyImage.userInteractionEnabled = YES;
    self.modifyImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@kuang",LY_ImagePath]];
    [self.view addSubview:self.modifyImage];
    self.modifyImage.sd_layout.leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(self.view, Main_Screen_Height/2-100).heightIs(270);
    /** 标题 */
    NSArray *titleArray = @[@"密      码:",@"确认密码:"];
    NSArray *placeArray = @[@"请输入密码",@"请再次输入密码"];
    for (int i=0; i<2; i++) {
        UILabel *titleLable = [[UILabel alloc]init];
        titleLable.font = LYFont_Medium(17);
        titleLable.text = titleArray[i];
        titleLable.textColor = ColorWithHexRGB(0x684CD7);
        [self.modifyImage addSubview:titleLable];
        titleLable.sd_layout.leftSpaceToView(self.modifyImage , 15).topSpaceToView(self.modifyImage, 60+i*45).widthIs(80).autoHeightRatio(0);
        /** 输入框 */
        UITextField *textFiled = [[UITextField alloc]init];
        textFiled.font = LYFont_Medium(16);
        textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        textFiled.tag = i+10;
        textFiled.placeholder = placeArray[i];
        [textFiled setValue:ColorWithHexRGB(0x85A9F5) forKeyPath:@"_placeholderLabel.textColor"];
        [self.modifyImage addSubview:textFiled];
        textFiled.sd_layout.leftSpaceToView(self.modifyImage , 95).topSpaceToView(self.modifyImage, 61+i*45).rightSpaceToView(self.modifyImage, 15).heightIs(25);
        /** 分割线 */
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = ColorWithHexRGB(0x684CD7);
        [self.modifyImage addSubview:line];
        line.sd_layout.leftSpaceToView(self.modifyImage, 95).topSpaceToView(self.modifyImage, 87+i*45).rightSpaceToView(self.modifyImage, 15).heightIs(1.5);
    }
    /** 确认 */
    UIButton *sureButton = [[UIButton alloc]init];
    [sureButton setBackgroundColor:ColorWithHexRGB(0x684CD7)];
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    sureButton.titleLabel.font = LYFont_Medium(16);
    sureButton.layer.cornerRadius = 5;
    [self.modifyImage addSubview:sureButton];
    UITextField *laseField = (UITextField *)[self.view viewWithTag:11];
    sureButton.sd_layout.leftSpaceToView(self.modifyImage, 40).rightSpaceToView(self.modifyImage, 40).topSpaceToView(laseField, 30).heightIs(35);
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - x确认
-(void)sureButtonClick:(UIButton *)sneder{
    
}

#pragma mark - 返回
-(void)backButtonClick:(UIButton *)sender
{
    [self.view removeFromSuperview];
}

@end
