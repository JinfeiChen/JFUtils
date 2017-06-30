//
//  JFTagViewCell.h
//  CJF
//
//  Created by cjf on 2017/6/3.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFTagViewCell : UIView

@property (nonatomic, strong) UIView *contentView; /**< CJF - 内容视图 */
@property (nonatomic, copy) NSString *text; /**< CJF - 标签文字视图 */

@end

NS_ASSUME_NONNULL_END
