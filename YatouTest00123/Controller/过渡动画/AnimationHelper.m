//
//  AnimationHelper.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/7.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "AnimationHelper.h"

@implementation AnimationHelper

+ (CATransform3D)yRotation:(CGFloat)angle {
    return CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
}

+ (void)persipectiveTransformForContainerView:(UIView *)containerView {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1.0 / 500;
    containerView.layer.sublayerTransform = transform;
}

@end
