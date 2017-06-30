//
//  JFPicTextView.m
//  CJF
//
//  Created by cjf on 2017/6/2.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "JFPicTextView.h"

#import "UIView+JFExtension.h"
#import "UIColor+JFExtension.h"
#import "UILabel+JFExtension.h"

static CGFloat picTxtSpacing = 10;

@interface JFPicTextView (){
    UILabel *_titleLabel;
    UILabel *_subTitleLabel;
    UILabel *_descriptLabel;
}

@property (nonatomic, strong) UIImageView *picArea; /**< 图文混排 - 图片区 */
@property (nonatomic, strong) UIView *txtArea;      /**< 图文混排 - 文本区 */

@end

@implementation JFPicTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

#pragma mark - Private Method

/**
 CJF - 配置视图
 */
- (void)setup {
    
    // 默认配置
    _picAlign = JFPicTextViewPicAlignLeft;
    _picSpaceScale = JFPicTextViewPicSpaceScaleThird;
    
    CGFloat scale = [self getScale:_picSpaceScale];
    
    _picArea = [[UIImageView alloc] initWithImage:[UIColor imageWithColor:[UIColor lightGrayColor]]];
    [self addSubview:_picArea];
    _picArea.frame = CGRectMake(0, 0, self.width*scale, self.height);
    
    _txtArea = [[UIView alloc] initWithFrame:CGRectMake(_picArea.width+picTxtSpacing, 0, self.width-_picArea.width-picTxtSpacing, self.height)];
    [self addSubview:_txtArea];
}

/**
 CJF - 获取图文混排图片的空间比例

 @param spaceScale 比例枚举值
 @return 比例
 */
- (CGFloat)getScale: (JFPicTextViewPicSpaceScale)spaceScale {
    
    CGFloat scale = 0;
    switch (spaceScale) {
        case JFPicTextViewPicSpaceScaleQuarter:
            scale = 0.25;
            break;
        case JFPicTextViewPicSpaceScaleThird:
            scale = 0.33333;
            break;
        case JFPicTextViewPicSpaceScaleHalf:
            scale = 0.5;
            break;
            
        default:
            scale = 1;
            break;
    }
    return scale;
}

/**
 CJF - 更新子视图布局
 */
- (void)updateSubViews {
    
    if (_picArea && _txtArea) {
        
        CGRect picFrame, txtFrame;
        CGFloat scale = [self getScale:_picSpaceScale];
        switch (_picAlign) {
            case JFPicTextViewPicAlignTop:
            {
                picFrame = CGRectMake(0, 0, self.width, self.height*scale);
                txtFrame = CGRectMake(0, picFrame.size.height+picTxtSpacing, self.width, self.height-picFrame.size.height-picTxtSpacing);
            }
                break;
            case JFPicTextViewPicAlignRight:
            {
                picFrame = CGRectMake(self.width*(1-scale), 0, self.width*scale, self.height);
                txtFrame = CGRectMake(0, 0, self.width-picFrame.size.width-picTxtSpacing, self.height);
            }
                break;
            case JFPicTextViewPicAlignBottom:
            {
                picFrame = CGRectMake(0, self.height-self.height*scale, self.width, self.height*scale);
                txtFrame = CGRectMake(0, 0, self.width, self.height*(1-scale)-picTxtSpacing);
            }
                break;
            case JFPicTextViewPicAlignLeft:
            {
                picFrame = CGRectMake(0, 0, self.width*scale, self.height);
                txtFrame = CGRectMake(picFrame.size.width+picTxtSpacing, 0, self.width*(1-scale)-picTxtSpacing, self.height);
            }
                break;
                
            default:
                break;
        }
        _picArea.frame = picFrame;
        _txtArea.frame = txtFrame;
    }
}

