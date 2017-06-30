//
//  JFTagViewCell.m
//  CJF
//
//  Created by cjf on 2017/6/3.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "JFTagViewCell.h"

#import "UIView+JFExtension.h"

static CGFloat PADDING = 4; /**< 默认标签内边距 */

@interface JFTagViewCell (){
    UILabel *_txtLabel;
}

@end

@implementation JFTagViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self buildView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self buildView];
    }
    return self;
}

#pragma mark - Public Method

#pragma mark - Private Method

- (void)buildView {
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:_contentView];
    _contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    _contentView.layer.cornerRadius = 3;
    _contentView.layer.masksToBounds = YES;
    
    _txtLabel = [[UILabel alloc] initWithFrame:_contentView.bounds];
    [_contentView addSubview:_txtLabel];
    _txtLabel.textColor = [UIColor grayColor];
    _txtLabel.font = [UIFont systemFontOfSize:14];
}

#pragma mark - Setter

- (void)setText:(NSString *)text {
    _text = text;
    
    _txtLabel.text = text;
    
    CGRect rect = [text boundingRectWithSize: CGSizeMake(CGFLOAT_MAX, _txtLabel.height)
                                               options: NSStringDrawingUsesLineFragmentOrigin
                                            attributes: @{
                                                          NSFontAttributeName:_txtLabel.font
                                                          }
                                               context: nil];
    
    self.width = rect.size.width + 2 * PADDING;
    self.height = rect.size.height + 2 * PADDING;
    
    _contentView.frame = self.bounds;
    _txtLabel.frame = CGRectMake(PADDING, PADDING, rect.size.width, rect.size.height);
}

@end
