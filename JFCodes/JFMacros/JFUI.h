//
//  JFUI.h
//  CJF
//
//  Created by cjf on 2017/5/5.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#ifndef JFUI_h
#define JFUI_h

// px转pt
#define kJFPtWithPx(px) (px*0.5)
#define kJFFontSizeWithPx(px) (px*0.5+2)

// self.view 尺寸
#define kJFSelfViewWidth self.view.frame.size.width
#define kJFSelfViewHeight self.view.frame.size.height

// self 尺寸
#define kJFSelfWidth self.frame.size.width
#define kJFSelfHeight self.frame.size.height

// 屏幕 尺寸
#define kJFScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kJFScreenHeight ([UIScreen mainScreen].bounds.size.height)

// 清除颜色
#define kJFClearColor [UIColor clearColor]


#endif /* JFUI_h */
