//
//  LYAccountLoginView.h
//  LYouFrameWork
//  账号登录页面
//  Created by grx on 2018/11/29.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RegistAccount,//注册账号
    VisitorLogin,//游客登录
} AccountLoginStyle;

NS_ASSUME_NONNULL_BEGIN

@interface LYAccountLoginView : UIView

@property(nonatomic,copy) void (^forgetPsdClick)(UIView *superView);
@property(nonatomic,copy) void (^registClick)(UIView *superView, AccountLoginStyle style);
@property(nonatomic,copy) void (^accountLoginClick)(UIView *superView);

@end

NS_ASSUME_NONNULL_END
