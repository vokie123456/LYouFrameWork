//
//  LYUserCenterManager.m
//  LYouFrameWork
//
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYUserCenterManager.h"
#import "LY_UserViewController.h"
#define FubiaoWidth  50

@interface LYUserCenterManager()

@property(nonatomic,strong)UIButton *BuoyBtn;
@property(nonatomic,strong)LY_UserViewController *showUserVC;
@property(nonatomic,assign)BOOL isShowUserVC;

@end
@implementation LYUserCenterManager

+(instancetype)instance{
    static LYUserCenterManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(UIButton *)BuoyBtn{
    if (!_BuoyBtn) {
        _BuoyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _BuoyBtn.backgroundColor = [UIColor greenColor];
        _BuoyBtn.frame = CGRectMake(0, 100, FubiaoWidth, FubiaoWidth);
        UIPanGestureRecognizer *panGestureRecgnizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [_BuoyBtn addGestureRecognizer:panGestureRecgnizer];
        [_BuoyBtn addTarget:self action:@selector(FubiaoAction) forControlEvents:UIControlEventTouchUpInside];
        [_BuoyBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@biao",LY_ImagePath ]] forState:UIControlStateNormal];
        _BuoyBtn.layer.cornerRadius = _BuoyBtn.frame.size.width/2;
        _BuoyBtn.clipsToBounds = YES;
        _BuoyBtn.layer.borderWidth = 0;
    }
    return _BuoyBtn;
}

#pragma mark - 展示——浮标
-(void)showFuBiao{
    [[UIApplication sharedApplication].keyWindow addSubview:self.BuoyBtn];
    self.BuoyBtn.alpha = 0.5;
}
#pragma mark - 关闭——浮标
-(void)hideFuBiao{
    [self.BuoyBtn removeFromSuperview];
    self.showUserVC = [LY_UserViewController sharedUserVC];
    if (self.isShowUserVC) {
        [self.showUserVC.view removeFromSuperview];
        self.isShowUserVC = NO;
    }}
#pragma mark  点击浮标事件
-(void)FubiaoAction{
    UIViewController *topmostVC = [LYouTopViewManager topViewController];
    self.showUserVC = [LY_UserViewController sharedUserVC];
    if (self.isShowUserVC) {
        CGRect temp1 = self.showUserVC.view.frame;
        CGRect temp2 = temp1;
        temp2.origin.x = -240;
        [UIView animateWithDuration:0.7 animations:^{
            self.showUserVC.view.frame = temp2;
        } completion:^(BOOL finished) {
            [self.showUserVC.view removeFromSuperview];
        }];
        self.isShowUserVC = NO;
    }else{
        if (Main_Screen_Height == 812) {
            self.showUserVC.view.frame = CGRectMake(0, 35, Main_Screen_Width, Main_Screen_Height-70);
        }else{
            self.showUserVC.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
        }
        if (Main_Screen_Width == 812) {
            self.showUserVC.view.frame = CGRectMake(35, 0, Main_Screen_Width, Main_Screen_Height);
        }
        self.showUserVC.LY_ShowVC = topmostVC;
        CGRect temp1 = self.showUserVC.view.frame;
        CGRect temp2 = temp1;
        temp2.origin.x = temp2.origin.x - 240;
        self.showUserVC.view.frame = temp2;
        [topmostVC.view addSubview:self.showUserVC.view];
        [UIView animateWithDuration:0.7 animations:^{
            self.showUserVC.view.frame = temp1;
        }];
        self.isShowUserVC = YES;
    }
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    self.BuoyBtn.alpha = 1;
    CGPoint translation = [recognizer translationInView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
    CGFloat centerX=recognizer.view.center.x+ translation.x;
    CGFloat thecenter=0;
    recognizer.view.center=CGPointMake(centerX,
                                       recognizer.view.center.y+ translation.y);
    [recognizer setTranslation:CGPointZero inView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
    if(recognizer.state==UIGestureRecognizerStateEnded|| recognizer.state==UIGestureRecognizerStateCancelled) {
        if(centerX>Main_Screen_Width/2) {
            thecenter=Main_Screen_Width-FubiaoWidth/2;
        }else{
            thecenter=FubiaoWidth/2;
        }
        CGFloat centerY = recognizer.view.center.y+ translation.y;
        if (centerY < 50) {
            centerY = 50;
        }
        if (centerY > Main_Screen_Height - 50) {
            centerY = Main_Screen_Height - 50;
        }
        [UIView animateWithDuration:0.3 animations:^{
            recognizer.view.center=CGPointMake(thecenter,
                                               centerY);
            self.BuoyBtn.alpha = 0.5;
        }];
    }
}
#pragma mark  个人中心左滑事件
-(void)CloseFubiaoAction{
    self.showUserVC = [LY_UserViewController sharedUserVC];
    if (self.isShowUserVC) {
        CGRect temp1 = self.showUserVC.view.frame;
        CGRect temp2 = temp1;
        temp2.origin.x = -240;
        [UIView animateWithDuration:0.7 animations:^{
            self.showUserVC.view.frame = temp2;
        } completion:^(BOOL finished) {
            [self.showUserVC.view removeFromSuperview];
        }];
        self.isShowUserVC = NO;
    }
}
-(void)closedUserCenter{
    self.isShowUserVC = NO;
}
-(void)QuitGame{
    if (self.quitBlock) {
        self.quitBlock(@"QuitGame");
    }
}

@end
