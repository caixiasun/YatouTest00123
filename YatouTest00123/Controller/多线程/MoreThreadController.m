//
//  MoreThreadController.m
//  YatouTest00123
//
//  Created by caixiasun on 16/11/4.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "MoreThreadController.h"
#import <pthread.h>

@interface MoreThreadController ()
{
    int _threadType;
}
@property (nonatomic, assign) pthread_t currentThread;

@end

@implementation MoreThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _threadType = 4;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 60, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    pthread_t thread;
    switch (_threadType) {
        case 0://pthread
        {
            //创建一个线程并自动执行 该类型的线程不会自动销毁，需手动
            pthread_create(&thread, NULL, start, NULL);
            self.currentThread = thread;
            break;
        }
        case 1://NSThread
        {
//            NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMethod) object:nil];
//            [thread start];
            
            //创建并自动启动。
            [NSThread detachNewThreadSelector:@selector(threadMethod2) toTarget:self withObject:nil];
            
            break;
        }
        case 2://GCD
        {
            /*
             *  创建队列
             *  第一个参数是标识符，用于 DEBUG 的时候标识唯一的队列，可以为空。
             *  第二个参数用来表示创建的队列是串行的还是并行的，传入 DISPATCH_QUEUE_SERIAL 或 NULL 表示创建串行队列。传入 DISPATCH_QUEUE_CONCURRENT 表示创建并行队列。
             */
            dispatch_queue_t queue = dispatch_queue_create("yatou.testQueue", NULL);
            //全局并行队列：这应该是唯一一个并行队列， 只要是并行任务一般都加入到这个队列。这是系统提供的一个并发队列。
//            dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            /*
            //创建任务
            //同步任务： 不会另开线程 改：会阻塞当前线程 (SYNC)
            dispatch_sync(queue, ^{
                NSLog(@"%@",[NSThread currentThread]);
            });
            //异步任务   不会阻塞当前线程 (ASYNC)
            dispatch_async(queue, ^{
                NSLog(@"_________%@",[NSThread currentThread]);
            });
             */
            //测试
            NSLog(@"111111之前 - %@", [NSThread currentThread]);
            
            dispatch_async(queue, ^{
                NSLog(@"2222222sync之前 - %@", [NSThread currentThread]);
                dispatch_sync(queue, ^{
                    NSLog(@"3333333sync - %@", [NSThread currentThread]);
                });
                NSLog(@"4444444sync之后 - %@", [NSThread currentThread]);
            });
            
            NSLog(@"555555之后 - %@", [NSThread currentThread]);
            
            break;
        }
        case 3://测试 卡死主线程
        {
            NSLog(@"之前 - %@", [NSThread currentThread]);
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"sync - %@", [NSThread currentThread]);
            });
            NSLog(@"之后 - %@", [NSThread currentThread]);
            break;
        }
        case 4://NSOperation
        {
            /*
            //1  NSInvocationOperation
            NSInvocationOperation *invocationO = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationMeghod1) object:nil];
            //默认在当前队列同步执行
            [invocationO start];
            */
            
            /*
            //2 NSBlockOperation
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                NSLog(@"_____block operation____");
                NSLog(@"__________________%@",[NSThread currentThread]);
            }];
            [operation start];
            */
            
            /*
            //3  添加多个任务  addExecutionBlock 方法必须在 start() 方法之前执行，否则就会报错：
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                NSLog(@"____%@",[NSThread currentThread]);
            }];
            
            //添加多个block
            for (int i = 0; i<5; i++) {
                [operation addExecutionBlock:^{
                    NSLog(@"________第 %d 次，%@",i+1,[NSThread currentThread]);
                }];
            }
            [operation start];
            */
            
            //上述方法，start后 任务 默认是 同步执行 的。就算是 addExecutionBlock 方法，也会在 当前线程和其他线程 中执行，也就是说还是会占用当前线程。这时就要用到队列 NSOperationQueue 了。而且，按类型来说的话一共有两种类型：主队列、其他队列。
            
            //只要添加到队列，会自动调用任务的 start() 方法
            
            //每套多线程方案都会有一个主线程，这是一个特殊的线程，必须串行。所以添加到主队列的任务都会一个接一个地排着队在主线程处理。
            NSOperationQueue *queue = [NSOperationQueue mainQueue];
            
            //通过初始化产生的队列就是其他队列了
            NSOperationQueue *otherQueue = [[NSOperationQueue alloc] init];
            //创建任务
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                NSLog(@"____%@",[NSThread currentThread]);
            }];
            //向任务中添加多个block
            for (int i=0; i<5; i++) {
                [operation addExecutionBlock:^{
                    NSLog(@"________第 %d 次，%@",i+1,[NSThread currentThread]);
                }];
            }
            //向队列中添加任务
            [otherQueue addOperation:operation];
            //该属性 用于设置最大并发数（即：同时可以让多少个任务执行，若设置为1，则该队列就是穿行队列，否则就是并行队列）
//            otherQueue.maxConcurrentOperationCount = 1;
            
            
            
            break;
        }
        default:
            break;
    }
    
}

- (void)invocationMeghod1 {
    NSLog(@"invocationMeghod1_________%@",[NSThread currentThread]);
}

- (void)btnClicked {
    NSLog(@"_____按钮被点击了____");
}

void *start(void *data) {
    NSLog(@"pthread____%@",[NSThread currentThread]);
    
    return NULL;
}

- (void)threadMethod {
    NSLog(@"thread____%@",[NSThread currentThread]);
    
}

- (void)threadMethod2 {
    NSLog(@"thread222____%@",[NSThread currentThread]);
}

@end
