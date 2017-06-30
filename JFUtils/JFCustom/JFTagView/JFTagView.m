//
//  JFTagView.m
//  CJF
//
//  Created by cjf on 2017/6/3.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "JFTagView.h"

#import "UIView+JFExtension.h"
#import "JFTagViewCell.h"

static CGFloat PADDING = 6; /**< 内间距、标签之间的间距 */

@interface JFTagView (){
    UIScrollView *_containerView; /**< 容器视图 */
    CGFloat _horizontalTotalWidth; /**< 横向总宽度 */
    CGFloat _verticalTotalHeight; /**< 竖向总高度 */
}

@end

@implementation JFTagView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

#pragma mark - Private Method

/**
 CJF - 获取是否可滚动属性

 @param scroll 可滚动标识
 @return YES or NO
 */
- (BOOL)scrollable: (JFTagViewScrollable)scroll {
    switch (scroll) {
        case JFTagViewScrollableVertical:
            return YES;
            break;
        case JFTagViewScrollableHorizontal:
            return YES;
            break;
            
        case JFTagViewScrollableDefault:
        default:
            return NO;
            break;
    }
}

- (void)setup {
    
    _scrollable = JFTagViewScrollableDefault; // 默认不滚动
    _horizontalTotalWidth = 0;
    _verticalTotalHeight = 0;
    
    _containerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height-PADDING)];
    [self addSubview:_containerView];
    
    // 是否取消反弹效果
    _containerView.bounces = NO;
    // 是否可滚动
    _containerView.scrollEnabled = [self scrollable:_scrollable];
    // 隐藏滚动条
    _containerView.showsVerticalScrollIndicator = NO;
    _containerView.showsHorizontalScrollIndicator = NO;
    // 设置内容区域大小
    _containerView.contentSize = CGSizeMake(self.width, self.height);
}

/**
 标签总更新
 */
- (void)update {
    
    [_containerView clearAllSubviews];
    
    _containerView.scrollEnabled = [self scrollable:_scrollable];
    switch (_scrollable) {
        case JFTagViewScrollableHorizontal:
        {
            [self horizontalUpdate];
        }
            break;
        case JFTagViewScrollableVertical:
        {
            [self verticalUpdate];
        }
            break;
        case JFTagViewScrollableDefault:
            
        default:
        {
            [self defaultUpdate];
        }
            break;
    }
    
    [self addGesture];
}

/**
 标签竖向更新
 */
- (void)verticalUpdate {
    
    _verticalTotalHeight = 0;
    
    NSInteger tagCount = [_delegate numbersInTagView:self];
    CGSize contentSize = _containerView.contentSize;
    
    for (int i = 0; i < tagCount; i++) {
        
        JFTagViewCell *cell = [_delegate tagView:self cellAtIndex:i];
        [_containerView addSubview:cell];
        
        cell.tag = i + 1000;
        
        CGFloat cellWidth = cell.width > self.width ? self.width : cell.width;
        CGFloat cellHeight = cell.height;
        CGFloat cellX = PADDING;
        CGFloat cellY = PADDING + _verticalTotalHeight;
        
        cell.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
        
        _verticalTotalHeight = cellY + cellHeight;
        
        contentSize.height = _verticalTotalHeight;
    }
    contentSize.height += PADDING;
    _containerView.contentSize = contentSize;
}

/**
 标签横向更新
 */
- (void)horizontalUpdate {
    
    _horizontalTotalWidth = 0;
    
    NSInteger tagCount = [_delegate numbersInTagView:self];
    CGSize contentSize = _containerView.contentSize;
    
    for (int i = 0; i < tagCount; i++) {
        
        JFTagViewCell *cell = [_delegate tagView:self cellAtIndex:i];
        [_containerView addSubview:cell];
        
        cell.tag = i + 1000;
        
        CGFloat cellWidth = cell.width;
        CGFloat cellHeight = cell.height > self.height ? self.height : cell.height;
        CGFloat cellX = PADDING + _horizontalTotalWidth;
        CGFloat cellY = PADDING;
        
        cell.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
        
        _horizontalTotalWidth = cellX + cellWidth;
        
        contentSize.width = _horizontalTotalWidth;
    }
    
    contentSize.width += PADDING;
    _containerView.contentSize = contentSize;
}

/**
 标签默认更新
 */
- (void)defaultUpdate {
    
    _horizontalTotalWidth = 0;
    
    NSInteger tagCount = [_delegate numbersInTagView:self];
    CGSize size = _containerView.contentSize;
    size.height = 0;
    NSInteger lineNumber = 0;
    CGFloat cellX = PADDING;
    for (int i = 0; i < tagCount; i++) {
        
        JFTagViewCell *cell = [_delegate tagView:self cellAtIndex:i];
        [_containerView addSubview:cell];
        
        cell.tag = i + 1000;
        
        CGFloat cellWidth = cell.width > self.width ? self.width : cell.width;
        CGFloat cellHeight = cell.height;
        
        if (_horizontalTotalWidth + cellWidth + PADDING >= self.width) {
            _horizontalTotalWidth = 0;
            lineNumber += 1;
            cellX = PADDING;
        }
        else {
            cellX = _horizontalTotalWidth == 0 ? PADDING : _horizontalTotalWidth + PADDING;
        }
        
        CGFloat cellY = _verticalTotalHeight == 0 ? PADDING : lineNumber * (PADDING + cellHeight) + PADDING;
        cell.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
        
        _horizontalTotalWidth = cellX + cellWidth;
        
        _verticalTotalHeight = (lineNumber + 1) * (cellHeight + PADDING);
        size.height = _verticalTotalHeight;
    }
    _containerView.contentSize = size;
}

- (void)addGesture {
    
    NSArray *subViews = _containerView.subviews;
    for (JFTagViewCell *cell in subViews) {
        // 添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [cell addGestureRecognizer:tap];
    }
}

#pragma mark - Setter

- (void)setDelegate:(id<JFTagViewDelegate>)delegate {
    _delegate = delegate;
    
    [self update];
}

- (void)setScrollable:(JFTagViewScrollable)scrollable {
    _scrollable = scrollable;
    
    [self update];
}

#pragma mark - Action

- (void)tapAction: (UIGestureRecognizer *)gesture {
    
    if ([_delegate respondsToSelector:@selector(tagView:didSelectRowAtIndex:)]) {
        
        [_delegate tagView:self didSelectRowAtIndex:gesture.view.tag - 1000];
    }
}

#pragma mark - LayoutSubViews

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

@end
