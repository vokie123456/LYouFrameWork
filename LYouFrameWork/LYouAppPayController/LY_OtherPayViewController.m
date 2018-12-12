//
//  HXH_Apple1ViewController.m
//  LeYouGamesSDK
//
//  Created by 王树超 on 2018/5/16.
//  Copyright © 2018年 Mr.li. All rights reserved.
//

#import "LY_OtherPayViewController.h"


#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>
- (void)SHUCH:(NSString *)TEMP;
@end

@interface LY_OtherPayViewController ()<UIWebViewDelegate,JSObjcDelegate>
@property (weak, nonatomic) IBOutlet UIView *BGView;

@property (nonatomic, strong) JSContext *jsContext;
@property (strong, nonatomic) UIWebView *webView;
@property(nonatomic,strong)UIButton *closeBtn;

@property(nonatomic,copy)NSString *string1;
@property(nonatomic,copy)NSString *string2;
@property(nonatomic,copy)NSString *string3;

@end

@implementation LY_OtherPayViewController
+(instancetype)shared{
    static LY_OtherPayViewController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       instance = [[LY_OtherPayViewController alloc] initWithNibName:@"images.bundle/LY_OtherPayViewController" bundle:[NSBundle mainBundle]];
    });
    return instance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadWebView];
}
-(void)initUI{
    NSString *user = @"";
    if ([[LYouUserDefauleManager getIsTempUser] isEqualToString:@"1"]) {
        user = [LYouUserDefauleManager getTempName];
    }else{
        user = [LYouUserDefauleManager getUserName];
    }
    if ([user length] <= 1) {
        [SVProgressHUD showErrorWithStatus:@"请重新登录再试"];
        [self remove];
        return;
    }
    NSString *ccurlStr = [NSString stringWithFormat:@"%@",[LYouNetWorkManager instance].ccurl];
    NSString *tempStr = ccurlStr;
    
    //    NSString *tempStr =[JoDes decode:ccurlStr key:DESKEY];
    if (tempStr.length<1) {
        [SVProgressHUD showErrorWithStatus:@"请重新启动再试"];
        [self remove];
        return;
    }
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.BGView.bounds.size.width, self.BGView.bounds.size.height)];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.layer.masksToBounds = YES;
    self.webView.layer.cornerRadius = 5;
    [self.BGView addSubview:self.webView];
}
-(void)loadWebView{
    
    NSString *user = @"";
    if ([[LYouUserDefauleManager getIsTempUser] isEqualToString:@"1"]) {
        user = [LYouUserDefauleManager getTempName];
    }else{
        user = [LYouUserDefauleManager getUserName];
    }
    if ([user length] <= 1) {
        [SVProgressHUD showErrorWithStatus:@"请重新登录再试"];
        [self remove];
        return;
    }
    NSString *ccurlStr = [NSString stringWithFormat:@"%@",[LYouNetWorkManager instance].ccurl];
    NSString *tempStr = ccurlStr;

//    NSString *tempStr =[JoDes decode:ccurlStr key:DESKEY];
    if (tempStr.length<1) {
        [SVProgressHUD showErrorWithStatus:@"请重新启动再试"];
        [self remove];
        return;
    }
    NSString *urlString =  [NSString stringWithFormat:@"%@?appkey=%@&banid=%@&token=%@&amt=%@&server_id=%@&cporder=%@&roleid=%@&goodsid=%@&custom=%@",tempStr,[LYouUserDefauleManager getAppkey],[LYouUserDefauleManager getBanid],[LYouUserDefauleManager getToken],self.money,self.serverId,self.orderId,self.roleid,self.proId,self.custom];
    
    NSString* encodedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:encodedString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
#pragma mark - JSObjcDelegate
- (void)SHUCH:(NSString *)TEMP{
    if([TEMP isEqualToString:@"success"]){
        if (self.ly_AppleResultBlock) {
            self.ly_AppleResultBlock(1,@"支付成功");
        }
    }else if([TEMP isEqualToString:@"error"]){
        if (self.ly_AppleResultBlock) {
            self.ly_AppleResultBlock(0,@"支付失败");
        }
    }else if([TEMP isEqualToString:@"shutdown"]){
        if (self.ly_AppleResultBlock) {
            self.ly_AppleResultBlock(2, @"用户取消");
        }
    }
    [self performSelectorOnMainThread:@selector(remove) withObject:nil waitUntilDone:NO];
}
-(void)remove{
    [self  performSelector:@selector(close) withObject:nil afterDelay:0.5f];
}
-(void)close{
     [self.view removeFromSuperview];
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"ocObj"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
        };
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* reqUrl = request.URL.absoluteString;
    
    if ([reqUrl hasPrefix:@"weixin://"]) {
        /** 微信支付 */
        BOOL bSucc = [[UIApplication sharedApplication]openURL:request.URL];
    }
    if ([reqUrl hasPrefix:@"https://openapi.alipay.com"]) {
        BOOL bSucc = [[UIApplication sharedApplication]openURL:request.URL];
    }
    
    NSLog(@"--->reqUrl:%@",reqUrl);
    if (reqUrl && [reqUrl containsString:@"iosreturn_url.php"]) {
        [self SHUCH:@"success"];
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

