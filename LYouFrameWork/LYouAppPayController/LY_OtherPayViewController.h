//
//  HXH_Apple1ViewController.h
//  LeYouGamesSDK
//
//  Created by 王树超 on 2018/5/16.
//  Copyright © 2018年 Mr.li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LY_OtherPayViewController : UIViewController
typedef void(^LY_AppleResultBlock)(int code,NSString *reason);

@property (nonatomic,copy) NSString *proId;
@property (nonatomic,copy) NSString *serverId;
@property (nonatomic,copy) NSString *roleid;
@property (nonatomic,copy) NSString *custom;
@property (nonatomic,copy) NSString *money;
@property (nonatomic,copy) NSString *orderId;

@property (nonatomic, strong) LY_AppleResultBlock ly_AppleResultBlock;

+(instancetype)shared;
@end
