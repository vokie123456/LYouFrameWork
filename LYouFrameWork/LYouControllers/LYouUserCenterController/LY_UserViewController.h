//
//  LY_UserViewController.h
//  LYouFrameWork
//
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LY_UserViewController : UIViewController
+(instancetype)sharedUserVC;
@property(nonatomic,strong) UIViewController *LY_ShowVC;

@end

NS_ASSUME_NONNULL_END
