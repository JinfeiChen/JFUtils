//
//  UILabel+JFExtension.m
//  CJF
//
//  Created by cjf on 2017/5/12.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "UILabel+JFExtension.h"

@implementation UILabel (JFExtension)

- (CGFloat)autoHeight {
    
    CGFloat defaultLineSpacing = 8.0;
    
    return [self autoHeightWithLineSpacing:defaultLineSpacing];
}

- (CGFloat)autoHeightWithLineSpacing:(CGFloat)lineSpacing {
    
    if (self.text.length != 0) {
        
        // 必须要把行数设置为多行
        self.numberOfLines = 0;
        
        // 获取文字的CGSize
        CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
        
        // 计算出文字行数
        CGFloat lineCount = size.height / self.font.lineHeight;
        
        // 设置Label的行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpacing];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
        [self setAttributedText:attributedString];
        [self sizeToFit];
        
        return size.height + lineCount * lineSpacing;
    }
    
    return self.frame.size.height;
}

@end
