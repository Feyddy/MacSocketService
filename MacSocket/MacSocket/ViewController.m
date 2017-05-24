//
//  ViewController.m
//  MacSocket
//
//  Created by t3 on 2017/5/24.
//  Copyright © 2017年 feyddy. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"
#import "FDClientManagerCoreData.h"
#import "Client.h"

@interface ViewController()<GCDAsyncSocketDelegate>

// 创建时间周期
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray *newSocketArray;

@property (weak) IBOutlet NSTextField *porTextField;

@end

@implementation ViewController


- (NSMutableArray *)newSocketArray {
    if (_newSocketArray == nil) {
        _newSocketArray = [NSMutableArray array];
    }
    return _newSocketArray;
}

// 创建一个服务器
- (GCDAsyncSocket *)service {
    if (_service == nil) {
        _service = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _service;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

// 监听端口
- (IBAction)socketConnect:(id)sender {
    // 通过socket 监听/绑定对应的端口
    [self.service acceptOnPort:self.porTextField.integerValue error:nil];
    
    // 连接之后开始读取数据
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(readingData) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)readingData {
    // 通过便利读取数据
    for (GCDAsyncSocket *newSocket in self.newSocketArray) {
        [newSocket readDataWithTimeout:-1 tag:0];
    }
}

// 有新的客户端socket
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    NSLog(@"连接到新的端口！%@",newSocket);
    /** 在终端中进行连接发现会断开连接，这是因为newSocket会被释放掉。
     * 
     xuzhonglindeMac-mini:~ t3$ telnet 127.0.0.1 1234
     Trying 127.0.0.1...
     Connected to localhost.
     Escape character is '^]'.
     Connection closed by foreign host.
     xuzhonglindeMac-mini:~ t3$
     
     
     * 为了不让他释放，可以创建一个数组进行存储。
     */
    
    // 将所有的新的连接保存起来
    [self.newSocketArray addObject:newSocket];
    
    /** 这个时候就不会断开了
     * 
     xuzhonglindeMac-mini:~ t3$ telnet 127.0.0.1 1234
     Trying 127.0.0.1...
     Connected to localhost.
     Escape character is '^]'.

     */
    
    // 存储在本地
    Client *client = [NSEntityDescription insertNewObjectForEntityForName:@"Client" inManagedObjectContext:[FDClientManagerCoreData shareManager].managerContext];
    
    // 赋值存储
    client.port = @(newSocket.connectedPort);
    client.ipaddress = newSocket.connectedHost;
    client.connecttime = [NSDate new];
    client.disconnecttime = nil;
    
    // 保存
    [[FDClientManagerCoreData shareManager].managerContext save:nil];
    
    // 通过指定的newsocket读取数据，通过时间循环读取数据，但是很耗费性能
//    [newSocket readDataWithTimeout:-1 tag:0];
    
}

// 通过代理接收数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    // 通过指定的
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}


- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    [self.timer invalidate];
    self.timer = nil;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
