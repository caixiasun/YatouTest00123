//
//  GLKViewController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/17.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "GLKViewController.h"
#import <GLKit/GLKit.h>

@interface GLKViewController ()
{
    EAGLContext *_context;//EAGLContent是苹果在ios平台下实现的opengles渲染层，用于渲染结果在目标surface上的更新。
}
//@property (nonatomic, weak) IBOutlet UIView *myView;

@end

@implementation GLKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
//    if (!_context) {
//        NSLog(@"______create failed with context");
//    }
//    
//    GLKView *view = (GLKView *)self.myView;
//    view.context = _context;
//    view.delegate = self;
//    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
//    [EAGLContext setCurrentContext:_context];
//    glEnable(GL_DEPTH_TEST);//开启深度测试，就是让离你近的物体可以遮挡离你远的物体。
//    glClearColor(0.1, 1, 0.3, 1);//设置surface的清除颜色，也就是渲染到屏幕上的背景色。
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);//清除surface内容，恢复至初始状态。  
}

@end
