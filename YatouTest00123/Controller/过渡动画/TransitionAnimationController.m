//
//  TransitionAnimationController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/6.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "TransitionAnimationController.h"

@interface TransitionAnimationController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TransitionAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    self.dataSource = [NSMutableArray new];
    [self.dataSource addObject:@"FlipPresentAnimationController"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = [self.dataSource objectAtIndex:indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
}




@end
