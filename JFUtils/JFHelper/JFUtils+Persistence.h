//
//  JFUtils+Persistence.h
//  CJF - 数据持久化操作管理对象
//
//  Created by cjf on 2017/5/31.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "JFUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface JFUtils (Persistence)

#pragma mark - 类方法

/**
 CJF - 应用程序包根目录
 这里面存放的是应用程序的源文件，包括资源文件和可执行文件
 
 @return 路径
 */
+ (NSString *)bundlePath;

/**
 CJF - 沙盒主目录路径
 
 @return 路径
 */
+ (NSString *)homePath;

/**
 CJF - Documents: 最常用的目录
 iTunes同步该应用时会同步此文件夹中的内容，适合存储重要数据
 
 @return 路径
 */
+ (NSString *)documentsPath;

/**
 CJF - Library/Caches:
 iTunes不会同步此文件夹，适合存储体积大，不需要备份的非重要数据。
 
 @return 路径
 */
+ (NSString *)cachesPath;

/**
 CJF - tmp:
 iTunes不会同步此文件夹，系统可能在应用没运行时就删除该目录下的文件
 
 @return 路径
 */
+ (NSString *)tempPath;

#pragma mark - 对象方法

@end

NS_ASSUME_NONNULL_END
