//
//  CustomView_GetKeyboardHeight_Masonry.h
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/30.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomView_GetKeyboardHeight_MasonryDelegate;
@interface CustomView_GetKeyboardHeight_Masonry : UIView

@property (nonatomic, assign) id<CustomView_GetKeyboardHeight_MasonryDelegate>delegate;

+ (CustomView_GetKeyboardHeight_Masonry *)createViewInView:(UIView *)inView Delegate:(id)delegate;

@end

@protocol CustomView_GetKeyboardHeight_MasonryDelegate <NSObject>

- (void)close;

@end
