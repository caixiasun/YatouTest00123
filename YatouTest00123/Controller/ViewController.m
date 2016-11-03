//
//  ViewController.m
//  YatouTest00123
//
//  Created by caixiasun on 16/10/12.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <OpenAL/OpenAL.h>
#import <OpenGLES/ES1/glext.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
{
    GLuint _buffer;
}
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UINavigationBar *naviBar;
@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView =  [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:self.mapView belowSubview:self.backView];
    
    [self.view bringSubviewToFront:self.naviBar];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)buttonAction:(UIButton *)sender {
    if (sender.tag == 1) {//返回
        [self.navigationController popViewControllerAnimated:YES];
    }else {//截屏
        __block UIImage *shotImage = nil;
        __block NSInteger restate = 0;
        [self.mapView takeSnapshotInRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight) withCompletionBlock:^(UIImage *resultImage, NSInteger state) {
            shotImage = resultImage;
            restate = state;//state表示地图此时是否完整，0-不完整，1-完整
        }];
        
//        UIImage *viewImage = [self screenCaptureInView:self.view];
//        UIImage *viewImage = [self.view snapshotViewAfterScreenUpdates:<#(BOOL)#>]
        
        
        NSLog(@"已截图");
        
//        UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    }
}

//截屏并保存到照片库
- (UIImage *) screenCaptureInView:(UIView *)view{
    CGSize size = view.frame.size;
    CGFloat scal = 1;
    if (size.width <= 375) {
        scal = 2;
    }else if (size.width == 414) {
        scal = 3;
    }
    CGFloat viewH = 150;
    CGRect imgRect = CGRectMake(0, (size.height-viewH)*scal, size.width*scal, viewH*scal);//这里可以设置想要截图的区域()
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, imgRect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    
//    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
    
    return sendImage;
}

-(UIImage *) glToUIImage {
    CGSize viewSize=self.view.frame.size;
    NSInteger myDataLength = viewSize.width * viewSize.height * 4;
    
//    CAEAGLLayer *eaglLayer = (CAEAGLLayer *) self.view.layer;
//    eaglLayer.drawableProperties = @{
//                                     kEAGLDrawablePropertyRetainedBacking: [NSNumber numberWithBool:YES],
//                                     kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8
//                                     };
    
    
    // allocate array and read pixels into it.
    GLubyte *buffer = (GLubyte *) malloc(myDataLength);
    glReadPixels(0, 0, viewSize.width, viewSize.height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    
    // gl renders "upside down" so swap top to bottom into new array.
    // there's gotta be a better way, but this works.
    GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
    for(int y = 0; y < viewSize.height; y++)
    {
        for(int x = 0; x < viewSize.width* 4; x++)
        {
            buffer2[(int)((viewSize.height-1 - y) * viewSize.width * 4 + x)] = buffer[(int)(y * 4 * viewSize.width + x)];
        }
    }
    
    // make data provider with data.
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
    
    // prep the ingredients
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * viewSize.width;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    // make the cgimage
    CGImageRef imageRef = CGImageCreate(viewSize.width , viewSize.height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
    // then make the uiimage from that
    UIImage *myImage = [UIImage imageWithCGImage:imageRef];
    return myImage;
}

- (UIImage*)snapshot:(UIView*)eaglview


{
    
    
    GLint backingWidth, backingHeight;
    
    
    
    
    
    // Bind the color renderbuffer used to render the OpenGL ES view
    
    
    // If your application only creates a single color renderbuffer which is already bound at this point,
    
    
    // this call is redundant, but it is needed if you're dealing with multiple renderbuffers.
    
    
    // Note, replace "_colorRenderbuffer" with the actual name of the renderbuffer object defined in your class.
    
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, _buffer);
    
    
    
    
    
    // Get the size of the backing CAEAGLLayer
    
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    
    
    
    
    NSInteger x = 0, y = 0, width = backingWidth, height = backingHeight;
    
    
    NSInteger dataLength = width * height * 4;
    
    
    GLubyte *data = (GLubyte*)malloc(dataLength * sizeof(GLubyte));
    
    
    
    
    
    // Read pixel data from the framebuffer
    
    
    glPixelStorei(GL_PACK_ALIGNMENT, 4);
    
    
    glReadPixels(x, y, width, height, GL_RGBA, GL_UNSIGNED_BYTE, data);
    
    CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, data, dataLength, NULL);
    
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    
    CGImageRef iref = CGImageCreate(width, height, 8, 32, width * 4, colorspace, kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast,
                                    
                                    
                                    ref, NULL, true, kCGRenderingIntentDefault);
    
    
    
    
    
    // OpenGL ES measures data in PIXELS
    
    
    // Create a graphics context with the target size measured in POINTS
    
    
    NSInteger widthInPoints, heightInPoints;
    
    
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        
        CGFloat scale = eaglview.contentScaleFactor;
        
        
        widthInPoints = width / scale;
        
        
        heightInPoints = height / scale;
        
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(widthInPoints, heightInPoints), NO, scale);
    }
    
    else {
        
        
        // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
        
        
        widthInPoints = width;
        
        
        heightInPoints = height;
        
        
        UIGraphicsBeginImageContext(CGSizeMake(widthInPoints, heightInPoints));
        
        
    }
    
    
    
    
    
    CGContextRef cgcontext = UIGraphicsGetCurrentContext();
    
    
    CGContextSetBlendMode(cgcontext, kCGBlendModeCopy);
    
    
    CGContextDrawImage(cgcontext, CGRectMake(0.0, 0.0, widthInPoints, heightInPoints), iref);
    
    
    
    
    
    // Retrieve the UIImage from the current context
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    
    
    UIGraphicsEndImageContext();
    
    
    
    
    
    // Clean up
    
    
    free(data);
    
    
    CFRelease(ref);
    
    
    CFRelease(colorspace);
    
    
    CGImageRelease(iref);
    
    
    
    
    
    return image;
    
    
}




@end
