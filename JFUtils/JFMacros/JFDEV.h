//
//  JFDEV.h
//  CJF
//
//  Created by cjf on 2017/5/5.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#ifndef JFDEV_h
#define JFDEV_h


// 获取当前语言
#define JF_CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/**
 * 设备：iPad、iPhone5、isRetina
 */
#define JF_ISIPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define JF_ISIPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [UIScreen mainScreen].currentMode.size) : NO)
#define JF_ISRETINA ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [UIScreen mainScreen].currentMode.size) : NO)


/**
 * 加载图片
 * 建议使用前两种，性能高于后者
 */
#define JF_IMAGE_TYPE(file, ext) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]])
#define JF_IMAGE(file) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:nil]])
#define JF_IMAGENAME(name) ([UIImage imageNamed:name])


/**
 * 颜色
 */
#define JF_COLOR_RGBA(r, g, b, a) ([UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a])
#define JF_COLOR_RGB(r, g, b) ([UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f])
#define JF_COLOR_CLEAR ([UIColor clearColor])
#define JF_COLOR_RADOM ([UIColor colorWithRed:arc4random_uniform(255)/255.0f green:arc4random_uniform(255)/255.0f blue:arc4random_uniform(255)/255.0f alpha:1.0f])


/**
 * 弧度转角度，角度转弧度
 */
#define JF_DEGREES_TO_RADIAN(degree) ((M_PI*degree)/(180.0f))
#define JF_RADIAN_TO_DEGREES(radian) ((radian*180.0f)/(M_PI))


/**
 * 重写NSLog,Debug模式下打印日志和当前行数
 */
#pragma mark 重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction: %s line: %d content: %s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


/**
 * 弱引用
 * 使用方法：@weakify(self);
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif


/**
 * 强引用
 * 使用方法：@strongify(self);
 */
#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif



#endif /* JFDEV_h */
