//
//  GKMainViewController.m
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/8.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKMainViewController.h"
#import "GKMessageViewController.h"
#import "GKDiscoverViewController.h"
@interface GKMainViewController ()

@end

@implementation GKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupAllChildViewControllers];
}

- (void)setupAllChildViewControllers {
    
    [self addChildViewController:[[GKMessageViewController alloc]init] withTitle:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_highlighted"];
    
    [self addChildViewController:[[GKDiscoverViewController alloc]init] withTitle:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_highlighted"];

}

// 登陆后的导航控制器
- (void)addChildViewController:(UIViewController *)childVC withTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置控制器的标题
    childVC.title = title;
    
    // 设置tabBarItem图片 ,禁用渲染
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 为子控制器包装导航控制器
    
    UINavigationController *NaviVC = [[UINavigationController alloc]initWithRootViewController:childVC];
    
    // 添加子控制器
    [self addChildViewController:NaviVC];
    
}


@end
