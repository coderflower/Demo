//
//  GKPhoto.h
//  GKPhotoBrowser
//
//  Created by 花菜ChrisCai on 2016/8/9.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKPhoto : NSObject
/** 图片 */
@property(nonatomic, strong) UIImage *image;
/** 选中状态 */
@property(nonatomic, assign, getter=isChecked) BOOL checked;
@end
