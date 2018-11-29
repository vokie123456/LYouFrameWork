//
//  UtilityFunction.h
//  HXTG
//
//  Created by grx on 2017/2/15.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UtilityFunction : NSObject

/*! Documents路径 */
+ (NSString *)documentsPath;

/*! Library/Caches路径 */
+ (NSString *)cachesPath;

/*! Library/Application Support路径 */
+ (NSString *)applicationSupportPath;

/*! 获取文本大小 */
+ (CGSize)getTextSizeWithOutLineSystemFont:(UIFont *)font ConstrainedToSize:(CGSize)size string:(NSString *)labelString;

/*! 文件夹路径，如果参数传入的文件夹不存在则创建 */
+ (NSString *)directoryPath:(NSString*)path;

/*! 判断移动电话号码 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/*! 判断电话号码 */
+ (BOOL)isTelephoneNumber:(NSString *)mobileNum;
/*! 判断邮箱 */
+ (BOOL)isValidateEmail:(NSString *)email;

/*! 判断身份证 */
+ (BOOL)validateIdNumber:(NSString *)value;

/*! 判断身份证 (严格) */
+ (BOOL)verifyIDCardNumber:(NSString *)value;

/*! 计算文字长度 */
+ (int)lengthOfStr:(NSString *)str;

/*! 过滤掉html标签 */
+ (NSString *)removeHTML:(NSString *)html;

/*! 判断账户名 */
+ (BOOL)validateUserName:(NSString *)name;

/*! 是否含特殊字符 */
+ (BOOL)validateUserNameSign:(NSString *)name;

/*! 判断密码 */
+ (BOOL)validatePassword:(NSString *)passWord;
/*! 用户密码验证 */
+ (BOOL) validateHxPassword:(NSString *)passWord;

/*! 判断银行卡号 */
+ (BOOL)validateBankId:(NSString *)BankId;

/*! 输入表情验证 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/*! 输入数字 */
+ (BOOL)validateNum:(NSString *)num;

/*! 手机唯一标示 */
+ (NSString *)responseUUID;

/*! 获取当前版本号 */
+(NSString *)gaintVersion;

/*! 手机系统版本 */
+(NSString *)gaintDeviceVersion;

/*! 设备名称 */
+(NSString *)gaintDeviceName;

/*! 设备名称 */
+ (NSString *)getParamValueFromUrl:(NSString *)url paramName:(NSString *)paramName;

/*! 护照 */
+ (BOOL)validatePassportCard:(NSString*)passportNum;

/*! 只包含文字和字母验证 */
+ (BOOL) validateText:(NSString *)passWord;

/*! 只包含文字和字母验证 仅可输入字母和数字（不可输入汉字和符号）长度为，长度为15、18、20 */
+ (BOOL)isNaShuiNumber:(NSString *)NaShuiNum;
/*! 判断是数字或者字母 */
+ (BOOL)isNumberWithLetter:(NSString *)text;
// 判断输入是否全是空格
+ (BOOL) isEmpty:(NSString *) str;
//数字转换万
+ (NSString *) changeWanHandle:(CGFloat )num;

@end
