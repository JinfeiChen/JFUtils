//
//  JFQuantityView.m
//  CJF
//
//  Created by cjf on 2017/6/5.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "JFQuantityView.h"

#import "UIView+JFExtension.h"

static CGFloat PADDING = 8;
static CGFloat LINEWIDTH = 2;

@interface JFQuantityView ()<UITextFieldDelegate>{
    UITextField *_inputField;
    UIButton *_minusButton;
    UIButton *_plusButton;
}

@end

@implementation JFQuantityView

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

#pragma mark - Action

- (void)plusAction: (id)sender {
    
    _inputField.text = [NSString stringWithFormat:@"%ld", (long)(_inputField.text.integerValue == _max ? _max : _inputField.text.integerValue + 1)];
    _number = _inputField.text.integerValue;
    
    [self updateButtonUI];
}

- (void)minusAction: (id)sender {
    
    _inputField.text = [NSString stringWithFormat:@"%ld", (long)(_inputField.text.integerValue == _min ? _min : _inputField.text.integerValue - 1)];
    _number = _inputField.text.integerValue;
    
    [self updateButtonUI];
}

#pragma mark - Setter

- (void)setMin:(NSInteger)min {
    _min = min;
    
    if (!_number) {
        _inputField.text = [NSString stringWithFormat:@"%ld", (long)_min];
    }
}

- (void)setNumber:(NSInteger)number {
    _number = number;
    
    _inputField.text = [NSString stringWithFormat:@"%ld", (long)_number];
    
    [self updateButtonUI];
}

#pragma mark - Private Method

- (void)buildView {
    
    _min = 0;
    _max = CGFLOAT_MAX;
    
    // 配置左按钮
    _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _minusButton.frame = CGRectMake(0, 0, self.height, self.height);
    [self addSubview:_minusButton];
    
    [_minusButton setBackgroundImage:[self imageFromView:[self plusminusViewWithPlus:NO Normal:YES]] forState:UIControlStateNormal];
    [_minusButton setBackgroundImage:[self imageFromView:[self plusminusViewWithPlus:NO Normal:NO]] forState:UIControlStateHighlighted];
    
    [_minusButton addTarget:self action:@selector(minusAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 配置中间输入控件
    _inputField = [[UITextField alloc] initWithFrame:CGRectMake(self.height+1, 0, self.width-2*self.height-2*1, self.height)];
    [self addSubview:_inputField];
    _inputField.delegate = self;
    _inputField.text = [NSString stringWithFormat:@"%ld", (long)_min];
    _inputField.textAlignment = NSTextAlignmentCenter;
    _inputField.backgroundColor = [UIColor colorWithWhite:0.945 alpha:1.0];
    _inputField.keyboardType = UIKeyboardTypeNumberPad;
    _inputField.textColor = [UIColor grayColor];
    
    // 配置右按钮
    _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _plusButton.frame = CGRectMake(self.width - self.height, 0, self.height, self.height);
    [self addSubview:_plusButton];
    
    [_plusButton setBackgroundImage:[self imageFromView:[self plusminusViewWithPlus:YES Normal:YES]] forState:UIControlStateNormal];
    [_plusButton setBackgroundImage:[self imageFromView:[self plusminusViewWithPlus:YES Normal:NO]] forState:UIControlStateHighlighted];
    
    [_plusButton addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateButtonUI];
}

- (UIView *)plusminusViewWithPlus: (BOOL)isPlus Normal: (BOOL)isNormal {
    
    CGFloat buttonWidth = self.height;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
    UIView *horizontalView = [[UIView alloc] initWithFrame:CGRectMake(PADDING, (buttonWidth-LINEWIDTH)/2, buttonWidth-2*PADDING, LINEWIDTH)];
    UIView *verticalView = [[UIView alloc] initWithFrame:CGRectMake((buttonWidth-LINEWIDTH)/2, PADDING, LINEWIDTH, buttonWidth-2*PADDING)];
    
    if (isPlus) {
        
        [contentView addSubview:horizontalView];
        [contentView addSubview:verticalView];
    }
    else {
        
        [contentView addSubview:horizontalView];
    }
    
    if (isNormal) {
        
        contentView.backgroundColor = [UIColor colorWithWhite:0.945 alpha:1.0];
        horizontalView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        verticalView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    }
    else {
        
        contentView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        horizontalView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.0];
        verticalView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.0];
    }
    
    return contentView;
}

/**
 UIView生成图片对象

 @param view view对象
 @return 图片对象
 */
- (UIImage *)imageFromView: (UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, view.layer.contentsScale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)updateButtonUI {
    
    if (_inputField.text.length != 0 && _inputField.text.integerValue <= _min) {
        
        _minusButton.enabled = NO;
        [_minusButton setBackgroundImage:[self imageFromView:[self plusminusViewWithPlus:NO Normal:NO]] forState:UIControlStateNormal];
    }
    else {
        
        _minusButton.enabled = YES;
        [_minusButton setBackgroundImage:[self imageFromView:[self plusminusViewWithPlus:NO Normal:YES]] forState:UIControlStateNormal];
    }
    
    if (_inputField.text.length != 0 && _inputField.text.integerValue >= _max) {
        
        _plusButton.enabled = NO;
        [_plusButton setBackgroundImage:[self imageFromView:[self plusminusViewWithPlus:YES Normal:NO]] forState:UIControlStateNormal];
    }
    else {
        
        _plusButton.enabled = YES;
        [_plusButton setBackgroundImage:[self imageFromView:[self plusminusViewWithPlus:YES Normal:YES]] forState:UIControlStateNormal];
    }
}

#pragma mark - UITextFieldDelegate 

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    _number = textField.text.integerValue;
    [self updateButtonUI];
}

@end



