//
//  AnimationController.m
//  YatouTest00123
//
//  Created by caixiasun on 16/10/27.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "AnimationController.h"
#import <ImageIO/ImageIO.h>

@interface AnimationController ()
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pngImageView;
@property (nonatomic, assign) CGSize size;

@end

@implementation AnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.gifImageView.layer.borderColor = [UIColor redColor].CGColor;
    self.gifImageView.layer.borderWidth = 0.5;
    
    self.pngImageView.layer.borderWidth = 0.5;
    self.pngImageView.layer.borderColor = [UIColor redColor].CGColor;
    
    
    
    NSMutableArray *pngArray = [NSMutableArray new];
    NSString *zero = @"000";
    NSInteger count = 55;
    for (int i=1; i<count+1; i++) {
        if (i > 9) {
            
            zero = @"00";
        }
        UIImage *img = [self getImageFromBundle:[NSString stringWithFormat:@"web气球%@%d",zero,i]];
        [pngArray addObject:img];
    }
    self.pngImageView.image = [self getImageFromBundle:@"web气球0001"];
    self.pngImageView.animationDuration = pngArray.count * 0.16;
    self.pngImageView.animationImages = pngArray;
}

//从Bundle中读取图片
- (UIImage *)getImageFromBundle:(NSString *)imageName {
    NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"images.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *imgPath = [bundle pathForResource:[NSString stringWithFormat:@"web_png/%@",imageName] ofType:@"png"];
    return [UIImage imageWithContentsOfFile:imgPath];
}

- (IBAction)gifAction:(id)sender {
    self.gifImageView.hidden = NO;
    self.pngImageView.hidden = YES;
    
    [self.pngImageView stopAnimating];
    
    [self giftInit];
    
    [self.gifImageView startAnimating];
    
}
- (IBAction)pngAction:(id)sender {
    self.gifImageView.hidden = YES;
    self.pngImageView.hidden = NO;
    
    [self.pngImageView startAnimating];
    [self.gifImageView stopAnimating];
}

- (void)giftInit {
    NSString *imagePath =[[NSBundle mainBundle] pathForResource:@"png" ofType:@"png"];
    CGImageSourceRef  cImageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:imagePath], NULL);
    size_t imageCount = CGImageSourceGetCount(cImageSource);
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:imageCount];
    NSMutableArray *times = [[NSMutableArray alloc] initWithCapacity:imageCount];
    NSMutableArray *keyTimes = [[NSMutableArray alloc] initWithCapacity:imageCount];
    
    float totalTime = 0;
    for (size_t i = 0; i < imageCount; i++) {
        CGImageRef cgimage= CGImageSourceCreateImageAtIndex(cImageSource, i, NULL);
        [images addObject:(__bridge id)cgimage];
        CGImageRelease(cgimage);
        
        NSDictionary *properties = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(cImageSource, i, NULL);
        NSDictionary *gifProperties = [properties valueForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        NSString *gifDelayTime = [gifProperties valueForKey:(__bridge NSString* )kCGImagePropertyGIFDelayTime];
        [times addObject:gifDelayTime];
        totalTime += [gifDelayTime floatValue];
        
        _size.width = [[properties valueForKey:(NSString*)kCGImagePropertyPixelWidth] floatValue];
        _size.height = [[properties valueForKey:(NSString*)kCGImagePropertyPixelHeight] floatValue];
    }
    
    float currentTime = 0;
    for (size_t i = 0; i < times.count; i++) {
        float keyTime = currentTime / totalTime;
        [keyTimes addObject:[NSNumber numberWithFloat:keyTime]];
        currentTime += [[times objectAtIndex:i] floatValue];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setValues:images];
    [animation setKeyTimes:keyTimes];
    animation.duration = totalTime;
    animation.repeatCount = HUGE_VALF;
    [self.gifImageView.layer addAnimation:animation forKey:@"gifAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
