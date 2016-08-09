//
//  GKPhotoViewController.m
//  GKPhotoBrowser
//
//  Created by 花菜ChrisCai on 2016/8/9.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKPhotoViewController.h"
#import "GKWaterFlowLayout.h"
#import "GKPhotoViewCell.h"
#import "GKPhoto.h"
#import <Photos/Photos.h>
static NSString * const reuseIdentifier = @"Cell";

@interface GKPhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,GKWaterFlowLayoutDelegate>
/** 容器视图 */
@property(nonatomic, strong) UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *dataArray;
/** 被选中的图片对应的模型对象 */
@property (strong, nonatomic) NSMutableArray<GKPhoto *> *selectedPhotos;
@end

@implementation GKPhotoViewController

#pragma mark -
#pragma mark - =============== 生命周期方法 ===============
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化导航栏
    [self setupNav];
    // 添加内容视图
    [self.view addSubview:self.collectionView];
    // 获取图片
    self.dataArray = [self getThumbnailImages];
}

- (void)setupCollectionView {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[GKPhotoViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)setupNav {
    self.navigationItem.title = @"相册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleSelected)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completedSelected)];
}

#pragma mark - =============== 导航栏按钮事件处理 ===============
- (void)cancleSelected {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)completedSelected {
    
    if ([self.delegate respondsToSelector:@selector(photoViewController:didEndSelectedPhotos:)]) {
        [self.delegate photoViewController:self didEndSelectedPhotos:self.selectedPhotos];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - =============== 懒加载 ===============
- (NSMutableArray<GKPhoto *> *)selectedPhotos {
    
    if (!_selectedPhotos) {
        
        _selectedPhotos = [NSMutableArray array];
    }
    return _selectedPhotos;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        GKWaterFlowLayout * layout = [[GKWaterFlowLayout alloc]init];
        layout.delegate = self;
        _collectionView =  [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor yellowColor];
        [_collectionView registerClass:[GKPhotoViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark -
#pragma mark - =============== 相册图片获取 ===============
- (NSArray *)getThumbnailImages {
    // 获得所有的相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:NO];
    }
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    return [self enumerateAssetsInAssetCollection:cameraRoll original:NO];
}

/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (NSArray *)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original {
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    __block NSMutableArray * tempArray = [NSMutableArray array];
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        // 从asset中获得图片
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            GKPhoto * photo = [[GKPhoto alloc]init];
            photo.image = result;
            [tempArray addObject:photo];
        }];
    }
    return tempArray.copy;
}

#pragma mark -
#pragma mark - =============== UICollectionViewDataSource ===============

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GKPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    cell.photo = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark - =============== UICollectionViewDelegate ===============
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GKPhotoViewCell * cell = (GKPhotoViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    GKPhoto * photo = self.dataArray[indexPath.row];
    photo.checked = !photo.isChecked;
    if (self.selectedPhotos.count == 9 && cell.photo.isChecked) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"最多选取9张照片哦,亲!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    } else {
        cell.photo = photo;
        if (cell.photo.isChecked) { // 添加状态的
            [self.selectedPhotos addObject:photo];
        }else { // 移除非选中状态的
            [self.selectedPhotos removeObject:photo];
        }
    }
}

#pragma mark -
#pragma mark - =============== GKWaterFlowLayoutDelegate ===============
- (CGFloat)waterFlowLayout:(GKWaterFlowLayout *)waterFlowLayout heightForRowAtIndex:(NSInteger)index itemWidth:(CGFloat)width {
    // 高度 = (宽度 - 左变间距 - 右边间距 - (总列数 -1) * cell之间的间距) / 3  ==  cell的宽度
    return (self.collectionView.frame.size.width - 10 - 10 - (3 - 1) * 10) / 3;
}
@end




