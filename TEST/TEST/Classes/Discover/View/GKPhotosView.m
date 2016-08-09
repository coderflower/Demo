//
//  GKPhotosView.m
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/9.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKPhotosView.h"
static CGFloat const kPhotoWidth = 70;
static CGFloat const kPhotoMargin = 10;
#define kPhotosMaxColumn(count) ((count == 4)? 2:3)
@implementation GKPhotosView

- (void)setPhotos:(NSArray *)photos {
    _photos = photos;
    
    // 创建足够数量的图片控件
    while (self.subviews.count < photos.count) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
    }
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        if (i < photos.count) { // 显示
            imageView.image = photos[i];
            imageView.hidden = NO;
        } else { // 隐藏
            imageView.hidden = YES;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置图片的尺寸和位置
    int photosCount = (int)self.photos.count;
    int maxCol = kPhotosMaxColumn(photosCount);
    for (int i = 0; i<photosCount; i++) {
        UIImageView *imageView = self.subviews[i];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        int col = i % maxCol;
        imageView.x = col * (kPhotoWidth + kPhotoMargin);
        int row = i / maxCol;
        imageView.y = row * (kPhotoWidth + kPhotoMargin);
        imageView.width = kPhotoWidth;
        imageView.height = kPhotoWidth;
    }

}

+ (CGSize)sizeWithCount:(int)count {
    // 最大列数（一行最多有多少列）
    int maxCols = kPhotosMaxColumn(count);
    
    int cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * kPhotoWidth + (cols - 1) * kPhotoMargin;
    
    // 行数
    int rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * kPhotoWidth + (rows - 1) * kPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
@end
