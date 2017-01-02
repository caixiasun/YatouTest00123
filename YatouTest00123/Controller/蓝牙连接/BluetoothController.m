//
//  BluetoothController.m
//  YatouTest00123
//
//  Created by caixiasun on 16/11/3.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "BluetoothController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BluetoothController ()<UITableViewDelegate,UITableViewDataSource,CBPeripheralManagerDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *deviceArray;

@property (nonatomic, strong) CBPeripheralManager *peripheraManager;
@property (nonatomic, strong) CBMutableCharacteristic *customCharacteristic;
@property (nonatomic, strong) CBMutableService *customService;

@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) CBPeripheral *peripheral;

@end

static NSString *const kServiceUUID = @"FBEAC9F0-B626-477C-99B0-2EF40D987600";
static NSString *const kCharacteristicUUID = @"C88D0877-CAE8-425F-87B9-58B4D9E090F1";

@implementation BluetoothController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"蓝牙连接测试";
    self.deviceArray = [NSMutableArray new];
    
    /*
     *  创建了一个Peripheral Manager 第二个参数设置为nil，因为Peripheral Manager将Run在主线程中。如果你想用不同的线程做更加复杂的事情，你需要创建一个队列（queue）并将它放在这儿。 一旦Peripheral Manager被创建，我们应该及时地检查它的状态
     */
    self.peripheraManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

-(void)setupService {
    
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    //第二个参数决定这个特征怎么使用,第三个参数赋值nil，这是，我告诉CoreBluetooth，我将稍后添加一个特征的值。最后一个参数是属性的读、写、加密的权限
    self.customCharacteristic = [[CBMutableCharacteristic alloc] initWithType:
                                 characteristicUUID properties:CBCharacteristicPropertyNotify
                                                                        value:nil permissions:CBAttributePermissionsReadable];
    
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
    self.customService = [[CBMutableService alloc] initWithType:serviceUUID
                                                        primary:YES];
    
    [self.customService setCharacteristics:@[self.customCharacteristic]];
    
    [self.peripheraManager addService:self.customService];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    
    cell.textLabel.text = [self.deviceArray objectAtIndex:indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark -  CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    switch (peripheral.state) {
        case CBManagerStatePoweredOn://状态是这个，说明这个设备是支持BLE并且可用的。
        {
            break;
        }
        default:
            break;
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(nullable NSError *)error {
    if (error == nil) {
        //把服务添加到周边管理者（Peripheral Manager）是用于发布服务。一旦完成这个，周边管理者会通知他的代理方法-peripheralManager:didAddService:error:。现在，如果没有Error，你可以开始广播服务了：
        [self.peripheraManager startAdvertising:@{CBAdvertisementDataLocalNameKey:@"ICServer",CBAdvertisementDataServiceUUIDsKey:@[[CBUUID UUIDWithString:kServiceUUID]]}];;
    }
}
//当周边管理者开始广播服务，他的代理接收-peripheralManagerDidStartAdvertising:error: 消息，并且当中央预定了这个服务，他的代理接收 -peripheralManager:central:didSubscribeToCharacteristic:消息，这儿是你给中央生成动态数据的地方。
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(nullable NSError *)error {
    
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic {
    
}

#pragma mark - CBCentralManagerDelegate
//当Central Manager被初始化，我们要检查它的状态，以检查运行这个App的设备是不是支持BLE。实现以下的代理方法：
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBManagerStatePoweredOn://这个App的设备支持BLE
        {
            //-scanForPeripheralsWithServices:options: 方法是用于告诉Central Manager，要开始寻找一个指定的服务了。如果你将第一个参数设置为nil，Central Manager就会开始寻找所有的服务。
            [self.manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
            break;
        }
        default:
            NSLog(@"Central Manager did change state");
            break;
    }
}
//一旦一个周边在寻找的时候被发现，中央的代理会收到以下回调
//这个调用通知Central Manager的代理（在这个例子中就是view controller），一个附带着广播数据和信号质量(RSSI-Received Signal Strength Indicator)的周边被发现。这是一个很酷的参数，知道了信号质量，你可以用它去判断远近。
//任何广播、扫描的响应数据保存在advertisementData 中，可以通过CBAdvertisementData 来访问它。现在，你可以停止扫描，而去连接周边了
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    [self.manager stopScan];
    
    if (self.peripheral != peripheral) {
        self.peripheral = peripheral;
        //连接周边
        [self.manager connectPeripheral:peripheral options:nil];
    }
}
//基于连接的结果，代理（这个例子中是view controller）会接收centralManager:didFailToConnectPeripheral:error:或者centralManager:didConnectPeripheral:
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    
}
//如果成功了，你可以问广播服务的那个周边。因此，在didConnectPeripheral 回调中，你可以写以下代码：
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    [self.data setLength:0];
    
    [self.peripheral setDelegate:self];
    
    [self.peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
}

#pragma mark - CBPeripheralDelegate
//现在，周边开始用一个回调通知它的代理。在上一个方法中，我请求周边去寻找服务，周边代理接收-peripheral:didDiscoverServices:。如果没有Error，可以请求周边去寻找它的服务所列出的特征，像以下这么做：
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    if (error) {
        NSLog(@"Error discovering service:%@", [error localizedDescription]);
        //[self cleanup];
        return ;
    }
    //可以请求周边去寻找它的服务所列出的特征
    for (CBService *service in peripheral.services) {
        NSLog(@"Service found with UUID: %@",service.UUID);
        if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]]) {
            [service.peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kCharacteristicUUID]] forService:service];
        }
    }
}
//如果一个特征被发现，周边代理会接收-peripheral:didDiscoverCharacteristicsForService:error:。现在，一旦特征的值被更新，用-setNotifyValue:forCharacteristic:，周边被请求通知它的代理。
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    
    if (error) {
        NSLog(@"Error discovering characteristic:%@", [error localizedDescription]);
        //[self cleanup];
        return;
    }
    
    if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]]) {
        for (CBCharacteristic *cha in service.characteristics) {
            if ([cha.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]]) {
                [peripheral setNotifyValue:YES forCharacteristic:cha];
            }
        }
    }
}
//如果一个特征的值被更新，然后周边代理接收-peripheral:didUpdateNotificationStateForCharacteristic:error:。你可以用-readValueForCharacteristic:读取新的值：
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state:%@", error.localizedDescription);
    }
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]]) {
        return ;
    }
    
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    }else {
        [self.manager cancelPeripheralConnection:self.peripheral];
    }
}


@end
