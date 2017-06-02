//
//  MasonryHeightCellController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/15.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "MasonryHeightCellController.h"
#import "MasonryCell.h"

@interface MasonryHeightCellController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MasonryHeightCellController

static NSString *cellID = @"CellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[MasonryCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitHeight(200);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasonryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell setContent:nil];
    return cell;
}

@end
