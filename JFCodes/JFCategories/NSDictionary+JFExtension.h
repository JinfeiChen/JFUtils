//
//  NSDictionary+JFExtension.h
//  CJF
//
//  Created by cjf on 2017/5/9.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JFExtension)

/**
 CJF - 将 字典 转 json格式字符串
 
 @return json格式字符串
 */
- (NSString *)toJsonString;

/**
 CJF - 将 字典 转 json格式Data
 
 @return json格式Data
 */
- (NSData *)toJsonData;

@end
