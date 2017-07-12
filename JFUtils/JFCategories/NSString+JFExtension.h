//
//  NSString+JFExtension.h
//  CJF
//
//  Created by cjf on 2017/5/9.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JFExtension)

/**
 CJF - 随机字符串 [高效费舍尔茨洗牌]

 @return 字符串
 */
+ (NSString *)randomString;

/**
 CJF - 将 json格式的字符串 转换成 字典
 
 @param jsonString JSON格式的字符串
 @return 字典
 */
+ (nullable NSDictionary *)toDictionaryWithJsonString:(NSString *)jsonString;

/**
 CJF - 将 中文字符串 转换成 汉语拼音

 @param chinese 中文字符串
 @return 汉语拼音
 */
+ (nullable NSString *)toPinyinWithChinese: (NSString *)chinese;

/**
 CJF - 获取当前时间的时间戳
 
 @return 字符串类型的时间戳
 */
+ (nullable NSString *)getCurrentTimestamp;

@end


@interface NSString (JFValidate)

/**
 CJF - 输入正则表达式 匹配 字符串
 
 @param regExpx 正则表达式
 
 @return YES or NO
 */
- (BOOL)isValidateWithRegExp: (NSString *)regExpx;

/**
 CJF - 验证有效的手机号码
 
 @return YES or NO
 */
- (BOOL)isValidateMobileNumber;

/**
 CJF - 验证有效的真实姓名
 
 @return YES or NO
 */
- (BOOL)isValidateRealName;

/**
 CJF - 验证有效的验证码(可根据自家的验证码位数进行修改方法的实现)
 默认是4位纯数字
 
 @return YES or NO
 */
- (BOOL)isValidateVerifyCode;

/**
 CJF - 验证有效的银行卡号
 
 @return YES or NO
 */
- (BOOL)isValidateBankCardNumber;

/**
 CJF - 验证有效的邮箱
 
 @return YES or NO
 */
- (BOOL)isValidateEmail;

/**
 CJF - 验证有效的字母数字密码
 
 @return YES or NO
 */
- (BOOL)isValidateAlphaNumberPassword;

/**
 CJF - 验证有效的15位身份证
 
 @return YES or NO
 */
- (BOOL)isValidateIdentifyFifteen;

/**
 CJF - 验证有效的18位身份证
 
 @return YES or NO
 */
- (BOOL)isValidateIdentifyEighteen;

/**
 CJF - 验证有效的身份证号码

 @return YES or NO
 */
- (BOOL)isIDCardNumber;

/**
 CJF - 验证纯数字
 
 @return YES or NO
 */
- (BOOL)isOnlyNumber;

/**
 CJF - 验证纯中文
 
 @return YES or NO
 */
- (BOOL)isOnlyChinese;

@end


@interface NSString (JFFormat)

/**
 CJF - 格式化：手机号码的显示 188 8888 8888
 18688888888 => 186 8888 8888

 @return 手机号码
 */
- (nullable NSString *)formatMobileNumber;

/**
 CJF - 格式化：隐藏手机号码中间4位 188 **** 8888
 18688888888 => 186****8888

 @return 手机号码
 */
- (nullable NSString *)formatSecrectMobileNumber;

/**
 CJF - 格式化：银行卡号中间8位显示

 @return 银行卡号
 */
- (nullable NSString *)formatSecrectCreditCardNumber;

/**
 CJF - 身份证号码显示两边4位 4409** ******** 8888

 @return 身份证号码
 */
- (nullable NSString *)formatSecrectIDCardNumber;

/**
 CJF - 去除所有空格

 @return 无空格字符串
 */
- (nullable NSString *)removeAllBlankSpace;

@end


@interface NSString (JFCalculate)

/**
 CJF - 根据 字体大小、显示区域宽度、行距 计算文字高度

 @param font 字体
 @param lineSpacing 行距
 @param width 显示区域宽度
 @return 高度
 */
