//
//  JFTagView.h
//  CJF - 自定义标签视图控件
//
//  Created by cjf on 2017/6/3.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JFTagViewScrollable) {
    JFTagViewScrollableDefault,    /**< 默认不滚动 */
    JFTagViewScrollableHorizontal, /**< 允许横向滚动 */
    JFTagViewScrollableVertical    /**< 允许竖向滚动 */
}; /**< CJF - JFTagView可滚动枚举值 */

@class JFTagView, JFTagViewCell;

@protocol JFTagViewDelegate <NSObject>

@required

/**
 CJF - 回调标签数量

 @param tagView JFTagView对象
 @return 数量
 */
- (NSInteger)numbersInTagView: (JFTagView *)tagView;

/**
 CJF - 回调标签对象

 @param tagView JFTagView对象
 @param index 标签索引值
 @return 标签对象
 */
- (JFTagViewCell *)tagView: (JFTagView *)tagView cellAtIndex: (NSInteger)index;

@optional

/**
 CJF - 标签的点击事件回调

 @param tagView JFTagView对象
 @param index 标签索引值
 */
- (void)tagView: (JFTagView *)tagView didSelectRowAtIndex: (NSInteger)index;

@end

@interface JFTagView : UIView

@property (nonatomic, assign) JFTagViewScrollable scrollable; /**< CJF - JFTagView可滚动属性 */
@property (nonatomic, assign) id<JFTagViewDelegate> delegate; /**< CJF - JFTagView代理 */

@end

NS_ASSUME_NONNULL_END
