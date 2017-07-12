//
//  NSString+JFExtension.m
//  CJF
//
//  Created by cjf on 2017/5/9.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "NSString+JFExtension.h"

#import <CommonCrypto/CommonDigest.h>
#import "NSData+JFExtension.h"

#import "sys/utsname.h"
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

@implementation NSString (JFExtension)

+ (NSString *)randomString {
    
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    
    NSUInteger numberOfCharacters = [alphabet length];
    unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
    [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];
    
    for (NSUInteger i = 0; i < numberOfCharacters; ++i) {
        NSUInteger j = (arc4random_uniform((uint32_t)(numberOfCharacters - i)) + i);
        unichar c = characters[i];
        characters[i] = characters[j];
        characters[j] = c;
    }
    
    NSString *result = [NSString stringWithCharacters:characters length:numberOfCharacters];
    free(characters);
    return result;
}

+ (NSDictionary *)toDictionaryWithJsonString: (NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

+ (NSString *)toPinyinWithChinese:(NSString *)chinese {
    
    if ([chinese isEqualToString:@""]) {
        return chinese;
    }
    
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    
    if ([[(NSString *)pinyin substringToIndex:1] compare:@"长"] == NSOrderedSame) {
        
        [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    
    if ([[(NSString *)pinyin substringToIndex:1] compare:@"沈"] == NSOrderedSame) {
        
        [pinyin replaceCharactersInRange:NSMakeRange(0, 4)withString:@"shen"];
    }
    
    if ([[(NSString *)pinyin substringToIndex:1] compare:@"厦"] == NSOrderedSame) {

        [pinyin replaceCharactersInRange:NSMakeRange(0, 3)withString:@"xia"];
    }
    
    if ([[(NSString *)pinyin substringToIndex:1] compare:@"地"] == NSOrderedSame) {
        
        [pinyin replaceCharactersInRange:NSMakeRange(0, 3)withString:@"di"];
    }
    
    if ([[(NSString *)pinyin substringToIndex:1] compare:@"重"] == NSOrderedSame) {
        
        [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    
    //返回最近结果
    return pinyin;
}

+ (NSString *)getCurrentTimestamp {
    
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a]; // 转为字符型
    
    return timeString;
}

@end

#pragma mark - Validation

@implementation NSString (JFValidate)

- (BOOL)isValidateWithRegExp:(NSString *)regExpx {
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", regExpx];
    return [predicate evaluateWithObject: self];
}

- (BOOL)isValidateMobileNumber {
    
    NSString * const MOBILE = @"^1(3|4|5|7|8)\\d{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidateRealName {
    
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidateVerifyCode {
    
    NSString *pattern = @"^[0-9]{4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidateBankCardNumber {
    
    NSString * const BANKCARD = @"^(\\d{16}|\\d{19})$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", BANKCARD];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidateEmail {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidateAlphaNumberPassword {
    
    NSString *regex = @"^(?!\\d+$|[a-zA-Z]+$)\\w{6,12}$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [identityCardPredicate evaluateWithObject:self];
}

- (BOOL)isValidateIdentifyFifteen {
    
    NSString *identifyTest = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSPredicate *identifyPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",identifyTest];
    return [identifyPredicate evaluateWithObject:self];
}

- (BOOL)isValidateIdentifyEighteen {
    
    NSString *identifyTest = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate *identifyPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",identifyTest];
    return [identifyPredicate evaluateWithObject:self];
}

- (BOOL)isIDCardNumber {
    
    if (self.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

- (BOOL)isOnlyNumber {
    
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < self.length) {
        NSString *string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (BOOL)isOnlyChinese {
    
    NSString *chineseTest = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate *chinesePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseTest];
    return [chinesePredicate evaluateWithObject:self];
}

@end

#pragma mark - Format

@implementation NSString (JFFormat)

- (NSString *)formatMobileNumber {
    
    if ([self isValidateMobileNumber]) {
        
        NSMutableString *value = [[NSMutableString alloc] initWithString:self];
        [value insertString:@" " atIndex:3];
        [value insertString:@" " atIndex:8];
        return value;
    }
    return nil;
}

- (NSString *)formatSecrectMobileNumber {
    
    NSMutableString *newStr = [NSMutableString stringWithString:self];
    NSRange range = NSMakeRange(3, 4);
    [newStr replaceCharactersInRange:range withString:@"****"];
    return newStr;
}

- (NSString *)formatSecrectCreditCardNumber {
    
    NSMutableString *newStr = [NSMutableString stringWithString:self];
    NSRange range = NSMakeRange(4, 8);
    if (newStr.length > 12) {
        [newStr replaceCharactersInRange:range withString:@" **** **** "];
    }
    return newStr;
}

- (NSString *)formatSecrectIDCardNumber {
    
    if (![self isIDCardNumber]) {
        return nil;
    }
    
    NSMutableString *newStr = [NSMutableString stringWithString:self];
    NSRange range;
    if (newStr.length == 15) {
        
        range = NSMakeRange(3, 11);
        [newStr replaceCharactersInRange:range withString:@"*********"];
    }
    else if (newStr.length == 18) {
        
        range = NSMakeRange(3, 14);
        [newStr replaceCharactersInRange:range withString:@"************"];
    }
    else {
        
    }
    return newStr;
}

- (NSString *)removeAllBlankSpace {
    
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end

#pragma mark - Calculate

@implementation NSString (JFCalculate)

- (CGFloat)heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width {
    
    if (self.length != 0) {
        
        // 获取文字的CGSize
        CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        
        // 计算出文字行数
        CGFloat lineCount = size.height / font.lineHeight;
        
        // 设置descriptionLabel的行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpacing];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
        
        return size.height + lineCount * lineSpacing;
    }
    
    return 20;
}

@end

#pragma mark - Time

@implementation NSString (JFTime)

+ (NSString *)compareCurrentTime: (NSTimeInterval)compareDate {
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:compareDate/1000];
    NSTimeInterval timeInterval = [confromTimesp timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *referenceComponents = [calendar components:unitFlags fromDate:confromTimesp];
    //    NSInteger referenceYear  = referenceComponents.year;
    //    NSInteger referenceMonth = referenceComponents.month;
    //    NSInteger referenceDay   = referenceComponents.day;
    NSInteger referenceHour = referenceComponents.hour;
    //    NSInteger referemceMinute = referenceComponents.minute;
    
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp= timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = timeInterval/3600) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if ((temp = timeInterval/3600/24)==1)
    {
        result = [NSString stringWithFormat:@"昨天%ld时",(long)referenceHour];
    }
    else if ((temp = timeInterval/3600/24)==2)
    {
        result = [NSString stringWithFormat:@"前天%ld时",(long)referenceHour];
    }
    else if((temp = timeInterval/3600/24) <31){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = timeInterval/3600/24/30) <12){
        result = [NSString stringWithFormat:@"%ld个月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}

+ (NSString *)getDateStringWithTimestamp: (NSTimeInterval)timestamp {
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *referenceComponents = [calendar components:unitFlags fromDate:confromTimesp];
    NSInteger referenceYear  = referenceComponents.year;
    NSInteger referenceMonth = referenceComponents.month;
    NSInteger referenceDay   = referenceComponents.day;
    return [NSString stringWithFormat:@"%ld年%ld月%ld日",(long)referenceYear,(long)referenceMonth,(long)referenceDay];
}

+ (NSString *)getStringWithTimestamp: (NSTimeInterval)timestamp formatter:(NSString*)formatter {
    
    if ([NSString stringWithFormat:@"%@", @(timestamp)].length == 13) {
        timestamp /= 1000.0f;
    }
    
    NSDate *timestampDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *strDate = [dateFormatter stringFromDate:timestampDate];
    
    return strDate;
}

@end

#pragma mark - Encryption

@implementation NSString (JFEncryption)
// #import <CommonCrypto/CommonDigest.h>

- (NSString *)md5 {
    
    if(self == nil || [self length] == 0) {
        return nil;
    }
    
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

- (NSString *)base64 {
    
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64]; // 需要引入 NSData+JFEncryption.h
}

@end


@implementation NSString (JFDevice)

+ (NSString *)getBundleId {
    
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

+ (NSString *)getBundleVersion {
    
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAppName {
    
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

+ (NSString *)getBuildVersion {
    
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

/**
 获取设备版本
 
 @return e.g. iPhone 5S
 */
+ (NSString *)getDeviceVersion {
    
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    // iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"]) { return @"iPhone 1G";}
    if ([deviceString isEqualToString:@"iPhone1,2"]) { return @"iPhone 3G";}
    if ([deviceString isEqualToString:@"iPhone2,1"]) { return @"iPhone 3GS";}
    if ([deviceString isEqualToString:@"iPhone3,1"]) { return @"iPhone 4";}
    if ([deviceString isEqualToString:@"iPhone3,2"]) { return @"Verizon iPhone 4";}
    if ([deviceString isEqualToString:@"iPhone4,1"]) { return @"iPhone 4S";}
    if ([deviceString isEqualToString:@"iPhone5,1"]) { return @"iPhone 5";}
    if ([deviceString isEqualToString:@"iPhone5,2"]) { return @"iPhone 5";}
    if ([deviceString isEqualToString:@"iPhone5,3"]) { return @"iPhone 5C";}
    if ([deviceString isEqualToString:@"iPhone5,4"]) { return @"iPhone 5C";}
    if ([deviceString isEqualToString:@"iPhone6,1"]) { return @"iPhone 5S";}
    if ([deviceString isEqualToString:@"iPhone6,2"]) { return @"iPhone 5S";}
    if ([deviceString isEqualToString:@"iPhone7,1"]) { return @"iPhone 6 Plus";}
    if ([deviceString isEqualToString:@"iPhone7,2"]) { return @"iPhone 6";}
    if ([deviceString isEqualToString:@"iPhone8,1"]) { return @"iPhone 6s";}
    if ([deviceString isEqualToString:@"iPhone8,2"]) { return @"iPhone 6s Plus";}
    
    // iPod
    if ([deviceString isEqualToString:@"iPod1,1"])   { return @"iPod Touch 1G";}
    if ([deviceString isEqualToString:@"iPod2,1"])   { return @"iPod Touch 2G";}
    if ([deviceString isEqualToString:@"iPod3,1"])   { return @"iPod Touch 3G";}
    if ([deviceString isEqualToString:@"iPod4,1"])   { return @"iPod Touch 4G";}
    if ([deviceString isEqualToString:@"iPod5,1"])   { return @"iPod Touch 5G";}
    
    // iPad
    if ([deviceString isEqualToString:@"iPad1,1"])   { return @"iPad";}
    if ([deviceString isEqualToString:@"iPad2,1"])   { return @"iPad 2 (WiFi)";}
    if ([deviceString isEqualToString:@"iPad2,2"])   { return @"iPad 2 (GSM)";}
    if ([deviceString isEqualToString:@"iPad2,3"])   { return @"iPad 2 (CDMA)";}
    if ([deviceString isEqualToString:@"iPad2,4"])   { return @"iPad 2 (32nm)";}
    if ([deviceString isEqualToString:@"iPad2,5"])   { return @"iPad mini (WiFi)";}
    if ([deviceString isEqualToString:@"iPad2,6"])   { return @"iPad mini (GSM)";}
    if ([deviceString isEqualToString:@"iPad2,7"])   { return @"iPad mini (CDMA)";}
    
    if ([deviceString isEqualToString:@"iPad3,1"])   { return @"iPad 3(WiFi)";}
    if ([deviceString isEqualToString:@"iPad3,2"])   { return @"iPad 3(CDMA)";}
    if ([deviceString isEqualToString:@"iPad3,3"])   { return @"iPad 3(4G)";}
    if ([deviceString isEqualToString:@"iPad3,4"])   { return @"iPad 4 (WiFi)";}
    if ([deviceString isEqualToString:@"iPad3,5"])   { return @"iPad 4 (4G)";}
    if ([deviceString isEqualToString:@"iPad3,6"])   { return @"iPad 4 (CDMA)";}
    
    if ([deviceString isEqualToString:@"iPad4,1"])   { return @"iPad Air";}
    if ([deviceString isEqualToString:@"iPad4,2"])   { return @"iPad Air";}
    if ([deviceString isEqualToString:@"iPad4,3"])   { return @"iPad Air";}
    if ([deviceString isEqualToString:@"iPad5,3"])   { return @"iPad Air 2";}
    if ([deviceString isEqualToString:@"iPad5,4"])   { return @"iPad Air 2";}
    if ([deviceString isEqualToString:@"i386"])      { return @"Simulator";}
    if ([deviceString isEqualToString:@"x86_64"])    { return @"Simulator";}
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])   { return @"iPad mini 2";}
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])   { return @"iPad mini 3";}
    
    return deviceString;
}

+ (NSString *)getDeviceName {
    return [UIDevice currentDevice].name;
}

+ (NSInteger)getDeviceBatteryLevel {
    return [[UIDevice currentDevice] batteryLevel];
}

+ (NSString *)getDeviceModel {
    return [UIDevice currentDevice].model;
}

+ (NSString *)getDeviceLocalizeModel {
    return [UIDevice currentDevice].localizedModel;
}

+ (NSString *)getDeviceSystemName {
    return [UIDevice currentDevice].systemName;
}

+ (NSString *)getDeviceSystemVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)getDeviceIDFA {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)getDeviceIDFV {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

+ (NSString *)getDeviceLanguage {
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = [languageArray objectAtIndex:0];
    return language;
}

+ (NSString *)getDeviceCountry {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *country = [locale localeIdentifier];
    return country;
}

+ (NSInteger)getDeviceTotalMemorySize {
    return (NSInteger)[NSProcessInfo processInfo].physicalMemory;
}

+ (NSString *)getDeviceCarrierName {
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    return mCarrier;
}

+ (NSString *)getWifiName {
    
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

+ (NSString *)getIPAddressOfInsideNetwork: (BOOL)preferIPv4 {
    
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        
         address = addresses[key];
         //筛选出IP地址格式
         if([self isValidatIP:address]) *stop = YES;
     }];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses {
    
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString *)getIPAddressOfOutsideNetwork {
    
    //方法一：
    /*
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://ifconfig.me/ip"];
    NSString *ip = [NSString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
     */
    
    //方法二：个人推荐用这个请求，速度比较快
    /*
     http://ipof.in/json
     http://ipof.in/xml
     http://ipof.in/txt
     If you want HTTPS you can use the same URLs with https prefix. The advantage being that even if you are on a Wifi you will get the public address.
     */
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://ipof.in/txt"];
    NSString *ip = [NSString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    
    return ip;
}

@end
