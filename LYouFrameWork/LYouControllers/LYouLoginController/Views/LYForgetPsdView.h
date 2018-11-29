//
//  LYForgetPsdView.h
//  LYouFrameWork
//
//  Created by grx on 2018/11/29.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYCountDownButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYForgetPsdView : UIView

@property(nonatomic,copy) void (^backClick)(UIView *superView);
@property(nonatomic,copy) void (^sendSMSClick)(LYCountDownButton *sender);
@property(nonatomic,copy) void (^submitPassClick)(UIView *superView);
@property(nonatomic,strong) LYCountDownButton *button;
@property(nonatomic,strong) UIButton *checkPsdBtn;

@end

NS_ASSUME_NONNULL_END
