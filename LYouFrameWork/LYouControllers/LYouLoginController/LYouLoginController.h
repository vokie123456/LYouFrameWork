//
//  LYouLoginController.h
//  LYouFrameWork
//  游客/账户选择页面
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYouLoginController : UIViewController
typedef void(^LoginBlock)(int style,NSString *token);

+(instancetype)sharedVC;
@property (nonatomic, copy) LoginBlock loginBlock;
@property(nonatomic,strong) UIButton *accountLoginBtn;

@end

NS_ASSUME_NONNULL_END
