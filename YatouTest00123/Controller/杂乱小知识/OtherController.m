//
//  OtherController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/16.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "OtherController.h"

@interface OtherController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@property (nonatomic, strong) UITableView    *tableView;

@end

@implementation OtherController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitle:@"YTCADisplayLinkController" ClassName:@"YTCADisplayLinkController"];
    [self addTitle:@"YTInputDemoController" ClassName:@"YTInputDemoController"];
}

- (void)addTitle:(NSString *)title ClassName:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
    [self.tableView reloadData];
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class class = NSClassFromString([self.classNames objectAtIndex:indexPath.row]);
    if (class) {
        UIViewController *vc = class.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray new];
    }
    return _titles;
}
- (NSMutableArray *)classNames {
    if (!_classNames) {
        _classNames = [NSMutableArray new];
    }
    return _classNames;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
