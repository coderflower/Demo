//
//  GKVerticalButton.m
//  Baisi
//
//  Created by 花菜ChrisCai on 2016/5/25.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "GKVerticalButton.h"

@implementation GKVerticalButton
#pragma mark -
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

/**
 *  初始化设置
 */
- (void)setup
{
    // 标题文字居中显示
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setFrame:(CGRect)frame
{
    
    frame.size.height = 49;
    
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    
    bounds.size.height = 49;
    [super setBounds:bounds];
    
}
#pragma mark -
#pragma mark - 布局子控件
/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGFloat imageW = 35;
    CGFloat imageH = 35;
    CGFloat imageX = (width - imageW) * 0.5; // 水平居中
    CGFloat imageY = 0;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    // Label尺寸自适应
    [self.titleLabel sizeToFit];
    CGFloat titleW = self.titleLabel.bounds.size.width;
    CGFloat titleH =  self.titleLabel.frame.size.height;
    CGFloat titleX = (width - titleW) * 0.5; // 水平居中
    CGFloat titleY = height - titleH;
    
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
}
@end
