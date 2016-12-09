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
#import "CheckLargeImageController.h"
#import "ViewGradientController.h"
#import "GetPicFromPlistController.h"
#import "OtherController.h"
#import "PlaySendGiftController.h"
#import "PlayChatController.h"
#import "MyTableViewDemoController.h"
#import "MasonryDemoController.h"
#import "UIDemoController.h"
#import "AFileDemoController.h"

@interface MainController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray arrayWithObjects:@"日历",@"直播界面--强制某个界面横屏",@"高德地图demo",@"屏幕截图",@"帧动画",@"蓝牙连接测试",@"多线程",@"点击图像查看大图",@"View渐变色",@"从Plist中读取图片信息",@"其他小知识",@"直播送礼物动画",@"直播聊天cell设计",@"UITableView相关属性",@"Masonry相关",@"UI控件相关效果",@".a文件的使用", nil];
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
        case 7://查看大图
        {
            [self.navigationController pushViewController:[CheckLargeImageController new] animated:YES];
            break;
        }
        case 8://view渐变色
        {
            [self.navigationController pushViewController:[ViewGradientController new] animated:YES];
            break;
        }
        case 9://从Plist中读取图片信息
        {
            [self.navigationController pushViewController:[GetPicFromPlistController new] animated:YES];
            break;
        }
        case 10://其他小知识
        {
            [self.navigationController pushViewController:[OtherController new] animated:YES];
            break;
        }
        case 11://直播送礼物动画
        {
            [self.navigationController pushViewController:[PlaySendGiftController new] animated:YES];
            break;
        }
        case 12://直播聊天cell设计
        {
            [self.navigationController pushViewController:[PlayChatController new] animated:YES];
            break;
        }
        case 13://UITableView相关属性
        {
            [self.navigationController pushViewController:[MyTableViewDemoController new] animated:YES];
            break;
        }
        case 14://Masonry相关
        {
            [self.navigationController pushViewController:[MasonryDemoController new] animated:YES];
            break;
        }
        case 15://UI控件相关效果
        {
            [self.navigationController pushViewController:[UIDemoController new] animated:YES];
        }
        case 16://.a文件的使用
        {
            [self.navigationController pushViewController:[AFileDemoController new] animated:YES];
            break;
        }
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
