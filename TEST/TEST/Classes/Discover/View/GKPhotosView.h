//
//  GKPhotosView.h
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/9.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKPhotosView : UIView
/** 图片数组 */
@property(nonatomic, strong) NSArray *photos;
/*!
 *  @author ChrisCai, 16-08-09
 *
 *  @brief 根据图片个数计算相册的尺寸
 *
 *  @return 相册的尺寸
 */
+ (CGSize)sizeWithCount:(int)count;
@end
