//
//  NSData+JFExtension.h
//  CJF
//
//  Created by cjf on 2017/5/25.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JFExtension)

@end


@interface NSData (JFEncryption)

/**
 CJF - base64加密数据

 @return 字符串
 */
- (NSString *)base64;

@end
