//
//  UIView+JFExtension.h
//  CJF
//
//  Created by cjf on 2017/5/9.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JFExtension)

/**
 CJF - 清除所有子视图
 */
- (void)clearAllSubviews;

/**
 CJF - 获取视图所在的控制器

 @return 控制器对象
 */
- (UIViewController *)viewController;

@end


@interface UIView (JFFrame)

@property (nonatomic, assign) CGFloat x; /**< CJF - 获取UIView对象的origin.x的值 */
@property (assign, nonatomic) CGFloat y; /**< CJF - 获取UIView对象的origin.y的值 */
@property (assign, nonatomic) CGFloat width; /**< CJF - 获取UIView对象的size.width的值 */
@property (assign, nonatomic) CGFloat height; /**< CJF - 获取UIView对象的size.height的值 */
@property (assign, nonatomic) CGPoint origin; /**< CJF - 获取UIView对象的origin的值 */
@property (assign, nonatomic) CGSize size; /**< CJF - 获取UIView对象的size的值 */

@end


@interface UIView (JFScreenshot)

/**
 CJF - 应用于UIView截图

 @return UIImage对象
 */
- (UIImage *)screenshot;

/**
 CJF - 应用于UIScrollView截图 contentOffset

 @param contentOffset 内容显示区域
 @return UIImage对象
 */
- (UIImage *)screenshotForScrollViewWithContentOffset: (CGPoint)contentOffset;

/**
 CJF - 应用于UIView按Rect截图

 @param frame 截图区域
 @return UIImage对象
 */
- (UIImage *)screenshotInFrame:(CGRect)frame;

@end
