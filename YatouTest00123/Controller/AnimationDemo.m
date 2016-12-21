//
//  AnimationDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "AnimationDemo.h"
#import "PictureMachine_AnimationController.h"

@interface AnimationDemo ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_cellTitles;
    NSMutableArray *_classNames;
}
@end

@implementation AnimationDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cellTitles = @[].mutableCopy;
    _classNames = @[].mutableCopy;
    
    [self addCell:@"改变图片颜色" Class:@"PictureMachine_AnimationController"];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PictureCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PictureCell"];
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
