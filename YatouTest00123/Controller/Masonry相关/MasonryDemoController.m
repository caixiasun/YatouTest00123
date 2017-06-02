//
//  MasonryDemoController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/30.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "MasonryDemoController.h"
#import "MasonryGetKeyboardHeightController.h"
#import "MasonryHeightCellController.h"

@interface MasonryDemoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation MasonryDemoController

static NSString *cellID = @"CellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
    
    self.titles = [NSMutableArray new];
    self.classNames = [NSMutableArray new];
    
    [self addCell:@"获取 键盘 高度" ClassName:@"MasonryGetKeyboardHeightController"];
    [self addCell:@"高度不定Cell" ClassName:@"MasonryHeightCellController"];
    [self addCell:@"mas_updateConstraints" ClassName:@"MasonryDemo01Controller"];
}

- (void)addCell:(NSString *)title ClassName:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *className = [self.classNames objectAtIndex:indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
