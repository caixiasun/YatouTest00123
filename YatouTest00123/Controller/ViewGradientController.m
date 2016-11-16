//
//  ViewGradientController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/14.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "ViewGradientController.h"
#import "SimpleGradientController.h"
#import "CircleProgressController.h"

@interface ViewGradientController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewGradientController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray arrayWithObjects:@"简单view渐变色",@"圆环进度条渐变色", nil];
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[SimpleGradientController new] animated:YES];
            break;
        }
        case 1:
        {
            [self.navigationController pushViewController:[CircleProgressController new] animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
