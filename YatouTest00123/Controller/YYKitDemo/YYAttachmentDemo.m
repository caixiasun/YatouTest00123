//
//  YYAttachmentDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYAttachmentDemo.h"

@interface YYAttachmentDemo ()

@end

@implementation YYAttachmentDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:16];
    {
        NSString *title = @"UIImage attachment";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title]];
        
        UIImage *image = [UIImage imageNamed:@"dribbble64_imageio"];
        image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
        [text appendString:@"\n"];
    }
    {
        NSString *title = @"UIView attachment";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title]];
        
        UISwitch *switcher = [UISwitch new];
        [switcher sizeToFit];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:switcher contentMode:UIViewContentModeCenter attachmentSize:switcher.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
        [text appendString:@"\n"];
    }
    {
        NSString *title = @"Animated Image attachment";
        [text appendString:title];
        
        NSArray *names = @[@"001",@"006",@"009",@"011",@"066"];
        for (NSString *name in names) {
            NSString *path = [[NSBundle mainBundle] pathForScaledResource:name ofType:@"gif" inDirectory:@"EmoticonQQ.bundle"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            YYImage *image = [YYImage imageWithData:data scale:2];
            image.preloadAllAnimatedImageFrames = YES;
            YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
            NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [text appendAttributedString:attachText];
        }
        
        YYImage *image = [YYImage imageNamed:@"pia"];
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
        [imageView startAnimating];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
        [text appendString:@"\n"];
    }
    text.font = font;
    YYLabel *myLabel = [YYLabel new];
    myLabel.size = CGSizeMake(300, 300);
    myLabel.numberOfLines = 0;
    myLabel.attributedText = text;
    myLabel.center = self.view.center;
    myLabel.layer.borderColor = [UIColor redColor].CGColor;
    myLabel.layer.borderWidth = 0.5;
    myLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    [self.view addSubview:myLabel];
    
    YYGestureRecognizer *gesture = [YYGestureRecognizer new];
    gesture.action = ^(YYGestureRecognizer *gesture, YYGestureRecognizerState state) {
        
        if (state == YYGestureRecognizerStateBegan) {
            DLog(@"___________Began");
        }else if (state == YYGestureRecognizerStateMoved) {
            DLog(@"___________Moved");
        }else if (state == YYGestureRecognizerStateEnded) {
            DLog(@"___________Ended");
        }else {
            DLog(@"___________Cancelled");
        }
    };
    [myLabel addGestureRecognizer:gesture];
}

@end
