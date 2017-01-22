//
//  MainController.m
//  YatouTest00123
//
//  Created by caixiasun on 16/10/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "MainController.h"

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
    
    [self addCell:@"纯代码AutoLayout" Class:@"AutoLayoutCodeController"];
    [self addCell:@"OpenGL Demo" Class:@"GLKViewController"];
    [self addCell:@"Block使用" Class:@"BlockDemoController"];
    [self addCell:@"定位功能" Class:@"LocationController"];
    [self addCell:@"苹果内购" Class:@"InAppPurchaseController"];
    [self addCell:@"NSTimer相关" Class:@"TimerDemoController"];
    [self addCell:@"RuntimeDemo" Class:@"RuntimeDemoController"];
    [self addCell:@"汉字排序" Class:@"ChineseCharactersSortedController"];
    [self addCell:@"段落ParagraphStyle" Class:@"ParagraphStyleController"];
    [self addCell:@"正则表达式" Class:@"RegexController"];
    [self addCell:@"屏幕截屏" Class:@"ScreenShotController"];
    [self addCell:@"CollectionView使用" Class:@"CollectionViewDemo"];
    [self addCell:@"日历" Class:@"Demo2Controller"];
    [self addCell:@"直播界面--强制某个界面横屏" Class:@"Demo3Controller"];
    [self addCell:@"高德地图demo" Class:@"ViewController"];
    [self addCell:@"帧动画" Class:@"AnimationController"];
    [self addCell:@"蓝牙连接测试" Class:@"BluetoothController"];
    [self addCell:@"多线程" Class:@"MoreThreadController"];
    [self addCell:@"点击图像查看大图" Class:@"CheckLargeImageController"];
    [self addCell:@"View渐变色" Class:@"ViewGradientController"];
    [self addCell:@"从Plist中读取图片信息" Class:@"GetPicFromPlistController"];
    [self addCell:@"其他小知识" Class:@"OtherController"];
    [self addCell:@"直播送礼物动画" Class:@"PlaySendGiftController"];
    [self addCell:@"直播聊天cell设计" Class:@"PlayChatController"];
    [self addCell:@"UITableView相关属性" Class:@"MyTableViewDemoController"];
    [self addCell:@"Masonry相关" Class:@"MasonryDemoController"];
    [self addCell:@"UI控件相关效果" Class:@"UIDemoController"];
    [self addCell:@".a文件的使用" Class:@"AFileDemoController"];
    [self addCell:@"YYKit的基本使用" Class:@"YYKitDemoController"];
    [self addCell:@"动画相关" Class:@"AnimationDemo"];
    [self addCell:@"Define测试" Class:@"DefineDemo"];
}

- (void)addCell:(NSString *)title Class:(NSString *)className {
    [_cellTitles addObject:title];
    [_classNames addObject:className];
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
