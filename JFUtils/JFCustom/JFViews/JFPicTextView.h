//
//  JFPicTextView.h
//  CJF - 图文混排视图控件
//
//  Created by cjf on 2017/6/2.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JFPicTextViewPicAlign) {
    JFPicTextViewPicAlignTop,    /**< 图片居上对齐 */
    JFPicTextViewPicAlignRight,  /**< 图片居右对齐 */
    JFPicTextViewPicAlignBottom, /**< 图片居下对齐 */
    JFPicTextViewPicAlignLeft    /**< 图片居左对齐 */
}; /**< 图片混排 - 图片对齐方式 */

typedef NS_ENUM(NSUInteger, JFPicTextViewPicSpaceScale) {
    JFPicTextViewPicSpaceScaleQuarter,     /**< 四分之一 */
    JFPicTextViewPicSpaceScaleThird,       /**< 三分之一 */
    JFPicTextViewPicSpaceScaleHalf         /**< 二分之一 */
}; /**< 图文混排 - 图片在视图中的空间比例，此处空间比例指的是根据对齐方式设置图片的宽度或高度，居上居下设置高度，居左居右设置宽度 */

@interface JFPicTextView : UIView

@property (nonatomic, assign) JFPicTextViewPicAlign picAlign;           /**< 图片混排 - 图片对齐方式 */
@property (nonatomic, assign) JFPicTextViewPicSpaceScale picSpaceScale; /**< 图片空间比例 */

@property (nonatomic, strong) UIImage *image;   /**< 图片对象 */
@property (nonatomic, copy) NSString *title;    /**< 标题 */
@property (nonatomic, copy) NSString *subTitle; /**< 子标题 */
@property (nonatomic, copy) NSString *descript; /**< 描述 */

@end

NS_ASSUME_NONNULL_END
