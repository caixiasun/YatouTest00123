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
#import "YYKitDemoController.h"
#import "AnimationDemo.h"

@interface MainController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_cellTitles;
    NSMutableArray *_classNames;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"主视图";

    _cellTitles = @[].mutableCopy;
    _classNames = @[].mutableCopy;
    
    NSDictionary *classDic = [NSDictionary dictionaryWithObjectsAndKeys:@"日历",@"Demo2Controller",@"直播界面--强制某个界面横屏",@"Demo3Controller",@"高德地图demo",@"ViewController",@"屏幕截图",@"",@"帧动画",@"AnimationController",@"蓝牙连接测试",@"BluetoothController",@"多线程",@"MoreThreadController",@"点击图像查看大图",@"CheckLargeImageController",@"View渐变色",@"ViewGradientController",@"从Plist中读取图片信息",@"GetPicFromPlistController",@"其他小知识",@"OtherController",@"直播送礼物动画",@"PlaySendGiftController",@"直播聊天cell设计",@"PlayChatController",@"UITableView相关属性",@"MyTableViewDemoController",@"Masonry相关",@"MasonryDemoController",@"UI控件相关效果",@"UIDemoController",@".a文件的使用",@"AFileDemoController",@"YYKit的基本使用",@"YYKitDemoController",@"动画相关",@"AnimationDemo", nil];
    
    for (NSString *key in classDic.allKeys) {
        [_cellTitles addObject:[classDic objectForKey:key]];
        [_classNames addObject:key];
    }

}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
        cell.textLabel.textColor = [UIColor blueColor];
    }
    cell.textLabel.text = [_cellTitles objectAtIndex:indexPath.row];
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
