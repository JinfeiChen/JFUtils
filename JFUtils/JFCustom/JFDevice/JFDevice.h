//
//  JFDevice.h
//  YWSDK
//
//  Created by cjf on 2017/6/16.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFDevice : NSObject

+ (NSString *)getIDFV;

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

/**
 CJF - 获取当前连接wifi的IP地址

 @return 地址
 */
+ (nullable NSString *)getIPAddress;


/**
 CJF - 获取当前连接wifi的名称

 @return 名称
 */
+ (nullable NSString *)getWiFiName;

@end

NS_ASSUME_NONNULL_END
