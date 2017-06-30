//
//  UIImage+JFExtension.h
//  CJF
//
//  Created by cjf on 2017/5/9.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JFExtension)

/**
 CJF - 获取图片上某一点上的颜色

 @param point 点
 @return 颜色对象
 */
- (UIColor *)getPixelColorAtLocation:(CGPoint)point;

@end
