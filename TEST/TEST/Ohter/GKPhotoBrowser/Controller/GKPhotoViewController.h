//
//  GKPhotoViewController.h
//  GKPhotoBrowser
//
//  Created by 花菜ChrisCai on 2016/8/9.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
@class GKPhotoViewController,GKPhoto;
@protocol GKPhotoViewControllerDelegate<NSObject>
@optional
- (void)photoViewController:(GKPhotoViewController *)photoViewController didEndSelectedPhotos:(NSArray <GKPhoto *> *)photos;

@end
@interface GKPhotoViewController : UIViewController
/** 完成选择图片代理 */
@property(nonatomic, weak) id<GKPhotoViewControllerDelegate> delegate;
@end
