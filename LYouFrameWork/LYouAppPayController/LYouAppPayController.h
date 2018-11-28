//
//  LYouAppPayController.h
//  LYouFrameWork
//  内购
//  Created by grx on 2018/11/28.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LY_AppPayResultBlock)(int code,NSString *reason);

@interface LYouAppPayController : NSObject

@property (nonatomic,copy) NSString *money;
@property (nonatomic,copy) NSString *orderId;
@property (nonatomic, copy) LY_AppPayResultBlock LYAppPayResultBlock;

+(instancetype)shared;
-(void)initInPay;
-(void)buy:(NSString *)productID;

@end

NS_ASSUME_NONNULL_END
