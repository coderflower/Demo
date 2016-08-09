//
//  GKDiscoverViewController.m
//  TEST
//
//  Created by 花菜ChrisCai on 2016/8/8.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKDiscoverViewController.h"
#import "GKDataModel.h"
#import "GKDiscoverViewCell.h"

@interface GKDiscoverViewController ()
/** 数据源 */
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation GKDiscoverViewController

- (instancetype)init {
    if (self = [super init]) {
        [self setupNotification];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.contentInsetBottom = 49;
}

- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSaveSuccess:) name:GKDidSaveDataSuccessNotification object:nil];
}

- (void)didSaveSuccess:(NSNotification *)noti {
    [self.dataSource addObject:noti.object];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource =  [[NSMutableArray alloc] init];
        
    }
    return _dataSource;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GKDiscoverViewCell *cell = [GKDiscoverViewCell cellWithTableView:tableView];

    cell.dataModel = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark - =============== UITableViewDelegate ===============
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    GKDataModel * model = self.dataSource[indexPath.row];
    
    return model.cellHeight;
}

#warning 手势冲突,待解决
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GKDataModel * model = self.dataSource[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource removeObject:model];
        [self.tableView reloadData];
    }
}

@end
