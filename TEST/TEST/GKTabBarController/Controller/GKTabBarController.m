//
//  GKTabBarController.m
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/8.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKTabBarController.h"
/** 标题栏的高度 */
CGFloat const kTabBarHeight = 49;
/** 导航条高度 */
CGFloat const kNavBarHeight = 64;
#define kScrollWidth self.view.frame.size.width
#define kScrollHeight self.view.frame.size.height
static NSString *const GKContainerCellID = @"containerCellID";

@interface GKTabBarController ()<GKTitleViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate,UIScrollViewDelegate>
/** 容器视图,用于存放子控制器的view */
@property(nonatomic, weak) UICollectionView *containerView;
// collectionView的布局
@property (strong, nonatomic) UICollectionViewFlowLayout *containerViewLayout;
/** 标题数组 */
@property(nonatomic,strong) NSMutableArray<UITabBarItem *> *items;

@end

@implementation GKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 触发懒加载
    self.containerView.backgroundColor = [UIColor whiteColor];
    // 添加底部工具条
    [self setupTitleBar];
    
    [self.containerView setContentOffset:CGPointZero animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark -
#pragma mark - 初始化
/**
 *  标题视图
 */
- (void)setupTitleBar
{
    GKTitleView *tabBar = [GKTitleView titleView];
    tabBar.delegate = self;
    [self.view addSubview:tabBar];
    _tabBar = tabBar;
}

#pragma mark -
#pragma mark - 懒加载
- (UICollectionView *)containerView {
    if (_containerView == nil) {
        UICollectionView *containerView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.containerViewLayout];
        containerView.pagingEnabled = YES;
        containerView.showsHorizontalScrollIndicator = NO;
        containerView.showsVerticalScrollIndicator = NO;
        containerView.delegate = self;
        containerView.dataSource = self;
        [containerView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:GKContainerCellID];
        containerView.bounces = NO;
        
        [self.view addSubview:containerView];
        _containerView = containerView;
    }
    return _containerView;
}

- (UICollectionViewFlowLayout *)containerViewLayout
{
    if (!_containerViewLayout) {
        UICollectionViewFlowLayout *containerViewLayout = [[UICollectionViewFlowLayout alloc] init];
        // 随便设置个不为CGSizeZero的值就可以,以免控制台输出
        // negative or zero item sizes are not supported in the flow layout
        containerViewLayout.itemSize = CGSizeMake(1, 1);
        containerViewLayout.minimumLineSpacing = 0;
        containerViewLayout.minimumInteritemSpacing = 0;
        containerViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _containerViewLayout = containerViewLayout;
        
    }
    return _containerViewLayout;
}

- (NSMutableArray<UITabBarItem *> *)items
{
    if (!_items) {
        _items =  [NSMutableArray array];
        
    }
    return _items;
}

#pragma mark -
#pragma mark - 布局子控件
/**
 *  布局子控件
 */
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect frame =  CGRectMake(0, kScrollHeight - kTabBarHeight, kScrollWidth,kTabBarHeight);
    _tabBar.frame = frame;
    
    CGRect containerFrame = CGRectMake(0, 0, kScrollWidth, kScrollHeight - kTabBarHeight);
    self.containerViewLayout.itemSize = containerFrame.size;
    self.containerView.frame = containerFrame;
}

- (void)addChildViewController:(UIViewController *)childController
{
    
    [self.items addObject:childController.tabBarItem];
    _tabBar.items = [self.items copy];
    [super addChildViewController:childController];
}
#pragma mark -
#pragma mark - 容器视图相关
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GKContainerCellID forIndexPath:indexPath];
    // 移除subviews 避免重用内容显示错误
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 这里建立子控制器和父控制器的关系
    // 这之前已经将对应的子控制器添加到了父控制器了, 只不过还没有建立完成
    UIViewController *vc = self.childViewControllers[indexPath.item];
    vc.view.frame = cell.bounds;
    [cell.contentView addSubview:vc.view];
    //    [vc didMoveToParentViewController:self];
    return cell;
}



#pragma mark -
#pragma mark - UIScrollViewDelegate
/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/**
 * scrollView结束了滚动动画以后就会调用这个方法
 *（- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;执行的动画完毕后）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获取当前偏移量
    CGPoint offset = scrollView.contentOffset;
    
    // 获取需要显示的控制器的索引
    NSInteger index = offset.x / scrollView.bounds.size.width;
    // 让标题栏随动
    [self.tabBar selectTitleAtIndex:index];
}

#pragma mark -
#pragma mark - GKTitleViewDelegate
- (void)titleView:(GKTitleView *)titleView selectedTitleAtIndex:(NSInteger)index
{
    
    CGPoint offset = self.containerView.contentOffset;
    
    offset.x = index * self.containerView.bounds.size.width;
    [self.containerView setContentOffset:offset animated:NO];
}

/**
 *  获取该视图的控制器
 */
- (UIViewController*)viewController:(UIView *)view
{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


@end
