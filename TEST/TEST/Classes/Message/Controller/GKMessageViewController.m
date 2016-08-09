//
//  GKMessageViewController.m
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/8.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKMessageViewController.h"
#import "NSObject+GKAlert.h"
#import "MBProgressHUD+Extension.h"
#import "GKDataModel.h"
#import "GKDatabase.h"
@interface GKMessageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
/** 图片数组 */
@property(nonatomic, strong) NSMutableArray *photos;
@end

@implementation GKMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建表格
    [[GKDatabaseManager sharedManager] creatTableWithClassName:[GKDataModel class]];
}

- (NSMutableArray *)photos {
    if (!_photos) {
        _photos =  [[NSMutableArray alloc] init];
        
    }
    return _photos;
}
- (IBAction)pickImage:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    picker.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    __weak typeof(self) weakself = self;
    if (self.photos.count > 9) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 防止耗时操作执行完毕前weakself被提前释放
        __strong typeof(weakself) strongself = weakself;
        NSData * imageData = UIImagePNGRepresentation(image);
        // base64编码
        NSString * imageStr = [imageData base64EncodedStringWithOptions:0];
        [strongself.photos addObject:imageStr];
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveInToDB:(UIButton *)sender {
    
    GKDataModel * data = [[GKDataModel alloc]init];
    data.photos = [self.photos copy];
    data.username = self.usernameField.text;
    data.content = self.contentTextView.text;
    // 插入数据
    [[GKDatabaseManager sharedManager]insertDataFromObject:data];
}

@end
