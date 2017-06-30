//
//  UIScrollView+JFExtension.h
//  CJF
//
//  Created by cjf on 2017/5/25.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (JFExtension)

@property (assign, nonatomic) CGFloat insetTop; /**< CJF - 内容视图上内边距 */
@property (assign, nonatomic) CGFloat insetBottom; /**< CJF - 内容视图底内边距 */
@property (assign, nonatomic) CGFloat insetLeft; /**< CJF - 内容视图左内边距 */
@property (assign, nonatomic) CGFloat insetRight; /**< CJF - 内容视图右内边距 */

@property (assign, nonatomic) CGFloat offsetX; /**< CJF - 显示区域的顶点相对于frame顶点的偏移量 X */
@property (assign, nonatomic) CGFloat offsetY; /**< CJF - 显示区域的顶点相对于frame顶点的偏移量 Y */

@property (assign, nonatomic) CGFloat contentWidth; /**< CJF - UIScrollView可滚动的区域宽度 */
@property (assign, nonatomic) CGFloat contentHeight; /**< CJF - UIScrollView可滚动的区域高度 */

@end
