//
//  RuntimeDemoController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/9.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "RuntimeDemoController.h"
#import "RuntimeClass.h"

@interface RuntimeDemoController ()

@property (nonatomic, strong) UILabel *associatedLabel;

@end

@implementation RuntimeDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"____PropertyList = %@",[self getPropertyList]);
//    
//    NSLog(@"____MethodList = %@",[self getMethodList]);
    
//    NSLog(@"____IVarList- = %@",[self getIVarList]);
    
//    NSLog(@"____ProtocolList = %@",[self getProtocolList]);
    
    [self performSelector:@selector(myTest) withObject:nil afterDelay:0.5];
    
    //关联对象测试
    static char *associatedObjKey = "AssociatedKeyTest";
    NSString *message = @"这是一个测试消息";
    objc_setAssociatedObject(_associatedLabel, &associatedObjKey, message, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSString *getMessage = objc_getAssociatedObject(_associatedLabel, associatedObjKey);
    NSLog(@"____associatedObject = %@",getMessage);
}

//当你调用一个不存在的类方法的时候，会调用这个方法，默认返回NO，你可以加上自己的处理然后返回YES。
+ (BOOL)resolveClassMethod:(SEL)sel {
    NSString *name = NSStringFromSelector(sel);
    if ([name isEqualToString:@"myTest"]) {
        NSLog(@"__%@ 这个方法不存在哦~",name);
        return YES;
    }
    return NO;
}
//当你调用一个不存在的实例方法的时候，会调用这个方法，默认返回NO，你可以加上自己的处理然后返回YES。
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *name = NSStringFromSelector(sel);
    if ([name isEqualToString:@"myTest"]) {
        NSLog(@"__%@ 这个方法不存在哦~",name);
        //给本类动态添加一个方法
        class_addMethod(self, sel, (IMP)myTest2, "yatou test char");
        return YES;
    }
    return NO;
}

void myTest2(id self, SEL _cmd, NSString *string) {
    NSLog(@"动态添加C方法，绑定myTest和myTest2");
}

//你调用的不存在的方法重定向到一个其他声明了这个方法的类，只需要你返回一个有这个方法的target。
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *name = NSStringFromSelector(aSelector);
    NSLog(@"本类不存在方法：%@,将为您转向RuntimeClass类执行该方法.",name);
    return [RuntimeClass new];
}

- (NSArray *)getPropertyList {
    NSMutableArray *mutableArray = [NSMutableArray new];
    
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([RuntimeClass class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *pName = property_getName(propertyList[i]);
        NSString *sName = [NSString stringWithUTF8String:pName];
        [mutableArray addObject:sName];
    }
    
    return [mutableArray copy];
}

- (NSArray *)getMethodList {
    NSMutableArray *mutableArray = [NSMutableArray new];
    
    unsigned int count;
    Method *methodList = class_copyMethodList([RuntimeClass class], &count);
    for (unsigned int i=0; i<count; i++) {
        Method method = methodList[i];
        NSString *sName = NSStringFromSelector(method_getName(method));
        [mutableArray addObject:sName];
    }
    
    return [mutableArray copy];
}

- (NSArray *)getIVarList {
    NSMutableArray *mutableArray = [NSMutableArray new];
    
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([RuntimeClass class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *cName = ivar_getName(ivarList[i]);
        NSString *sName = [NSString stringWithUTF8String:cName];
        [mutableArray addObject:sName];
    }
    
    return [mutableArray copy];
}

- (NSArray *)getProtocolList {
    NSMutableArray *mutableArray = [NSMutableArray new];
    
    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([RuntimeClass class], &count);
    for (unsigned int i=0; i<count; i++) {
        Protocol *myProtocol = protocolList[i];
        const char *cName = protocol_getName(myProtocol);
        NSString *sName = [NSString stringWithUTF8String:cName];
        [mutableArray addObject:sName];
    }
    
    return [mutableArray copy];
}


@end
