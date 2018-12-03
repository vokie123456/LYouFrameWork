//
//  LYUserCenterManager.h
//  LYouFrameWork
//
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LY_QuitBlock)(NSString *message);

@interface LYUserCenterManager : NSObject

@property(nonatomic,copy)LY_QuitBlock quitBlock;
+(instancetype)instance;

#pragma mark - 展示浮标
-(void)showFuBiao;
#pragma mark - 移除浮标
-(void)hideFuBiao;
-(void)CloseFubiaoAction;


-(void)closedUserCenter;
-(void)QuitGame;

@end

NS_ASSUME_NONNULL_END
