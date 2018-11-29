//
//  LYForgetPaswordController.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/29.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYFogetPswordController.h"
#import "LYForgetPsdView.h"

@interface LYFogetPswordController ()

@property(nonatomic,strong) LYForgetPsdView *forgetView;

@end

@implementation LYFogetPswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.forgetView];
    /** 创建登录窗口 */
 self.forgetView.sd_layout.centerYEqualToView(self.view).centerXEqualToView(self.view).widthIs(Main_Rotate_Width-80).heightIs(334);
     self.forgetView.backClick = ^(UIView *superView){
         [superView removeFromSuperview];
     };
     self.forgetView.sendSMSClick = ^(LYCountDownButton *sender){
         /** 开始倒计时 */
         sender.enabled = NO;
         [sender startWithSecond:4.0];
         [sender didChange:^NSString *(LYCountDownButton *countDownButton,int second) {
             [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             [sender setBackgroundColor:[UIColor lightGrayColor]];
             NSString *title = [NSString stringWithFormat:@"%ds",second];
             return title;
         }];
         [sender didFinished:^NSString *(LYCountDownButton *countDownButton, int second) {
             [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             [sender setBackgroundColor:ColorWithHexRGB(0x5C3BFE)];
             countDownButton.enabled = YES;
             return @"重新获取";
         }];
     };
    /** 完成 */
    self.forgetView.submitPassClick = ^(UIView * _Nonnull superView) {
        [superView removeFromSuperview];
    };
}

#pragma mark - initForgetViewUI
-(LYForgetPsdView *)forgetView{
    if (!_forgetView) {
        _forgetView = [[LYForgetPsdView alloc]init];
    }
    return _forgetView;
}

@end
