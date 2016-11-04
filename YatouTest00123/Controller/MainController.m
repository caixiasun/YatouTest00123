//
//  MainController.m
//  YatouTest00123
//
//  Created by caixiasun on 16/10/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "MainController.h"
#import "Demo2Controller.h"
#import "Demo3Controller.h"
#import "ViewController.h"
#import "YTNavigationController.h"
#import "AnimationController.h"
#import "BluetoothController.h"
#import "MoreThreadController.h"

@interface MainController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray arrayWithObjects:@"日历",@"直播界面--强制某个界面横屏",@"高德地图demo",@"屏幕截图",@"帧动画",@"蓝牙连接测试",@"多线程", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"主视图";
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
        cell.textLabel.textColor = [UIColor blueColor];
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0://日历
        {
            Demo2Controller *vc = [Demo2Controller new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1://强制某个界面横屏
        {
            [self.navigationController pushViewController:[Demo3Controller new] animated:YES];
            break;
        }
        case 2://高德地图测试
        {
            [self.navigationController pushViewController:[ViewController new] animated:YES];
            break;
        }
        case 3://屏幕截图测试
        {
            break;
        }
        case 4://帧动画
        {
            [self.navigationController pushViewController:[AnimationController new] animated:YES];
            break;
        }
        case 5://蓝牙连接测试
        {
            [self.navigationController pushViewController:[BluetoothController new] animated:YES];
            break;
        }
        case 6://多线程
        {
            [self.navigationController pushViewController:[MoreThreadController new] animated:YES];
            break;
        }
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
