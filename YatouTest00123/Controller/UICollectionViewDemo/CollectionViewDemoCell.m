//
//  CollectionViewDemoCell.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/2.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "CollectionViewDemoCell.h"

@interface CollectionViewDemoCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titLabe;

@end
@implementation CollectionViewDemoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    UILongPressGestureRecognizer *longpressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [self addGestureRecognizer:longpressGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleGesture:)];
    [self.deleteImgView addGestureRecognizer:tapGesture];
}
- (IBAction)deleGesture:(UITapGestureRecognizer *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteItem:)]) {
        [self.delegate deleteItem:self.indexPath];
    }
}
- (IBAction)longPressGesture:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(longpressItem)]) {
        [self.delegate longpressItem];
    }
}

- (void)setContent:(NSString *)content {
    self.titLabe.text = content;
}

@end
