//
//  NSObject+GKAlert.m
//  WeChat
//
//  Created by 花菜ChrisCai on 2016/8/7.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "NSObject+GKAlert.h"

@implementation NSObject (GKAlert)
- (void)showMessage:(NSString *)message {
    [self showMessage:message certainHandler:nil cancelHandler:nil];
}

- (void)showMessage:(NSString *)message certainHandler:(alertBlock)certainHandler cancelHandler:(alertBlock)cancelHandler {
    [self showMessage:message firstActionTitle:@"确定" firstHandler:certainHandler secondActionTitle:@"取消" secondHandler:cancelHandler];
}

- (void)showMessage:(NSString *)message firstActionTitle:(NSString *)firstActionTitle firstHandler:(alertBlock)firstHandler secondActionTitle:(NSString *)secondActionTitle secondHandler:(alertBlock)secondHandler {
    // 创建弹窗控制器
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    // 添加确定按钮
    [alert addAction:[UIAlertAction actionWithTitle:firstActionTitle style:UIAlertActionStyleDefault handler:firstHandler]];
    // 添加取消按钮
    [alert addAction:[UIAlertAction actionWithTitle:secondActionTitle style:UIAlertActionStyleCancel handler:secondHandler]];
    // 显示弹窗
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end
