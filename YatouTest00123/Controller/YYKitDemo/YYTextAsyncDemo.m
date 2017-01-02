//
//  YYTextAsyncDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYTextAsyncDemo.h"

#define kCellHeight 40

@interface YYTextAsyncCell : UITableViewCell

@property (nonatomic, assign) BOOL async;

- (void)setAsyncText:(NSAttributedString *)text;

@end

@implementation YYTextAsyncCell
{
    UILabel *_uiLabel;
    YYLabel *_yyLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _uiLabel = [UILabel new];
        _uiLabel.size = CGSizeMake(kScreenWidth, kCellHeight);
        _uiLabel.numberOfLines = 0;
        _uiLabel.backgroundColor = [UIColor greenColor];
        _uiLabel.font = [UIFont systemFontOfSize:8];
        [self addSubview:_uiLabel];
        
        _yyLabel = [YYLabel new];
        _yyLabel.backgroundColor = [UIColor grayColor];
        _yyLabel.font = _uiLabel.font;
        _yyLabel.numberOfLines = 0;
        _yyLabel.size = _uiLabel.size;
        _yyLabel.displaysAsynchronously = NO;
        _yyLabel.hidden = YES;
        [self addSubview:_yyLabel];
        
    }
    return self;
}

- (void)setAsync:(BOOL)async {
    if (_async == async) return ;
    _async = async;
    _uiLabel.hidden = async;
    _yyLabel.hidden = !async;
}

- (void)setAsyncText:(id)text {
    if (_async) {
        _yyLabel.layer.contents = nil;
        _yyLabel.textLayout = text;
    }else {
        _uiLabel.attributedText = text;
    }
}

@end

@interface YYTextAsyncDemo ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *layouts;
@property (nonatomic, strong) NSArray *strings;
@property (nonatomic, assign) BOOL async;

@end

@implementation YYTextAsyncDemo

static NSString *cellIdentifier = @"YYTextAsyncCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(5, 150, kScreenWidth-10, kScreenHeight-160);
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.width = self.view.width * 0.9;
    tableView.centerX = self.view.centerX;
    [tableView registerClass:[YYTextAsyncCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:tableView];
    
    //datasource
    NSMutableArray *strings = [NSMutableArray new];
    NSMutableArray *layouts = [NSMutableArray new];
    for (int i=0; i<300; i++) {
        NSString *str = [NSString stringWithFormat:@"%d Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫",i];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        text.font = [UIFont systemFontOfSize:10];
        text.lineSpacing = 0;
        text.strokeWidth = @(-3);
        text.strokeColor = [UIColor redColor];
        text.lineHeightMultiple = 1;
        text.maximumLineHeight = 12;
        text.minimumLineHeight = 12;
        [strings addObject:text];
        
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, kCellHeight)];
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
        [layouts addObject:layout];
    }
    self.strings = strings;
    self.layouts = layouts;
    
    UISwitch *switcher = [UISwitch new];
    [switcher sizeToFit];
    switcher.top = 10+64;
    switcher.left = 10;
    __weak typeof(self) _self = self;
    [switcher addBlockForControlEvents:UIControlEventValueChanged block:^(UISwitch *switcher) {
        typeof(_self) self = _self;
        if (!self) return;
        [self setAsync:switcher.isOn];
    }];
    [self.view addSubview:switcher];
}

- (void)setAsync:(BOOL)async {
    _async = async;
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(YYTextAsyncCell *cell, NSUInteger idx, BOOL *stop) {
        cell.async = async;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        if (_async) {
            [cell setAsyncText:_layouts[indexPath.row]];
        } else {
            [cell setAsyncText:_strings[indexPath.row]];
        }
    }];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _strings.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYTextAsyncCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.async = _async;
    if (_async) {
        [cell setAsyncText:_layouts[indexPath.row]];
    }else {
        [cell setAsyncText:_strings[indexPath.row]];
    }
    return cell;
}

@end
