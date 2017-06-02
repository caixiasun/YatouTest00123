//
//  CycleScrollController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/23.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "CycleScrollController.h"
#import <iCarousel.h>

@interface CycleScrollController ()<iCarouselDelegate, iCarouselDataSource>

@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, assign) CGSize cardSize;

@end

@implementation CycleScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(change)];
    self.navigationItem.rightBarButtonItem = item;
    
    
//    CGFloat cardWidth = [UIScreen mainScreen].bounds.size.width*5.0f/7.0f;
    self.cardSize = CGSizeMake(250, 200);
    self.view.backgroundColor = [UIColor blackColor];
    
    self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 100, Screen_Width, 200)];
    [self.view addSubview:self.carousel];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.type = iCarouselTypeRotary;
    self.carousel.bounceDistance = 10.0f;
    
}

- (void)change {
    static NSInteger index = 0;
    index ++;
    self.carousel.type = index;
    [self.carousel reloadData];
    if (index > 11) {
        index = 0;
    }
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 15;
}
- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return self.cardSize.width;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIView *cardView = view;
    
    if ( !cardView )
    {
        cardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.cardSize.width, self.cardSize.height)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:cardView.bounds];
        [cardView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor whiteColor];
        
        cardView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:imageView.frame cornerRadius:5.0f].CGPath;
        cardView.layer.shadowRadius = 3.0f;
        cardView.layer.shadowColor = [UIColor blackColor].CGColor;
        cardView.layer.shadowOpacity = 0.5f;
        cardView.layer.shadowOffset = CGSizeMake(0, 0);
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = imageView.bounds;
        layer.path = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:5.0f].CGPath;
        imageView.layer.mask = layer;
        
        //添加一个lbl
        UILabel *lbl = [[UILabel alloc] initWithFrame:cardView.bounds];
        lbl.text = [@(index) stringValue];
        [cardView addSubview:lbl];
        lbl.font = [UIFont boldSystemFontOfSize:200];
        lbl.textAlignment = NSTextAlignmentCenter;
    }
    
    return cardView;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    CGFloat scale = [self scaleByOffset:offset];
    CGFloat translation = [self translationByOffset:offset];
    
    return CATransform3DScale(CATransform3DTranslate(transform, translation * self.cardSize.width, 0, 0), scale, scale, 1.0f);
}

- (void)carouselDidScroll:(iCarousel *)carousel
{
    for ( UIView *view in carousel.visibleItemViews)
    {
        CGFloat offset = [carousel offsetForItemAtIndex:[carousel indexOfItemView:view]];
        
        if ( offset < -3.0 )
        {
            view.alpha = 0.0f;
        }
        else if ( offset < -2.0f)
        {
            view.alpha = offset + 3.0f;
        }
        else
        {
            view.alpha = 1.0f;
        }
    }
}

//形变是线性的就ok了
- (CGFloat)scaleByOffset:(CGFloat)offset
{
    return offset*0.04f + 1.0f;
}
//位移通过得到的公式来计算
- (CGFloat)translationByOffset:(CGFloat)offset
{
    CGFloat z = 5.0f/4.0f;
    CGFloat n = 5.0f/8.0f;
    
    //z/n是临界值 >=这个值时 我们就把itemView放到比较远的地方不让他显示在屏幕上就可以了
    if ( offset >= z/n )
    {
        return 2.0f;
    }
    
    return 1/(z-n*offset)-1/z;
}




@end
