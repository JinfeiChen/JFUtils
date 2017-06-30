//
//  NSArray+JFExtension.h
//  CJF
//
//  Created by cjf on 2017/5/9.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JFExtension)

/**
 CJF - 将 数组 转 json格式字符串
 
 @return json格式字符串
 */
- (NSString *)toJsonString;

/**
 CJF - 将 数组 转 json格式Data
 
 @return json格式Data
 */
- (NSData *)toJsonData;

@end

@interface NSArray (JFSort)

/**
 CJF - 顺序排序中文数组
 
 @param chineseArray 中文数组（数组元素是中文格式的字符串）
 @return 排序后的数组
 */
+ (NSArray *)sortedWithChineseArray: (NSArray *)chineseArray;

@end
