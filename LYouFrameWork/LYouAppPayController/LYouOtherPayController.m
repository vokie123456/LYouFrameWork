//
//  LYouOtherPayController.m
//  LYouFrameWork
//
//  Created by grx on 2018/12/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouOtherPayController.h"
#import <WebKit/WebKit.h>

@interface LYouOtherPayController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,strong) UIView *bgView;
@property (strong, nonatomic) WKWebView *wkWebView;

@end

@implementation LYouOtherPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"name=====%@===money====%@==orderId===%@",self.name,self.money,self.orderId);
    /** 背景图 */
    self.bgView = [UIView new];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.backgroundColor = ColorWithHexRGB(0xEAEAEA);
    [self.view addSubview:self.bgView];
    self.bgView.sd_layout.centerYEqualToView(self.view).centerXEqualToView(self.view).widthIs(Main_Rotate_Width-80).heightIs(300);
    [self creatWKWebView:self.bgView];
    
}

/** 创建充值页面 */
-(void)creatWKWebView:(UIView *)superView{
    self.wkWebView = [WKWebView new];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    self.wkWebView.layer.masksToBounds = YES;
    self.wkWebView.layer.cornerRadius = 5;
    self.wkWebView.scrollView.showsVerticalScrollIndicator = NO;
    [superView addSubview:self.wkWebView];
    self.wkWebView.sd_layout.leftSpaceToView(superView, 0).rightSpaceToView(superView, 0).topSpaceToView(superView, 0).heightIs(300);
    /** 获取 */
    NSString *user = @"123";
//    if ([[LYouUserDefauleManager getIsTempUser] isEqualToString:@"1"]) {
//        user = [LYouUserDefauleManager getTempName];
//    }else{
//        user = [LYouUserDefauleManager getUserName];
//    }
//    if ([user length] <= 1) {
//        [SVProgressHUD showErrorWithStatus:@"请重新登录再试"];
////        [self remove];
//        return;
//    }
//    /** 获取tempStr */
    NSString *tempStr = @"https://sdkpaylist.lygames.cc/index.php?m=admin&c=zfh5&a=zf";
//    NSString *tempStr = [JoDes decode:[LYouNetWorkManager instance].ccurl key:DESKEY];
//    if (tempStr.length<1) {
//        [SVProgressHUD showErrorWithStatus:@"请重新启动再试"];
////        [self remove];
//        return;
//    }
    NSString *urlString =  [NSString stringWithFormat:@"%@&uid=%@&bundleID=%@&productID=12345678&price=%@&value=%@&game_trade_no=%@",tempStr,user,[LYouUserDefauleManager getAppkey],self.money,self.name,self.orderId];
    NSString* encodedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:encodedString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
    
}

#pragma mark --- WKWKNavigationDelegate
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {

}
//
////加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
//    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];

}
//
////加载完成
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    // 获取完整url并进行UTF-8转码
////    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
////    NSLog(@"strRequest:%@",strRequest);
////
////    decisionHandler(WKNavigationActionPolicyAllow);
//}
//
////加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {

}
//#pragma mark --- 懒加载
//- (WKWebViewConfiguration *)wkConfig {
//    if (!_wkConfig) {
//        _wkConfig = [[WKWebViewConfiguration alloc] init];
//        _wkConfig.allowsInlineMediaPlayback = YES;
//        _wkConfig.allowsPictureInPictureMediaPlayback = YES;
//    }
//    return _wkConfig;
//}


@end