#pragma mark - LayoutSubViews

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_title && !_subTitle && !_descript) {
        _titleLabel.frame = CGRectMake(0, 0, _txtArea.width, _txtArea.height);
    }
    
    else if (!_title && _subTitle && !_descript) {
        _subTitleLabel.frame = CGRectMake(0, 0, _txtArea.width, _txtArea.height);
    }
    
    else if (!_title && !_subTitle && _descript) {
        _descriptLabel.frame = CGRectMake(0, 0, _txtArea.width, _txtArea.height);
    }
    
    else if (_title && _subTitle && !_descript) {
        CGFloat titleLabelHeight = _titleLabel.font.capHeight + _titleLabel.font.lineHeight;
        CGFloat subTitleLabelHeight = _subTitleLabel.font.capHeight + _subTitleLabel.font.lineHeight;
        _titleLabel.frame = CGRectMake(0, (_txtArea.height-titleLabelHeight-subTitleLabelHeight)/2, _txtArea.width, titleLabelHeight);
        _subTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), _txtArea.width, subTitleLabelHeight);
    }
    
    else if (_title && !_subTitle && _descript) {
        CGFloat titleLabelHeight = _titleLabel.font.capHeight + _titleLabel.font.lineHeight;
        _descriptLabel.frame = _txtArea.frame;
        CGFloat descriptLabelHeight = [_descriptLabel autoHeight] > (_txtArea.height - titleLabelHeight) ? (_txtArea.height - titleLabelHeight) : [_descriptLabel autoHeight];
        _titleLabel.frame = CGRectMake(0, (_txtArea.height-titleLabelHeight-descriptLabelHeight)/2, _txtArea.width, titleLabelHeight);
        _descriptLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), _txtArea.width, descriptLabelHeight);
    }
    
    else if (!_title && _subTitle && _descript) {
        CGFloat subTitleLabelHeight = _subTitleLabel.font.capHeight + _subTitleLabel.font.lineHeight;
        _descriptLabel.frame = _txtArea.frame;
        CGFloat descriptLabelHeight = [_descriptLabel autoHeight] > (_txtArea.height - subTitleLabelHeight) ? (_txtArea.height - subTitleLabelHeight) : [_descriptLabel autoHeight];
        _subTitleLabel.frame = CGRectMake(0, (_txtArea.height-subTitleLabelHeight-descriptLabelHeight)/2, _txtArea.width, subTitleLabelHeight);
        _descriptLabel.frame = CGRectMake(0, CGRectGetMaxY(_subTitleLabel.frame), _txtArea.width, descriptLabelHeight);
    }
    
    else if (_title && _subTitle && _descript) {
        CGFloat titleLabelHeight = _titleLabel.font.capHeight + _titleLabel.font.lineHeight;
        CGFloat subTitleLabelHeight = _subTitleLabel.font.capHeight + _subTitleLabel.font.lineHeight;
        _descriptLabel.frame = _txtArea.frame;
        CGFloat descriptLabelHeight = [_descriptLabel autoHeight] > (_txtArea.height - titleLabelHeight - subTitleLabelHeight) ? (_txtArea.height - titleLabelHeight - subTitleLabelHeight) : [_descriptLabel autoHeight];
        _titleLabel.frame = CGRectMake(0, (_txtArea.height-titleLabelHeight-subTitleLabelHeight-descriptLabelHeight)/2, _txtArea.width, titleLabelHeight);
        _subTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), _txtArea.width, subTitleLabelHeight);
        _descriptLabel.frame = CGRectMake(0, CGRectGetMaxY(_subTitleLabel.frame), _txtArea.width, descriptLabelHeight);
    }
}

#pragma mark - Getter

#pragma mark - Setter

- (void)setPicAlign:(JFPicTextViewPicAlign)picAlign {
    _picAlign = picAlign;
    
    [self updateSubViews];
}

- (void)setPicSpaceScale:(JFPicTextViewPicSpaceScale)picSpaceScale {
    _picSpaceScale = picSpaceScale;
    
    [self updateSubViews];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    if (_picArea) {
        _picArea.image = image;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _titleLabel = [[UILabel alloc] init];
    [_txtArea addSubview:_titleLabel];
    _titleLabel.text = title;
    _titleLabel.font = [UIFont systemFontOfSize:16];
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    
    _subTitleLabel = [[UILabel alloc] init];
    [_txtArea addSubview:_subTitleLabel];
    _subTitleLabel.text = subTitle;
    _subTitleLabel.font = [UIFont systemFontOfSize:14];
    _subTitleLabel.textColor = [UIColor lightGrayColor];
}

- (void)setDescript:(NSString *)descript {
    _descript = descript;
    
    _descriptLabel = [[UILabel alloc]init];
    [_txtArea addSubview:_descriptLabel];
    _descriptLabel.numberOfLines = 0;
    _descriptLabel.text = descript;
    _descriptLabel.font = [UIFont systemFontOfSize:14];
    _descriptLabel.textColor = [UIColor grayColor];
}

@end
