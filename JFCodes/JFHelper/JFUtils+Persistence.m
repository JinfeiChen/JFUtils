//
//  JFUtils+Persistence.m
//  CJF
//
//  Created by cjf on 2017/5/31.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "JFUtils+Persistence.h"

@implementation JFUtils (Persistence)

+ (NSString *)bundlePath {
    return [[NSBundle mainBundle] bundlePath];
}

+ (NSString *)homePath {
    return NSHomeDirectory();
}

+ (NSString *)documentsPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)cachesPath {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)tempPath {
    return NSTemporaryDirectory();
}

// ----------------------------------------------------

@end
