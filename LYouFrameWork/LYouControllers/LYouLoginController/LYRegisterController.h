//
//  LYRegisterController.h
//  LYouFrameWork
//  注册页面
//  Created by grx on 2018/11/29.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYRegisterController : UIViewController

@property(nonatomic,copy) void (^registSuccess)(void);

@end

NS_ASSUME_NONNULL_END
