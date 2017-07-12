//
//  NSData+JFExtension.m
//  CJF
//
//  Created by cjf on 2017/5/25.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "NSData+JFExtension.h"
#include <CommonCrypto/CommonCrypto.h>

@implementation NSData (JFExtension)

@end

static const char base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSData (JFEncryption)

- (NSString *)base64 {
    
    NSUInteger length = self.length;
    if (length == 0) {
        return @"";
    }
    
    NSUInteger out_length = ((length + 2) / 3) * 4;
    uint8_t *output = malloc(((out_length + 2) / 3) * 4);
    if (output == NULL) {
        return nil;
    }
    
    const char *input = self.bytes;
    NSInteger i, value;
    for (i = 0; i < length; i += 3) {
        value = 0;
        for (NSInteger j = i; j < i + 3; j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] = base64EncodingTable[(value >> 18) & 0x3F];
        output[index + 1] = base64EncodingTable[(value >> 12) & 0x3F];
        output[index + 2] = ((i + 1) < length) ? base64EncodingTable[(value >> 6) & 0x3F] : '=';
        output[index + 3] = ((i + 2) < length) ? base64EncodingTable[(value >> 0) & 0x3F] : '=';
    }
    
    NSString *base64 = [[NSString alloc] initWithBytes:output
                                                length:out_length
                                              encoding:NSASCIIStringEncoding];
    free(output);
    return base64;
}

@end
