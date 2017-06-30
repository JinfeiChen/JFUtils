//
//  UIImageView+JFExtension.h
//  CJF
//
//  Created by cjf on 2017/5/11.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JFExtension)

/**
 CJF - 增加模糊滤镜效果

 @param style 滤镜风格
 */
- (void)addBlurEffectWithStyle:(UIBlurEffectStyle)style;

@end
