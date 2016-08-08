//
//  NSObject+GKAlert.h
//  WeChat
//
//  Created by 花菜ChrisCai on 2016/8/7.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^alertBlock)(UIAlertAction *action);

@interface NSObject (GKAlert)

/*!
 *  @author ChrisCai, 16-08-07
 *
 *  @brief 快速创建弹窗
 *
 *  @param message           提示语
 *  @param firstActionTitle  第一个Action标题名
 *  @param firstHandler      第一个Action回调事件
 *  @param secondActionTitle 第二个Action标题名
 *  @param secondHandler     第二个Action回调事件
 */
- (void)showMessage:(NSString *)message firstActionTitle:(NSString *)firstActionTitle firstHandler:(alertBlock)firstHandler secondActionTitle:(NSString *)secondActionTitle secondHandler:(alertBlock)secondHandler;
/*!
 *  @author ChrisCai, 16-08-07
 *
 *  @brief 显示弹窗
 *
 *  @param message        提示语
 *  @param certainHandler 点击确定按钮回调
 *  @param cancelHandler  点击取消按钮回调
 */
- (void)showMessage:(NSString *)message certainHandler:(alertBlock)certainHandler cancelHandler:(alertBlock)cancelHandler;

/*!
 *  @author ChrisCai, 16-08-07
 *
 *  @brief 显示弹窗
 *
 *  @param message 提示语
 */
- (void)showMessage:(NSString *)message;
@end
