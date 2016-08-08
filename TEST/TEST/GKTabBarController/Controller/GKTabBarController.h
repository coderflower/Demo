//
//  GKTabBarController.h
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/8.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKTitleView.h"
@interface GKTabBarController : UIViewController
/** 标题栏 */
@property(nonatomic, weak,readonly) GKTitleView *tabBar;
@end
