//
//  UITextField+JFExtension.m
//  CJF
//
//  Created by cjf on 2017/5/11.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "UITextField+JFExtension.h"

@implementation UITextField (JFExtension)

- (void)setPlaceholderColor:(UIColor *)color {

    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.text attributes:@{NSForegroundColorAttributeName: color}];
}

@end
