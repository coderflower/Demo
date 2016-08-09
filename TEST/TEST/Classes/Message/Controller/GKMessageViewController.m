//
//  GKMessageViewController.m
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/8.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKMessageViewController.h"
#import "GKDataModel.h"
@interface GKMessageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
/** 图片数组 */
@property(nonatomic, strong) NSMutableArray *photos;
@end

@implementation GKMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    if (self.photos.count >= 9) {
        [MBProgressHUD showError:@"最多只能添加九张照片哦"];
    } else {
        [self.photos addObject:image];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveInToDB:(UIButton *)sender {
    
    GKDataModel * data = [[GKDataModel alloc]init];
    data.photos = [self.photos copy];
    data.username = self.usernameField.text;
    data.content = self.contentTextView.text;
    // 发通知
    [[NSNotificationCenter defaultCenter] postNotificationName:GKDidSaveDataSuccessNotification object:data];
    [MBProgressHUD showMessage:@"保存成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
}

@end
