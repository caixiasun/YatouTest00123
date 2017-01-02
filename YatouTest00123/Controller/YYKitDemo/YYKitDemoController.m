//
//  YYKitDemoController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYKitDemoController.h"
#import "YYTextDemo.h"

@interface YYKitDemoController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *_classNames;
    NSMutableArray *_cellTitles;
}

@end

@implementation YYKitDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"YYKit的基本使用";
    _classNames = @[].mutableCopy;
    _cellTitles = @[].mutableCopy;
    
    [self addCell:@"YYText" Class:@"YYTextDemo"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    
}

- (void)addCell:(NSString *)title Class:(NSString *)className {
    [_cellTitles addObject:title];
    [_classNames addObject:className];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellTitles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYKitCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YYKitCell"];
    }
    cell.textLabel.text = _cellTitles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = _classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
        vc.title = _cellTitles[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
