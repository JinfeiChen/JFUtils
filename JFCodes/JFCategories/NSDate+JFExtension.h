//
//  NSDate+JFExtension.h
//  CJF
//
//  Created by cjf on 2017/5/25.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (JFExtension)

@property (nonatomic, readonly) NSInteger year;       /**< CJF - 年 */
@property (nonatomic, readonly) NSInteger month;      /**< CJF - 月 (1~12) */
@property (nonatomic, readonly) NSInteger day;        /**< CJF - (1~31) */
@property (nonatomic, readonly) NSInteger hour;       /**< CJF - 小时 (0~23) */
@property (nonatomic, readonly) NSInteger minute;     /**< CJF - 分钟 (0~59) */
@property (nonatomic, readonly) NSInteger second;     /**< CJF - 秒 (0~59) */
@property (nonatomic, readonly) NSInteger nanosecond; /**< CJF - 纳秒 */

@end

@interface NSDate (JFValidate)

/**
 CJF - 验证时间是否是今天

 @return YES or NO
 */
- (BOOL)isToday;

/**
 CJF - 验证时间是否为昨天

 @return YES or NO
 */
- (BOOL)isYesterday;

@end

NS_ASSUME_NONNULL_END
