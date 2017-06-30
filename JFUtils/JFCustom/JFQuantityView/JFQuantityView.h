//
//  JFQuantityView.h
//  CJF - 自定义数量选择视图控件
//
//  Created by cjf on 2017/6/5.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFQuantityView : UIView

@property (nonatomic, assign) NSInteger max; /**< 最大数值 */
@property (nonatomic, assign) NSInteger min; /**< 最小数值 */
@property (nonatomic, assign) NSInteger number; /**< 数值 */

@end

NS_ASSUME_NONNULL_END
