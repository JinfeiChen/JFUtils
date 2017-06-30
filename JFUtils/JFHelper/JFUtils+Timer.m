//
//  JFUtils+Timer.m
//  CJF
//
//  Created by cjf on 2017/5/31.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "JFUtils+Timer.h"

@implementation JFUtils (Timer)

+ (void)startGCDTimer:(dispatch_source_t)timer
                Event:(void (^)(dispatch_source_t))eventBlock
                Delay:(CGFloat)delay
             Interval:(CGFloat)interval
                Times:(CGFloat)timesCount {
    
    // 设置定时器的运行次数
    __block NSInteger count = timesCount;
    // 获得队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 创建一个定时器
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 设置开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    // 设置时间间隔
    uint64_t intervalTime = (uint64_t)(interval * NSEC_PER_SEC);
    // 设置定时器
    dispatch_source_set_timer(timer, start, intervalTime, 0);
    // 设置事件回调
    dispatch_source_set_event_handler(timer, ^{
        
              count--;
              if(count >= 0){
                  
                  if (eventBlock) {
                      eventBlock(timer);
                  }
              }
              else {
                  dispatch_cancel(timer);
              }
    });
    
    // 启动定时器，由于定时器默认是暂停的所以我们启动一下
    dispatch_resume(timer);
}

+ (void)stopGCDTimer:(dispatch_source_t)timer {
    
    if (timer) {
        dispatch_cancel(timer);
    }
}

+ (void)doGCDEvent:(void (^)())eventBlock Delay:(CGFloat)delay {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (eventBlock) {
            eventBlock();
        }
    });
}

@end
