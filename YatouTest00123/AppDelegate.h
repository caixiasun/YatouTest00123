//
//  AppDelegate.h
//  YatouTest00123
//
//  Created by caixiasun on 16/10/12.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#define kAppKey @"24e89db05dea78ff55ef6bed13ffe53b"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, assign) BOOL isLandspace;

- (void)saveContext;
+ (AppDelegate *)shareInstance;


@end

