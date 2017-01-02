//
//  MyTableViewDemoController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/30.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "MyTableViewDemoController.h"

@interface MyTableViewDemoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyTableViewDemoController

static NSString *cellID = @"CellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelection = NO;//设置是否响应cell的点击事件，默认为YES，若设置为NO，则点击cell时不会触发didSelectRowAtIndexPath方法。
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"第 %ld 行 被 点击 了 ..........",indexPath.row);
}

@end
