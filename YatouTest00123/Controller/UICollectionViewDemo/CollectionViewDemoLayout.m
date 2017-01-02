//
//  CollectionViewDemoLayout.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/2.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "CollectionViewDemoLayout.h"

@implementation CollectionViewDemoLayout

- (NSMutableSet *)insertedItemsToAnimate {
    if (!_insertedItemsToAnimate) {
        _insertedItemsToAnimate = [[NSMutableSet alloc] init];
    }
    return _insertedItemsToAnimate;
}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems {
    [super prepareForCollectionViewUpdates:updateItems];
    
    for (UICollectionViewUpdateItem *updateItem in updateItems) {
        switch (updateItem.updateAction) {
            case UICollectionUpdateActionInsert:
            {
                [self.insertedItemsToAnimate addObject:updateItem.indexPathAfterUpdate];
                break;
            }
            default:
                break;
        }
    }
}

@end
