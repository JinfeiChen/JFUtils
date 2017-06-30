//
//  JFRadioButton.h
//  CJF - 自定义单选按钮
//
//  Created by cjf on 2017/6/7.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JFRadioButton;

@interface JFRadioButtonManager : NSObject

+ (instancetype)shared;

@property (nonatomic, copy) NSMutableArray *radioButtonGroup; /**< CJF - 单选按钮数组 */
@property (nonatomic, strong) JFRadioButton *selected;        /**< CJF - 当前选中的单选按钮 */

@end

@interface JFRadioButton : UIButton

- (void)touchUpInside: (void (^)())event; /**< CJF - 单选按钮的点击事件 */

@property (nonatomic, strong) id info; /**< CJF - 信息 */

@end
