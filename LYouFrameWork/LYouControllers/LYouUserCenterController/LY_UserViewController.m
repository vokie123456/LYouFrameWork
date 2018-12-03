//
//  LY_UserViewController.m
//  LYouFrameWork
//
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LY_UserViewController.h"
#import "LYUserCenterManager.h"

@interface LY_UserViewController ()

@end

@implementation LY_UserViewController

+(instancetype)sharedUserVC{
    static LY_UserViewController *instence = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       instence = [[LY_UserViewController alloc] init];
    });
    return instence;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self creatUI];
}

-(void)creatUI{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
//    if (![self.TT_mainView.layer containsPoint:point]) {
        [[LYUserCenterManager instance] CloseFubiaoAction];
//    }
}


@end