- (CGFloat)heightWithFont:(UIFont *)font lineSpacing: (CGFloat)lineSpacing width:(CGFloat)width;

@end


@interface NSString (JFTime)

/**
 CJF - 通过时间戳计算与当前的时间差
 显示：1小时前、2天前、2分钟前

 @param compareDate 需要计算的时间
 @return 时间差
 */
+ (nullable NSString *)compareCurrentTime: (NSTimeInterval)compareDate;

/**
 CJF - 通过时间戳得出显示时间
 176368532 => *年*月*日

 @param timestamp 时间戳
 @return 时间
 */
+ (nullable NSString *)getDateStringWithTimestamp: (NSTimeInterval)timestamp;

/**
 CJF - 通过时间戳和格式显示时间

 @param timestamp 时间戳
 @param formatter 时间显示格式
 @return 时间
 */
+ (nullable NSString *)getStringWithTimestamp: (NSTimeInterval)timestamp formatter: (NSString *)formatter;

@end


@interface NSString (JFEncryption)

/**
 CJF - MD5加密 字符串

 @return 加密后的字符串
 */
- (nullable NSString *)md5;

/**
 CJF - base64加密 字符串

 @return 加密后的字符串
 */
- (nullable NSString *)base64;

@end



@interface NSString (JFDevice)

/**
 CJF - 获取BundleId
 
 @return BundleId
 */
+ (NSString *)getBundleId;

/**
 CJF - 获取Bundle版本号
 
 @return BundleVersion
 */
+ (NSString *)getBundleVersion;

/**
 CJF - 获取App名字
 
 @return AppName
 */
+ (NSString *)getAppName;

/**
 CJF - 获取Build版本号
 
 @return BuildVersion
 */
+ (NSString *)getBuildVersion;

/**
 CJF - 获取设备版本号
 
 @return e.g. iPhone 5S
 */
+ (NSString *)getDeviceVersion;

/**
 CJF - 获取设备名称
 
 @return 名称
 */
+ (NSString *)getDeviceName;

/**
 CJF - 获取设备电量
 
 @return 电量
 */
+ (NSInteger)getDeviceBatteryLevel;

/**
 CJF - 获取设备模式
 
 @return 模式
 */
+ (NSString *)getDeviceModel;

/**
 CJF - 获取设备本地模式
 
 @return 模式
 */
+ (NSString *)getDeviceLocalizeModel;

/**
 CJF - 获取设备当前系统名称
 
 @return 系统名称
 */
+ (NSString *)getDeviceSystemName;

/**
 CJF - 获取设备当前系统版本
 
 @return 版本
 */
+ (NSString *)getDeviceSystemVersion;

/**
 CJF - 获取设备广告标识
 
 @return 标识
 */
+ (NSString *)getDeviceIDFA;

/**
 CJF - 获取设备IDFV标识
 
 @return IDFV
 */
+ (NSString *)getDeviceIDFV;

/**
 CJF - 获取设备当前语言
 
 @return 语言
 */
+ (NSString *)getDeviceLanguage;

/**
 CJF - 获取设备当前国家
 
 @return 国家
 */
+ (NSString *)getDeviceCountry;

/**
 CJF - 获取设备总内存大小
 
 @return 内存大小
 */
+ (NSInteger)getDeviceTotalMemorySize;

/**
 CJF - 获取运营商名称
 
 @return 名称
 */
+ (NSString *)getDeviceCarrierName;

/**
 CJF - 获取wifi的名称
 
 @return 名称
 */
+ (NSString *)getWifiName;

/**
 CJF - 获取内网IP地址
 注意：此方法通用，无论是wifi还是流量都能获取到IP地址
 
 @param preferIPv4 是否为IPv4网络
 @return ip地址
 */
+ (NSString *)getIPAddressOfInsideNetwork: (BOOL)preferIPv4;

/**
 CJF - 获取外网IP地址

 @return ip地址
 */
+ (NSString *)getIPAddressOfOutsideNetwork;

@end

NS_ASSUME_NONNULL_END




