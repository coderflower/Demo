//
//  GKDiscoverViewCell.m
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/8.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKDiscoverViewCell.h"
#import "GKDataModel.h"
#import "NSString+GKExtension.h"
#import "GKPhotosView.h"
static CGFloat const margin = 20;
static NSString * const kDiscoverCellID = @"kDiscoverCellID";
@interface GKDiscoverViewCell ()
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *contentLabel;
@property (strong, nonatomic)  GKPhotosView *photosView;
/** 分割线 */
@property(nonatomic, strong) UIView *lineView;
@end
@implementation GKDiscoverViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    GKDiscoverViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kDiscoverCellID];
    if (cell == nil) {
        cell = [[GKDiscoverViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDiscoverCellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

/*!
 *  @author ChrisCai, 16-08-09
 *
 *  @brief 添加子控件
 */
- (void)setupSubviews {
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.photosView];
    [self addSubview:self.lineView];
}

#pragma mark -
#pragma mark - =============== 懒加载 ===============
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel =  [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}

- (GKPhotosView *)photosView {
    if (!_photosView) {
        _photosView =  [[GKPhotosView alloc] init];
    }
    return _photosView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel =  [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _contentLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView =  [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (void)setDataModel:(GKDataModel *)dataModel {
    _dataModel = dataModel;
    self.nameLabel.text = [NSString stringWithFormat:@"作者是: %@",dataModel.username];
    self.contentLabel.text = [NSString stringWithFormat:@"内容是: %@",dataModel.content];
    self.photosView.photos = dataModel.photos;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.nameLabel.frame = CGRectMake(0, margin, self.width, 21);
    CGFloat contentMaxWidth = kScreenWidth- margin * 2;
    CGSize contentSize = [self.dataModel.content gk_sizeWithFont:self.contentLabel.font maxWidth:contentMaxWidth];
    self.contentLabel.frame = CGRectMake(margin, self.nameLabel.maxY + margin, contentMaxWidth, contentSize.height);
    CGSize photosSize = [GKPhotosView sizeWithCount:(int)self.dataModel.photos.count];
    self.photosView.frame = CGRectMake(margin, self.contentLabel.maxY + margin, photosSize.width, photosSize.height);
    // 计算高度
    self.dataModel.cellHeight = self.photosView.maxY + margin;
    self.lineView.frame = CGRectMake(0,self.dataModel.cellHeight, self.width, 1);
}

@end
