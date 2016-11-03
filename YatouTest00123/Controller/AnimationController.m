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
    for (int i=1; i<101; i++) {
        if (i > 9) {
            if (i < 100) {
                zero = @"00";
            }else {
                zero = @"0";
            }
        }
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"气球%@%d.png",zero,i]];
        [pngArray addObject:img];
    }
    self.pngImageView.image = [UIImage imageNamed:@"气球0001.png"];
    self.pngImageView.animationDuration = pngArray.count * 0.16;
    self.pngImageView.animationImages = pngArray;
    
    
    NSMutableArray *gifArray = [NSMutableArray new];
    NSString *zero2 = @"000";
    for (int i=1; i<101; i++) {
        if (i > 9) {
            if (i < 100) {
                zero2 = @"00";
            }else {
                zero2 = @"0";
            }
        }
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"气球%@%d.gif",zero2,i]];
        [pngArray addObject:img];
    }
    self.gifImageView.image = [UIImage imageNamed:@"气球0001.gif"];
    self.gifImageView.animationDuration = gifArray.count * 0.16;
    self.gifImageView.animationImages = gifArray;
    
    
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
