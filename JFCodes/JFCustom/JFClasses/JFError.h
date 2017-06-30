//
//  JFError.h
//  CJF - 自定义错误类
//
//  Created by cjf on 2017/5/17.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JFErrorCode) {
    JFErrorCodeUnknow = 1000, /**< CJF - 未知错误 */
    JFErrorCodeTest
}; /**< 错误码 */

@interface JFError : NSObject

/**
 CJF - 定义一个 JFError 错误对象
 
 @param errorCode 错误码
 @param errorInfo 错误描述
 @return 错误对象
 */
+ (NSError *)errorWithCode:(JFErrorCode)errorCode errorInfo:(NSDictionary *)errorInfo;

/**
 CJF - 翻译一个 JFError 错误对象
 
 @param errorCode 错误码
 @return 字符串
 */
+ (NSString *)descriptionWithErrorCode:(JFErrorCode)errorCode;


/**
 * ========== JFError 使用方法 ===========
 */

/**
 // 定制一个JFError
 NSError *error = [JFError errorWithCode:JFErrorCodeUnknow errorInfo:nil];
 
 // 翻译一个HDError（将code值翻译成字符串）
 NSString *errorString = [JFError descriptionWithErrorCode:JFErrorCodeUnknow];
 */

@end

