//
//  LYAccountLoginView.h
//  LYouFrameWork
//  账号登录页面
//  Created by grx on 2018/11/29.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    RegistAccount,//注册账号
    VisitorLogin,//游客登录
} AccountLoginStyle;

typedef void(^ForgetPsdClick)(UIView *superView);
typedef void(^RegistClick)(UIView *superView, AccountLoginStyle style);
typedef void(^AccountLoginClick)(UIView *superView);


@interface LYAccountLoginView : UIView

@property(nonatomic,copy) ForgetPsdClick forgetPsdClick;
@property(nonatomic,copy) RegistClick registClick;
@property(nonatomic,copy) AccountLoginClick accountLoginClick;
@property(nonatomic,strong) UITextField *accountFiled;
@property(nonatomic,strong) UIButton *checkPsdBtn;

@end

NS_ASSUME_NONNULL_END
