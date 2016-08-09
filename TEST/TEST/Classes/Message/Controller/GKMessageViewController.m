//
//  GKMessageViewController.m
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/8.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKMessageViewController.h"
#import "GKPlaceholderTextView.h"
#import "GKDataModel.h"
#import "GKPhotoViewController.h"
#import "GKPhoto.h"
@interface GKMessageViewController ()<GKPhotoViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet GKPlaceholderTextView *contentTextView;
/** 图片数组 */
@property(nonatomic, strong) NSMutableArray *photos;
@end

@implementation GKMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentTextView.placeholder = @"在这里输入说说内容";
}

- (NSMutableArray *)photos {
    if (!_photos) {
        _photos =  [[NSMutableArray alloc] init];
        
    }
    return _photos;
}
- (IBAction)pickImage:(UIButton *)sender {
    GKPhotoViewController * photoVc = [[GKPhotoViewController alloc]init];
    photoVc.delegate = self;
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:photoVc];
    
    [self presentViewController:nav animated:YES completion:nil];

}


- (IBAction)saveInToDB:(UIButton *)sender {
    
    GKDataModel * data = [[GKDataModel alloc]init];
    data.photos = [self.photos copy];
    data.username = self.usernameField.text;
    data.content = self.contentTextView.text;
    // 发通知
    [[NSNotificationCenter defaultCenter] postNotificationName:GKDidSaveDataSuccessNotification object:data];
    [MBProgressHUD showMessage:@"保存成功"];
    GKWeakSelf(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        weakself.usernameField.text = nil;
        weakself.contentTextView.text = nil;
        [self.photos removeAllObjects];
    });
}

- (void)photoViewController:(GKPhotoViewController *)photoViewController didEndSelectedPhotos:(NSArray<GKPhoto *> *)photos {
    for (GKPhoto * photo in photos) {
        if (self.photos.count >= 9) {
            break;
        }else {
            [self.photos addObject:photo.image];
        }
    }
}

@end
