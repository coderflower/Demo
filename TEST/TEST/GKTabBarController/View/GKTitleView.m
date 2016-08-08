//
//  GKTitleView.m
//  GKTitleView
//
//  Created by 花菜ChrisCai on 2016/5/31.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "GKTitleView.h"
#import "GKVerticalButton.h"
/** 默认高度*/
static CGFloat const GKTitleHeight = 49;
/** 指示器默认颜色 */
#define GKTitleSelectColor [UIColor redColor]
/** 标题默认颜色 */
#define GKTilteCurrentColor [UIColor blackColor]
/** 标题高亮颜色 */
#define GKSelectedTilteColor GKIdicatorDefaultColor
/** 标题默认字体 */
#define GKTitleCurrentFont [UIFont systemFontOfSize:13]

@interface GKTitleView ()
/** 选中的label */
@property(nonatomic, weak) GKVerticalButton *selecteBtn;
/** 所有的标题label */
@property(nonatomic, strong) NSMutableArray *titleBtns;

@end
@implementation GKTitleView
#pragma mark -
#pragma mark - 初始化方法
+ (instancetype)titleView
{
    return [[self alloc] init];
}
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

- (void)setup
{
    self.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
}

#pragma mark -
#pragma mark - 懒加载

- (NSMutableArray *)titleBtns
{
    if (!_titleBtns) {
        _titleBtns =  [NSMutableArray array];
        
    }
    return _titleBtns;
}

#pragma mark -
#pragma mark - 重写set方法
- (void)setItems:(NSArray<UITabBarItem *> *)items
{
    // 解决重复赋值问题
    if (_items.count) {
        for (GKVerticalButton * btn in self.titleBtns) {
            [btn removeFromSuperview];
        }
        self.titleBtns = nil;
          }
    _items = items;
    
    for (UITabBarItem *item in items) {
        GKVerticalButton *btn = [[GKVerticalButton alloc]init];
        btn.tag = self.titleBtns.count;
        if (!btn.tag) {
            btn.selected = YES;
            self.selecteBtn = btn;
        }
       
        [btn setTitle:item.title forState:UIControlStateNormal];
        [btn setTitleColor:GKTilteCurrentColor forState:UIControlStateNormal];
        [btn setTitleColor:GKTitleSelectColor forState:UIControlStateSelected];
        [btn setImage:item.image forState:UIControlStateNormal];
        if (item.selectedImage) {
            [btn setImage:item.selectedImage forState:UIControlStateSelected];
        }
        [self.titleBtns addObject:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        btn.titleLabel.font = GKTitleCurrentFont;
        [self addSubview:btn];
    }
}

/**
 *  设置标题普通状态颜色
 */
- (void)setCurrentColor:(UIColor *)currentColor
{
    _currentColor = currentColor;
    for (GKVerticalButton *btn in self.titleBtns) {
        [btn setTitleColor:currentColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    for (GKVerticalButton *btn in self.titleBtns) {
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    }
}
/**
 *  设置标题字体
 */
- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    
    for (GKVerticalButton *btn in self.titleBtns) {
        btn.titleLabel.font = titleFont;
        [btn.titleLabel sizeToFit];
    }
    // label尺寸变化重新布局
    [self layoutIfNeeded];
}

#pragma mark -
#pragma mark - 尺寸位置
/**
 *  拦截外界设置高度,如果外界没有设置高度那么,默认高度为49
 */
- (void)setFrame:(CGRect)frame
{
    if (frame.size.height == 0) {
        
        frame.size.height = GKTitleHeight;
    }
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    if (bounds.size.height == 0) {
        
        bounds.size.height = GKTitleHeight;
    }
    [super setBounds:bounds];
}
#pragma mark -
#pragma mark - 逻辑事件
- (void)btnClick:(GKVerticalButton *)btn
{
    [self selectTitleAtIndex:btn.tag];
}

/**
 *  使对应索引标题被选中
 *
 */
- (void)selectTitleAtIndex:(NSInteger)index
{
    GKVerticalButton *btn = self.titleBtns[index];
    // 禁止重复点击
    if (self.selecteBtn == btn) return;
    // 切换状态
    [self checkTitleBtnState:btn];
    if (self.selcetedBlock) {
        self.selcetedBlock(btn.tag);
    }
    if ([self.delegate respondsToSelector:@selector(titleView:selectedTitleAtIndex:)]) {
        [self.delegate titleView:self selectedTitleAtIndex:btn.tag];
    }
    
}

/**
 *  选中第一个标题
 */
- (void)selectFirstTitle
{
    [self selectTitleAtIndex:0];
}

/**
 *  标题被点击时切换状态
 */
- (void)checkTitleBtnState:(GKVerticalButton *)btn
{
    // 切换状态
    self.selecteBtn.selected = NO;
    btn.selected =YES;
    self.selecteBtn = btn;
}

#pragma mark -
#pragma mark - 布局子控件
/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.items.count;
    CGFloat width = self.bounds.size.width / count;
    CGFloat height = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = width;
    CGFloat btnH = height;

    
    NSInteger index = 0;
    for (GKVerticalButton *btn in self.titleBtns) {
        if (index != 0) {
            GKVerticalButton *lastBtn = self.titleBtns[index - 1];
            btnX = CGRectGetMaxX(lastBtn.frame);
        }
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        index++;
    }
  }


@end

