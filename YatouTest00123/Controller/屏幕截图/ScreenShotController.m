//
//  ScreenShotController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/2.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "ScreenShotController.h"

@interface ScreenShotController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *shotImage;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@end

@implementation ScreenShotController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"截屏" style:UIBarButtonItemStylePlain target:self action:@selector(barItemAction:)];
    self.navigationItem.rightBarButtonItem = item;
    self.rightItem = item;
    
    
}

- (void)barItemAction:(UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"截屏"]) {
        self.shotImage = [self imageWithView1:self.view];
        item.title = @"查看截图";
    }else {
        self.imageView.image = self.shotImage;
        self.imageView.hidden = NO;
    }
}
- (IBAction)imageViewTapGesture:(id)sender {
    self.rightItem.title = @"截屏";
    self.imageView.hidden = YES;
}

//方法一、无导航栏，全屏
- (UIImage *)imageWithView1:(UIView *)view{
    UIImage *img;
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
