//
//  GKTitleView.h
//  GKTitleView
//
//  Created by 花菜ChrisCai on 2016/5/31.
//  Copyright © 2016年 Chris. All rights reserved.
//  标题栏封装



/**
 *  必须要传递标题数组
 *  标题默认颜色为黑色
 *  标题高亮颜色和指示器颜色一致,如果没有设置默认为红色
 *  高度如果不设置默认为44
 */
#import <UIKit/UIKit.h>

@class GKTitleView;
@protocol GKTitleViewDelegate <NSObject>

@optional
/**
 *  选中某个标题时调用
 *  @param index     被选中标题的索引
 */
- (void)titleView:(GKTitleView *_Nullable)titleView selectedTitleAtIndex:(NSInteger)index;
@end

typedef void(^titleClickBlock)(NSInteger index);

@interface GKTitleView : UIView
/** 标题数组 */
@property(nullable,nonatomic,copy) NSArray<UITabBarItem *> *items;
/** 标题高亮颜色 */
@property(nullable,nonatomic, strong) UIColor *selectedColor;
/** 标题普通颜色 */
@property(nullable,nonatomic, strong) UIColor *currentColor;
/** 标题字体 */
@property(nullable,nonatomic, strong) UIFont *titleFont;
/** 代理监听标题点击事件 */
@property(nullable,nonatomic, weak) id<GKTitleViewDelegate> delegate;
/** 选中标题回调 */
@property(nullable,nonatomic, copy) titleClickBlock selcetedBlock;


/**
 *  使对应索引的标题被选中
 *  代理空时不会调用代理方法,block也一样
 *  @param index    索引
 */
- (void)selectTitleAtIndex:(NSInteger)index;

/**
 *  选中第一个标题,默认有动画效果
 *  代理空时不会调用代理方法,block也一样
 */
- (void)selectFirstTitle;

/**
 *  快速创建标题控件
 *
 *  @return GKSildeView
 */
+ (nullable instancetype)titleView;
@end
