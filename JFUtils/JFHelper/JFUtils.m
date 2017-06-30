//
//  JFUtils.m
//  CJF
//
//  Created by cjf on 2017/5/31.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "JFUtils.h"

@implementation JFUtils

+ (instancetype)shared {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

@end
