//
//  LYouTopViewManager.h
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYouTopViewManager : NSObject

+(UIViewController *)topViewController;
+(UIViewController *)_topViewController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
