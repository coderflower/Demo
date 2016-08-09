//
//  GKPhotoViewCell.h
//  GKPhotoBrowser
//
//  Created by 花菜ChrisCai on 2016/8/9.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKPhoto;
@interface GKPhotoViewCell : UICollectionViewCell
/** 模型数据 */
@property(nonatomic, strong) GKPhoto *photo;
@end
