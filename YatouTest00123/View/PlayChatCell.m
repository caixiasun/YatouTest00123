//
//  PlayChatCell.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/23.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "PlayChatCell.h"
#import <Masonry.h>

#define kPlayChatCellMargin 3

@interface PlayChatCellLayout()

@property (nonatomic, assign) CGFloat width;

@end
@implementation PlayChatCellLayout

- (instancetype)initWithData:(PlayChatData *)data Cell_width:(CGFloat)width {
    if (!data) return nil;
    self = [super init];
    _data = data;
    _width = width;
    [self setup];
    return self;
}

- (void)setup {
    [self layoutName];
}

- (void)layoutName {
    NSMutableAttributedString *nameText = [[NSMutableAttributedString alloc] initWithString:@""];
    UIImage *blueVImage = [UIImage imageNamed:_data.hostImage];
    NSAttributedString *blueVText = [self _attachmentWithFontSize:35 image:blueVImage shrink:NO];
    UIImage *levelImage = [UIImage imageNamed:_data.levelImage];
    NSAttributedString *levelText = [self _attachmentWithFontSize:28 image:levelImage shrink:NO];
    
    [nameText appendString:_data.name];
//    [nameText appendAttributedString:blueVText];
//    [nameText appendAttributedString:levelText];
    [nameText appendString:@"："];
    [nameText appendString:_data.content];
    
    
    nameText.font = [UIFont systemFontOfSize:14];
    nameText.color = [UIColor whiteColor];
    nameText.lineBreakMode = NSLineBreakByCharWrapping;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(500, HUGE)];
    container.maximumNumberOfRows = 2;
    
    _textLayout = [YYTextLayout layoutWithContainer:container text:nameText];
    YYLabel *lab = [YYLabel new];
    lab.textLayout = _textLayout;
    _height = _textLayout.textBoundingSize.height;
    
}
- (NSAttributedString *)_attachmentWithFontSize:(CGFloat)fontSize image:(UIImage *)image shrink:(BOOL)shrink {

    // Heiti SC 字体。。
    CGFloat ascent = fontSize * 0.86;
    CGFloat descent = fontSize * 0.14;
    CGRect bounding = CGRectMake(0, -0.3 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);
    
    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;
    
    YYTextAttachment *attachment = [YYTextAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.content = image;
    
    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = UIEdgeInsetPixelFloor(contentInsets);
        attachment.contentInsets = contentInsets;
    }
    
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);
    
    return atr;
}

@end

@implementation PlayChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    _deviceImageView = [UIImageView new];
    [self addSubview:_deviceImageView];
    [_deviceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = kPlayChatCellMargin;
        make.top.equalTo(self);
    }];
    
    _nameLabel = [YYLabel new];
//    _nameLabel.size = CGSizeMake(self.height, self.width);
//    _nameLabel.left = 24;
//    _nameLabel.top = -16;
    _nameLabel.displaysAsynchronously = YES;
    _nameLabel.ignoreCommonProperties = YES;
    _nameLabel.fadeOnAsynchronouslyDisplay = NO;
    _nameLabel.fadeOnHighlight = NO;
    _nameLabel.lineBreakMode = NSLineBreakByClipping;
    [self addSubview:_nameLabel];
    _nameLabel.backgroundColor = [UIColor purpleColor];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_deviceImageView.mas_right).offset = 3;
        make.height.equalTo(self);
//        make.right.offset = 10;
    }];
    
}

-(void)setLayout:(PlayChatCellLayout *)layout {
    
    self.nameLabel.textLayout = layout.textLayout;
    self.nameLabel.height = layout.height;
    self.deviceImageView.image = [UIImage imageNamed:layout.data.deviceImage];
    self.cHeight = layout.height;
}

@end
