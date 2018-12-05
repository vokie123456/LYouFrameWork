//
//  LYAccountView.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/28.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYLoginView.h"
#import "UIView+FTCornerdious.h"

@implementation LYLoginView

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
    UIImageView *headImageView = [[UIImageView alloc]init];
    headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@head_image",LY_ImagePath]];
    headImageView.frame = CGRectMake(0, 0, Main_Rotate_Width-80, 65);
    [self addSubview:headImageView];
    
    /** 标题 */
    UILabel *titleLable = [UILabel new];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"账号通行证";
    titleLable.textColor = [UIColor blackColor];
    titleLable.font = LYFont_Medium(20);
    [self addSubview:titleLable];
    titleLable.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 2).heightIs(65);
    /**  游客登录/账号登录 */
    NSArray *titleArray = @[@"游客登录",@"账号登录"];
    for (int i=0; i<2; i++) {
        self.accountLoginBtn = [UIButton new];
        self.accountLoginBtn.layer.cornerRadius = 45/2;
        [self.accountLoginBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        self.accountLoginBtn.titleLabel.font = LYFont_Medium(16);
        [self.accountLoginBtn setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
        [self.accountLoginBtn setBackgroundColor:ColorWithHexRGB(0xB577F4)];
        self.accountLoginBtn.tag = i+10;
        [self addSubview:self.accountLoginBtn];
        self.accountLoginBtn.sd_layout.leftSpaceToView(self, 25).rightSpaceToView(self, 25).topSpaceToView(headImageView,40+i*60).heightIs(45);
        if (self.accountLoginBtn.tag==11) {
            [self.accountLoginBtn setBackgroundColor:ColorWithHexRGB(0x9932CC)];
            [self.accountLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [self.accountLoginBtn addTarget:self action:@selector(accountLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 选择登录方式(游客/账号)
-(void)accountLoginClick:(UIButton *)sender
{
    if (self.accountLoginClick) {
        sender.tag==10 ? self.accountLoginClick(self.superview,VisitorLogin) : self.accountLoginClick(self.superview,AccountLogin);
    }
    if (self.test) {
        self.test();
    }
}

@end
