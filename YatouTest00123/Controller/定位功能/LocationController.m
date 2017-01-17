//
//  LocationController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/16.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "LocationController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton new];
    [button setTitle:@"开启定位" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 0.5;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.center.equalTo(self.view);
    }];
    
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    return _locationManager;
}

//开启定位
- (void)buttonAction {
    
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    //开始定位追踪，开始定位后将按照用户设置的更新频率执行- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"您目前位置的经纬度为：latitude=%f,longitude=%f",coordinate.latitude,coordinate.longitude);
    
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error = %@",error);
}



@end
