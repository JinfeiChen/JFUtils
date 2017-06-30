//
//  JFRadioButton.m
//  CJF
//
//  Created by cjf on 2017/6/7.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "JFRadioButton.h"

@implementation JFRadioButtonManager

+ (instancetype)shared {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _radioButtonGroup = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Setter

- (void)setSelected:(JFRadioButton *)selected {
    _selected = selected;
    
    if (_radioButtonGroup) {
        for (JFRadioButton *button in _radioButtonGroup) {
            button.selected = NO;
        }
        _selected.selected = YES;
    }
}

@end




@implementation JFRadioButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [JFRadioButton initializeWithButton:self];
    }
    return self;
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    JFRadioButton *radioButton = [super buttonWithType:buttonType];
    [JFRadioButton initializeWithButton:radioButton];
    return radioButton;
}

#pragma mark - Private Method

+ (void)initializeWithButton: (JFRadioButton *)button {
    
    JFRadioButtonManager *manager = [JFRadioButtonManager shared];
    if (![manager.radioButtonGroup containsObject:button]) {
        [manager.radioButtonGroup addObject:button];
    }
}

- (void)touchUpInside:(void (^)())event {
    
    JFRadioButtonManager *manager = [JFRadioButtonManager shared];
    // 更新单选按钮组的选中状态
    for (JFRadioButton *button in manager.radioButtonGroup) {
        button.selected = NO;
    }
    self.selected = YES;
    manager.selected = self; // 更新当前选中的单选按钮
    
    if (event) {
        event();
    }
}


@end
