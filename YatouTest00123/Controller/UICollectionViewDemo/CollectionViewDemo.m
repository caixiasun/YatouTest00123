//
//  CollectionViewDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "CollectionViewDemo.h"
#import "CollectionViewDemoCell.h"
#import "CollectionViewDemoLayout.h"

@interface CollectionViewDemo ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CollectionViewDemoCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isLongpress;
@property (nonatomic, strong) UIBarButtonItem *barRightItem;
@property (nonatomic, strong) CollectionViewDemoLayout *animaLayout;
@end

@implementation CollectionViewDemo

static NSString *const cellId = @"CollectionViewDemoCell";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CollectionViewDemoLayout *layout = [CollectionViewDemoLayout new];
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(30, 20, 30, 20);
    self.animaLayout = layout;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor yellowColor];
    [collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    for (int i=0; i<3; i++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"第%d个Item",i]];
    }
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(barItemBtnClick:)];
    self.navigationItem.rightBarButtonItem = btnItem;
    self.barRightItem = btnItem;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

// 添加（插入item）
- (void)barItemBtnClick:(UIBarButtonItem *)btnItem
{
    if ([btnItem.title isEqualToString:@"添加"]) {
        [_collectionView performBatchUpdates:^{
            // 构造一个indexPath
            NSIndexPath *indePath = [NSIndexPath indexPathForItem:_dataSource.count inSection:0];
            [_collectionView insertItemsAtIndexPaths:@[indePath]]; // 然后在此indexPath处插入给collectionView插入一个item
            [_dataSource addObject:[NSString stringWithFormat:@"刚刚插入的行：%ld",_dataSource.count-1]]; // 保持collectionView的item和数据源一致
        } completion:nil];
    }else {
        btnItem.title = @"添加";
        _isLongpress = NO;
        [self.collectionView reloadData];
    }
    
}

#pragma mark - 协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewDemoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.deleteImgView.hidden = !_isLongpress;
    [cell setContent:[self.dataSource objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - cell delegate
- (void)deleteItem:(NSIndexPath *)indexPath {
    [self.dataSource removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
    if (self.dataSource.count == 0) {
        self.barRightItem.title = @"添加";
        _isLongpress = NO;
    }
}
- (void)longpressItem {
    if (!_isLongpress) {
        _isLongpress = YES;
        self.barRightItem.title = @"取消";
        [self.collectionView reloadData];
    }
}


@end
