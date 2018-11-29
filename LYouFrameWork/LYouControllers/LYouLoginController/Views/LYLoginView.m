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
    titleLable.text = @"账号通行证";
    titleLable.textColor = [UIColor blackColor];
    titleLable.font = LYFont_Medium(20);
    [self addSubview:titleLable];
    titleLable.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 2).heightIs(65);
    /**  游客登录/账号登录 */
    NSArray *titleArray = @[@"游客登录",@"账号登录"];
    for (int i=0; i<2; i++) {
        UIButton *accountLoginBtn = [UIButton new];
        accountLoginBtn.layer.cornerRadius = 20;
        [accountLoginBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        accountLoginBtn.titleLabel.font = LYFont_Medium(15);
        [accountLoginBtn setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
        [accountLoginBtn setBackgroundColor:ColorWithHexRGB(0xB577F4)];
        accountLoginBtn.tag = i+10;
        [self addSubview:accountLoginBtn];
        accountLoginBtn.sd_layout.leftSpaceToView(self, 25).rightSpaceToView(self, 25).topSpaceToView(headImageView,40+i*60).heightIs(40);
        if (accountLoginBtn.tag==11) {
            [accountLoginBtn setBackgroundColor:ColorWithHexRGB(0x9932CC)];
            [accountLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [accountLoginBtn addTarget:self action:@selector(accountLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 选择登录方式(游客/账号)
-(void)accountLoginClick:(UIButton *)sender
{
    if (self.accountLoginClick) {
        sender.tag==10 ? self.accountLoginClick(self.superview,VisitorLogin) : self.accountLoginClick(self.superview,AccountLogin);
    }
}

@end