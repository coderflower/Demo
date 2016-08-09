//
//  GKDiscoverViewCell.h
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/8.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKDataModel;
@interface GKDiscoverViewCell : UITableViewCell
/** 模型数据 */
@property(nonatomic, strong) GKDataModel *dataModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
