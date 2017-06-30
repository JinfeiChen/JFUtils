//
//  UILabel+JFExtension.h
//  CJF
//
//  Created by cjf on 2017/5/12.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JFExtension)

/**
 CJF - 自适应高度

 @return UILabel的高度
 */
- (CGFloat)autoHeight;
- (CGFloat)autoHeightWithLineSpacing: (CGFloat)lineSpacing; /**< CJF - 自适应高度，可指定行间距 */

@end
