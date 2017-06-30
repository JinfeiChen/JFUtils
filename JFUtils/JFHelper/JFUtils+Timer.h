//
//  JFUtils+Timer.h
//  CJF - 定时器管理对象
//
//  Created by cjf on 2017/5/31.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "JFUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface JFUtils (Timer)

/**
 CJF - 启动GCD定时器

 @param timer 定时器对象
 @param eventBlock 定时器回调事件Block
 @param delay 延迟启动定时器的时间
 @param interval 定时器事件的执行时间间隔
 @param timesCount 定时器事件执行的次数
 */
+ (void)startGCDTimer: (dispatch_source_t)timer
                Event: (void (^)(dispatch_source_t timer))eventBlock
                Delay: (CGFloat)delay
             Interval: (CGFloat)interval
                Times: (CGFloat)timesCount;

/**
 CJF - 停止GCD定时器

 @param timer 定时器对象
 */
+ (void)stopGCDTimer: (dispatch_source_t)timer;

/**
 CJF - 延迟执行某事件
 注意：此方法在主线程中执行

 @param eventBlock 要执行的事件
 @param delay 延迟时间
 */
+ (void)doGCDEvent: (void (^)())eventBlock Delay: (CGFloat)delay;

@end

NS_ASSUME_NONNULL_END
