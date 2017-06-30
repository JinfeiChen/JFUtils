//
//  JFError.m
//  CJF
//
//  Created by cjf on 2017/5/17.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "JFError.h"

static NSDictionary *errorDictionary = nil;

@implementation JFError

+ (void)initialize {
    
    if (self == [JFError class]) {
        
        errorDictionary = @{
                            /* code : errorWithDomain */
                            /* ==================================== */
                            
                            @(JFErrorCodeUnknow) : @"未知错误",
                            
                            @(JFErrorCodeTest)   : @"测试错误"
                            
                            /* ==================================== */
                            };
    }
}

+ (NSError *)errorWithCode:(JFErrorCode)errorCode errorInfo:(NSDictionary *)errorInfo {
    return [[NSError alloc] initWithDomain:errorDictionary[@(errorCode)] code:errorCode userInfo:errorInfo];
}

+ (NSString *)descriptionWithErrorCode:(JFErrorCode)errorCode {
    return errorDictionary[@(errorCode)];
}

@end
