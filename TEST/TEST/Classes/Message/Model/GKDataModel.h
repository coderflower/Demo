//
//  GKDataModel.h
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/8.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GKDataModel : NSObject
/** 用户名 */
@property(nonatomic, copy) NSString *username;
/** 文本内容 */
@property(nonatomic, copy) NSString *content;
/** 图片数组 */
@property(nonatomic, strong) NSArray *photos;
/** cell高度 */
@property(nonatomic, assign) CGFloat cellHeight;
@end
