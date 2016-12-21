//
//  YYTextDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYTextDemo.h"
#import "YYTextAttributeDemo.h"
#import "YYTextTagDemo.h"
#import "YYAttachmentDemo.h"
#import "YYTextEditDemo.h"
#import "YYTextSimpleMarkdownParserDemo.h"
#import "YYTextEmoticonDemo.h"
#import "YYTextBindDemo.h"
#import "YYTextCopyPasteExample.h"
#import "YYTextUndoRedoDemo.h"
#import "YYTextRubyDemo.h"
#import "YYTextAsyncDemo.h"

@interface YYTextDemo ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_cellTitles;
    NSMutableArray *_classNames;
}

@end

@implementation YYTextDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cellTitles = @[].mutableCopy;
    _classNames = @[].mutableCopy;
    
    [self addCell:@"YYTextAttribute" Class:@"YYTextAttributeDemo"];
    [self addCell:@"YYTextTag" Class:@"YYTextTagDemo"];
    [self addCell:@"YYAttachment" Class:@"YYAttachmentDemo"];
    [self addCell:@"YYTextEdit" Class:@"YYTextEditDemo"];
    [self addCell:@"YYTextSimpleMarkdownParser" Class:@"YYTextSimpleMarkdownParserDemo"];
    [self addCell:@"YYTextEmoticon" Class:@"YYTextEmoticonDemo"];
    [self addCell:@"YYTextBind" Class:@"YYTextBindDemo"];
    [self addCell:@"YYTextCopyPaste" Class:@"YYTextCopyPasteExample"];
    [self addCell:@"YYTextUndoRedo" Class:@"YYTextUndoRedoDemo"];
    [self addCell:@"YYTextRuby" Class:@"YYTextRubyDemo"];
    [self addCell:@"YYTextAsync" Class:@"YYTextAsyncDemo"];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYTextCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YYTextCell"];
    }
    cell.textLabel.text = _cellTitles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *className = _classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
        vc.title = className;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
