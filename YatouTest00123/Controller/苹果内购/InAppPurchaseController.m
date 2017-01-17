//
//  InAppPurchaseController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/12.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "InAppPurchaseController.h"
#import <StoreKit/StoreKit.h>

@interface InAppPurchaseController ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@end

@implementation InAppPurchaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton new];
    [button setTitle:@"开始购买" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)buttonAction {
    NSSet *set = [NSSet setWithObjects:@"testId0", nil];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    [request start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
//    SKProduct *product = response.products[0];
//    SKPayment *payment = [SKPayment paymentWithProduct:product];
//    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
}

@end
