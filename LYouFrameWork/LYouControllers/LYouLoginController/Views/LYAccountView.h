//
//  LYAccountView.h
//  LYouFrameWork
//  游客/账户选择View
//  Created by grx on 2018/11/28.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    VisitorLogin,//游客登录
    AccountLogin,//账号登录
} AccountLoginStyle;

@interface LYAccountView : UIView

@property(nonatomic,copy) void (^accountLoginClick)(AccountLoginStyle style);

@end

NS_ASSUME_NONNULL_END
