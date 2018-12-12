//
//  LYouAppPayController.m
//  LYouFrameWork
//
//  Created by grx on 2018/11/28.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouAppPayController.h"
#import "SVProgressHUD.h"
#import <StoreKit/StoreKit.h>
#import "LYouMD5Tool.h"

@interface LYouAppPayController ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>
@property (nonatomic,strong) NSArray * productsArray;
@property (nonatomic,strong) NSString * country;
@end

@implementation LYouAppPayController

#pragma mark - 初始化单例对象
+(instancetype)shared{
    static LYouAppPayController* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    }) ;
    return sharedInstance;
}

#pragma mark - 初始化APP内购
-(void)initInPay{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

-(void)buy:(NSString *)productID{
    NSString * string = productID;
    NSSet * LySet = [NSSet setWithObject:string];
    //发起查询商品是否存在
    SKProductsRequest * projectRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:LySet];
    projectRequest.delegate = self;
    [projectRequest start];
    [SVProgressHUD showWithStatus:@"请稍后"];
}

-(void)addTransactionObserverForInPay{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

#pragma mark 恢复
-(void)restoreCompletedTransactions{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

#pragma mark  ---------------------  SKProductsRequestDelegate  ---------
- (void)productsRequest:(nonnull SKProductsRequest *)request didReceiveResponse:(nonnull SKProductsResponse *)response {
    self.productsArray = response.products;
    if (self.productsArray.count > 0) {
        //发起购买操作
        SKPayment * payment = [SKPayment paymentWithProduct:response.products[0]];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }else{
        NSLog(@"无效商品列表 ：%@",response.invalidProductIdentifiers);
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"无法获取产品信息，购买失败"];
        if (self.LYAppPayResultBlock) {
            self.LYAppPayResultBlock(0, @"支付失败");
        }
        NSLog(@"无法获取产品信息，购买失败");
    }
}

#pragma mark - 查询不存在或网络通信失败等一系列查询失败
-(void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    if (self.LYAppPayResultBlock) {
        self.LYAppPayResultBlock(0, @"支付失败");
    }
    NSLog(@"查询失败：%@",[error localizedDescription]);
}

#pragma mark - 购买的结果，Ios会统一在下边的函数中反馈
- (void)paymentQueue:(nonnull SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions {
    for (SKPaymentTransaction * payTran in transactions) {
        //商品添加进列表
        if (payTran.transactionDate == SKPaymentTransactionStatePurchasing) {
            
        }
        //交易完成
        if(payTran.transactionState == SKPaymentTransactionStatePurchased){
            //发送购买凭证到服务器验证是否有效
            [self completeTransaction:payTran];
        }
        //已经购买过该商品
        if(payTran.transactionState == SKPaymentTransactionStateRestored){
            //完整结束此次在App Store的交易，没有这句代码的调用，下次购买会提示已经购买该商品
            [[SKPaymentQueue defaultQueue] finishTransaction:payTran];
            [self completeTransaction:payTran];
        }
        //交易失败
        if (payTran.transactionState == SKPaymentTransactionStateFailed) {
            [[SKPaymentQueue defaultQueue] finishTransaction:payTran];
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",@"交易失败"]];
            if (self.LYAppPayResultBlock) {
                self.LYAppPayResultBlock(0, @"支付失败");
                NSLog(@"%@",payTran.error);
            }
//            _isPaying = false;
        }
    }
}

#pragma mark - 交易成功，与服务器比对传输货单号
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSString *user = @"";
    if ([[LYouUserDefauleManager getIsTempUser] isEqualToString:@"1"]) {
        user = [LYouUserDefauleManager getTempName];
    }else{
        user = [LYouUserDefauleManager getUserName];
    }
    if ([user length] <= 1) {
        [SVProgressHUD showErrorWithStatus:@"请重新登录"];
        if (self.LYAppPayResultBlock) {
            self.LYAppPayResultBlock(0, @"支付失败");
        }
        return;
    }
    //目前苹果公司提倡的获取购买凭证的方法
    NSURL *recepitURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:recepitURL];
    if(!receiptData){
    }
    NSString *urlString = [NSString stringWithFormat:@"%@game/apicheckios",LY_URLPATH];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args =  [NSString stringWithFormat:@"receipt=%@&appkey=%@&banid=%@&token=%@&amt=%@&server_id=%@&cporder=%@&roleid=%@&goodsid=%@&custom=%@",[receiptData base64EncodedStringWithOptions:0],[LYouUserDefauleManager getAppkey],[LYouUserDefauleManager getBanid],[LYouUserDefauleManager getToken],self.money,self.serverId,self.orderId,self.roleid,self.proId,self.custom];

    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"从服务器获取到数据");
        [SVProgressHUD dismiss];
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
            if (dict) {
                if ([dict[@"isSuccess"] isEqualToString:@"1"]) {
                    if (self.LYAppPayResultBlock) {
                        self.LYAppPayResultBlock(1, @"支付成功");
                        //完整结束此次在App Store的交易，没有这句代码的调用，下次购买会提示已经购买该商品
                        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                    }
                }else{
                    if ([dict[@"isSuccess"] isEqualToString:@"2"]) {
                        //完整结束此次在App Store的交易，没有这句代码的调用，下次购买会提示已经购买该商品
                        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                    }
                    if (self.LYAppPayResultBlock) {
                        self.LYAppPayResultBlock(4, @"未通过验证");
                    }
                }
            }else{
                if (self.LYAppPayResultBlock) {
                    self.LYAppPayResultBlock(4, @"未通过验证");
                }
            }
        }else{
            if (self.LYAppPayResultBlock) {
                self.LYAppPayResultBlock(4, @"未通过验证");
            }
        }
    }];
    [sessionDataTask resume];
}

#pragma mark - 字典转json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - 获取当前语言
-(NSString*)currentLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLang = [languages objectAtIndex:0];
    return currentLang;
}


@end
