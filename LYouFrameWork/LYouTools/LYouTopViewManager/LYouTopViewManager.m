//
//  LYouTopViewManager.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouTopViewManager.h"

@implementation LYouTopViewManager

+(UIViewController *)topViewController {
    UIViewController *resultVC;
    
    resultVC = [LYouTopViewManager _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [LYouTopViewManager _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+(UIViewController *)_topViewController:(UIViewController *)vc{
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
