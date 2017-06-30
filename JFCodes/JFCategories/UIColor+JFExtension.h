//
//  UIColor+JFExtension.h
//  CJF
//
//  Created by cjf on 2017/5/9.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JFExtension)

/**
 CJF - 随机颜色

 @return UIColor对象
 */
+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha: (CGFloat)alpha; /**< CJF - 获取随机颜色， alpha：颜色透明度 */

/**
 CJF - 获取16进制颜色值转换为RGB后的颜色

 @param colorStr 16进制表示的颜色（0xc36000, 0xc36000, #c36000或者c36000格式都支持）
 @return UIColor对象
 */
+ (UIColor *)colorWithHexString: (NSString *)colorStr;
+ (UIColor *)colorWithHexString: (NSString *)colorStr alpha: (CGFloat)alpha; /**< CJF - 获取16进制颜色值转换为RGB后的颜色， alpha：颜色透明度 */

/**
 CJF - 颜色转换为图片
 
 @param color 颜色
 @return UIImage对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
