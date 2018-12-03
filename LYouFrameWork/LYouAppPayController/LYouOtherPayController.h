//
//  LYouOtherPayController.h
//  LYouFrameWork
//  第三方支付
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LY_AppleResultBlock)(int code,NSString *reason);

@interface LYouOtherPayController : UIViewController
@property (nonatomic, strong) LY_AppleResultBlock TT_AppleResultBlock;

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *orderId;

@end

NS_ASSUME_NONNULL_END
