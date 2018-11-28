//
//  LYouLoginController.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouLoginController.h"
#import "LYAccountView.h"
#import "SDAutoLayout.h"

@interface LYouLoginController ()

@property(nonatomic,strong)LYAccountView *accountView;

@end

@implementation LYouLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.accountView];
    self.accountView.sd_layout.centerYEqualToView(self.view).centerXEqualToView(self.view).widthIs(Main_Rotate_Width-80).heightIs(Main_Rotate_Height/2.5);
}

-(LYAccountView *)accountView{
    if (!_accountView) {
        _accountView = [[LYAccountView alloc]init];
    }
    return _accountView;
}

@end
