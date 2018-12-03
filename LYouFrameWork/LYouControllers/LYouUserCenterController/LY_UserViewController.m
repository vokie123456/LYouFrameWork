//
//  LY_UserViewController.m
//  LYouFrameWork
//
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LY_UserViewController.h"
#import "LYUserCenterManager.h"
#import "LY_BindPhoneController.h"

@interface LY_UserViewController ()

@property(nonatomic,strong) UIView *mainView;
@property(nonatomic,strong) UIImageView *bgImageView;
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) UILabel *userNameLable;    /** 用户名 */
@property(nonatomic,strong)UILabel *bindPhoneLable;    /** 绑定手机号 */

@end

@implementation LY_UserViewController

+(instancetype)sharedUserVC{
    static LY_UserViewController *instence = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       instence = [[LY_UserViewController alloc] init];
    });
    return instence;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

-(void)creatUI{
    /** 主视图 */
    self.mainView = [[UIView alloc]init];
    self.mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainView];
    self.mainView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, 0).widthIs(Main_Rotate_Width/3*2).heightIs(Main_Screen_Height);
    /** 背景图 */
    self.bgImageView = [[UIImageView alloc]init];
    self.bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@彩条",LY_ImagePath]];
    [self.mainView addSubview:self.bgImageView];
    self.bgImageView.sd_layout.leftSpaceToView(self.mainView, 0).topSpaceToView(self.mainView, 0).rightSpaceToView(self.mainView, 0).heightIs(120);
    /** 头像 */
    self.headImageView = [[UIImageView alloc]init];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 27;
    self.headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@头像",LY_ImagePath]];
    [self.bgImageView addSubview:self.headImageView];
self.headImageView.sd_layout.centerXEqualToView(self.bgImageView).centerYEqualToView(self.bgImageView).widthIs(54).heightIs(54);
    /** 用户名 */
    self.userNameLable = [[UILabel alloc]init];
    self.userNameLable.font = LYFont_Medium(16);
    self.userNameLable.textColor = UIColorBlackTheme;
    self.userNameLable.text = @"您好，59929393944";
    [self.mainView addSubview:self.userNameLable];
    self.userNameLable.sd_layout.leftSpaceToView(self.mainView, 10).topSpaceToView(self.bgImageView, 10).rightSpaceToView(self.mainView, 0).autoHeightRatio(0);
    /** 绑定手机号 */
    UIView *bindTopLine = [[UIView alloc]init];
    bindTopLine.backgroundColor = UIColorDarkLightTheme;
    [self.mainView addSubview:bindTopLine];
    bindTopLine.sd_layout.leftSpaceToView(self.mainView, 0).topSpaceToView(self.userNameLable, 10).rightSpaceToView(self.mainView, 0).heightIs(2);
    UIButton *bindPhoneBtn = [[UIButton alloc]init];
    [self.mainView addSubview:bindPhoneBtn];
    [bindPhoneBtn addTarget:self action:@selector(bindPhoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    bindPhoneBtn.sd_layout.leftSpaceToView(self.mainView, 0).topSpaceToView(bindTopLine, 0).rightSpaceToView(self.mainView, 0).heightIs(45);
    UIImageView *bindImage = [[UIImageView alloc]init];
    bindImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@手机",LY_ImagePath]];
    [bindPhoneBtn addSubview:bindImage];
    bindImage.sd_layout.leftSpaceToView(bindPhoneBtn, 30).topSpaceToView(bindPhoneBtn, 10).widthIs(20).heightIs(25);
    self.bindPhoneLable = [[UILabel alloc]init];
    [bindPhoneBtn addSubview:self.bindPhoneLable];
    self.bindPhoneLable.textAlignment = NSTextAlignmentCenter;
    self.bindPhoneLable.font = LYFont_Medium(16);
    self.bindPhoneLable.textColor = UIColorBlackTheme;
    self.bindPhoneLable.text = @"绑定手机号";
    self.bindPhoneLable.sd_layout.leftSpaceToView(bindPhoneBtn, 0).topSpaceToView(bindPhoneBtn, 0).rightSpaceToView(bindPhoneBtn, 0).heightRatioToView(bindPhoneBtn, 1);
    UIView *bindBottemLine = [[UIView alloc]init];
    bindBottemLine.backgroundColor = UIColorDarkLightTheme;
    [self.mainView addSubview:bindBottemLine];
    bindBottemLine.sd_layout.leftSpaceToView(self.mainView, 0).topSpaceToView(bindPhoneBtn, 0).rightSpaceToView(self.mainView, 0).heightIs(2);
    /** 切换账号 */
    UIView *changeTopLine = [[UIView alloc]init];
    changeTopLine.backgroundColor = UIColorDarkLightTheme;
    [self.mainView addSubview:changeTopLine];
    changeTopLine.sd_layout.leftSpaceToView(self.mainView, 0).bottomSpaceToView(self.mainView, 45).rightSpaceToView(self.mainView, 0).heightIs(2);
    UIButton *changeAccountBtn = [[UIButton alloc]init];
    [changeAccountBtn setBackgroundColor:ColorWithHexRGB(0x4971B6)];
    [changeAccountBtn setTitle:@"切换账号" forState:UIControlStateNormal];
    changeAccountBtn.titleLabel.font = LYFont_Medium(16);
    changeAccountBtn.layer.cornerRadius = 5;
    [self.mainView addSubview:changeAccountBtn];
    changeAccountBtn.sd_layout.leftSpaceToView(self.mainView, 60).topSpaceToView(changeTopLine, 5).rightSpaceToView(self.mainView, 60).heightIs(35);
}

#pragma amrk - 绑定手机号
-(void)bindPhoneBtnClick:(UIButton *)sender{
    LY_BindPhoneController *bindPhone = [LY_BindPhoneController shared];
    [self.view addSubview:bindPhone.view];
    bindPhone.view.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, 0).widthIs(Main_Rotate_Width/3*2).heightIs(Main_Screen_Height);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if (![self.mainView.layer containsPoint:point]) {
        [[LYUserCenterManager instance] CloseFubiaoAction];
    }
}



@end
