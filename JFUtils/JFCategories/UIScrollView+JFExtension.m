//
//  UIScrollView+JFExtension.m
//  CJF
//
//  Created by cjf on 2017/5/25.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "UIScrollView+JFExtension.h"

@implementation UIScrollView (JFExtension)

#pragma mark - Setter

- (CGFloat)insetTop {
    return self.contentInset.top;
}

- (CGFloat)insetRight {
    return self.contentInset.right;
}

- (CGFloat)insetBottom {
    return self.contentInset.bottom;
}

- (CGFloat)insetLeft {
    return self.contentInset.left;
}

- (CGFloat)offsetX {
    return self.contentOffset.x;
}

- (CGFloat)offsetY {
    return self.contentOffset.y;
}

- (CGFloat)contentWidth {
    return self.contentSize.width;
}

- (CGFloat)contentHeight {
    return self.contentSize.height;
}

#pragma mark - Getter

- (void)setInsetTop:(CGFloat)insetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = insetTop;
    self.contentInset = inset;
}

- (void)setInsetRight:(CGFloat)insetRight {
    UIEdgeInsets inset = self.contentInset;
    inset.right = insetRight;
    self.contentInset = inset;
}

- (void)setInsetBottom:(CGFloat)insetBottom {
    UIEdgeInsets inset = self.contentInset;
    inset.right = insetBottom;
    self.contentInset = inset;
}

- (void)setInsetLeft:(CGFloat)insetLeft {
    UIEdgeInsets inset = self.contentInset;
    inset.right = insetLeft;
    self.contentInset = inset;
}

- (void)setOffsetX:(CGFloat)offsetX {
    CGPoint offset = self.contentOffset;
    offset.x = offsetX;
    self.contentOffset = offset;
}

- (void)setOffsetY:(CGFloat)offsetY {
    CGPoint offset = self.contentOffset;
    offset.x = offsetY;
    self.contentOffset = offset;
}

- (void)setContentWidth:(CGFloat)contentWidth {
    CGSize size = self.contentSize;
    size.width = contentWidth;
    self.contentSize = size;
}

- (void)setContentHeight:(CGFloat)contentHeight {
    CGSize size = self.contentSize;
    size.width = contentHeight;
    self.contentSize = size;
}

@end
