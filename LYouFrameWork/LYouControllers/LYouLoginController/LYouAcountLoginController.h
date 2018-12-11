//
//  LYouAcountLoginController.h
//  LYouFrameWork
//  账号登录页面
//  Created by grx on 2018/11/29.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LoginBlock)(int style,NSString *token);

@interface LYouAcountLoginController : UIViewController

+(instancetype)sharedVC;
-(void)cheakCurrentAcount;
@property (nonatomic, copy) LoginBlock loginBlock;

@end

NS_ASSUME_NONNULL_END
