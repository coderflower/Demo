//
//  GKWaterFlowLayout.h
//  瀑布流DEMO
//
//  Created by 花菜ChrisCai on 2016/6/15.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GKWaterFlowLayout;

@protocol GKWaterFlowLayoutDelegate <NSObject>
@required
/**
 *  决定cell的高度必须实现
 *
 *  @param waterFlowLayout
 *  @param index           <#index description#>
 *  @param width           <#width description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)waterFlowLayout:(GKWaterFlowLayout *)waterFlowLayout heightForRowAtIndex:(NSInteger)index itemWidth:(CGFloat)width;
@optional
///决定cell的列数
- (NSInteger)waterFlowLayoutCloumnCount:(GKWaterFlowLayout *)waterFlowLayout;
///决定cell 的列的距离
- (CGFloat)waterFlowLayoutColumMargin:(GKWaterFlowLayout *)waterFlowLayout;
///决定cell 的行的距离
- (CGFloat)waterFlowLayoutRowMargin:(GKWaterFlowLayout *)waterFlowLayout;
///决定cell 的边缘间距
- (UIEdgeInsets)waterFlowLayoutEdgeInset:(GKWaterFlowLayout *)waterFlowLayout;

@end

@interface GKWaterFlowLayout : UICollectionViewLayout
/** 代理 */
@property(nonatomic, weak) id<GKWaterFlowLayoutDelegate> delegate;
- (NSInteger)colCount;
- (CGFloat)colMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)currentEdgeInsets;
@end
