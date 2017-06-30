//
//  NSArray+JFExtension.m
//  CJF
//
//  Created by cjf on 2017/5/9.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "NSArray+JFExtension.h"

@implementation NSArray (JFExtension)

- (NSString *)toJsonString {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] && error == nil) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

- (NSData *)toJsonData {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] && error == nil) {
        return jsonData;
    }else{
        return nil;
    }
}

@end

@implementation NSArray (JFSort)

+ (NSArray *)sortedWithChineseArray:(NSArray *)chineseArray {
    
    return [[chineseArray copy] sortedArrayUsingSelector:@selector(localizedCompare:)];
}

@end
