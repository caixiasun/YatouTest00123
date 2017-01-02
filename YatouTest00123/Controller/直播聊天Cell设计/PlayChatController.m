//
//  PlayChatController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/23.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "PlayChatController.h"
#import "PlayChatGiftCell.h"
#import "PlayChatSingleLevelCell.h"
#import "PlayChatHostCell.h"
#import <Masonry.h>
#import "PlayChatCell.h"

@interface PlayChatController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, strong) NSMutableArray *layouts;

@end

@implementation PlayChatController

static NSString *giftCellID = @"PlayChatGiftCell";
static NSString *hostCellID = @"PlayChatHostCell";
static NSString *chatCellID = @"PlayChatCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demo4_bg"]];
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = [UIColor clearColor];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableV];
    self.tableView = tableV;
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).multipliedBy(0.6);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset = -20;
        make.height.equalTo(self.view.mas_height).multipliedBy(0.4);
    }];
    
    [tableV registerNib:[UINib nibWithNibName:giftCellID bundle:nil] forCellReuseIdentifier:giftCellID];
//    [tableV registerNib:[UINib nibWithNibName:singleCellID bundle:nil] forCellReuseIdentifier:singleCellID];
    [tableV registerClass:[PlayChatCell class] forCellReuseIdentifier:chatCellID];
    [tableV registerNib:[UINib nibWithNibName:hostCellID bundle:nil] forCellReuseIdentifier:hostCellID];
    
    
    //发送聊天内容的
    UIView *chatV = [UIView new];
    chatV.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
    [self.view addSubview:chatV];
    chatV.layer.cornerRadius = 15;
    chatV.layer.masksToBounds = YES;
    [chatV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.top.offset = 70;
        make.width.equalTo(self.view.mas_width).multipliedBy(0.4);
        make.height.offset = 40;
    }];
    
    UITextField *tf = [UITextField new];
    tf.placeholder = @"输入聊天内容...";
    tf.font = [UIFont systemFontOfSize:14];
    tf.textColor = [UIColor whiteColor];
    [tf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [chatV addSubview:tf];
    self.textField = tf;
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 12;
        make.centerY.equalTo(chatV);
        make.width.equalTo(chatV.mas_width).multipliedBy(0.7);
    }];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.layer.borderColor = [UIColor greenColor].CGColor;
    sendBtn.layer.borderWidth = 0.8;
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    [chatV addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -3;
        make.height.equalTo(chatV.mas_height).multipliedBy(0.9);
        make.width.equalTo(chatV.mas_width).multipliedBy(0.2);
        make.centerY.equalTo(chatV);
    }];
    
    _rowNumber = 3;
    [self initLayouts];
}

- (void)sendAction {
    [self.textField endEditing:YES];
    if (self.textField.text.length > 0) {
        _rowNumber ++;
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_rowNumber-1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [self.tableView endUpdates];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_rowNumber-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        self.textField.text = @"";
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PlayChatGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:giftCellID forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 2){
        PlayChatHostCell *cell = [tableView dequeueReusableCellWithIdentifier:hostCellID forIndexPath:indexPath];
        return cell;
    }else{
        PlayChatCell *cell = [tableView dequeueReusableCellWithIdentifier:chatCellID forIndexPath:indexPath];
        [cell setLayout:_layouts[0]];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 2) {
        return 25;
    }else {
        return ((PlayChatCellLayout *)_layouts[0]).height;
    }
}

- (void)initLayouts {
    _layouts = [NSMutableArray new];
    for (int i=0; i<1; i++) {
        PlayChatData *data = [PlayChatData initWithDeviceImage:@"computer.png" Name:@"丫头" HostImage:@"host_level.png" LevelImage:@"wealth_level.png" Content:@"都是浪费大家建安费老大说减肥了杀了房间都是浪费大家啊老地方就放假哦IE奇偶"];
        PlayChatCellLayout *layout = [[PlayChatCellLayout alloc] initWithData:data Cell_width:self.view.width*0.6];
        [_layouts addObject:layout];
    }
    [self.tableView reloadData];
}

@end
