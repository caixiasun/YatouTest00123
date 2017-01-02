//
//  CollectionViewDemoCell.h
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/2.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewDemoCellDelegate <NSObject>

@optional
- (void)deleteItem:(NSIndexPath *)indexPath;
- (void)longpressItem;

@end
@interface CollectionViewDemoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *deleteImgView;
@property (nonatomic, assign) id <CollectionViewDemoCellDelegate>delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)setContent:(NSString *)content;

@end
