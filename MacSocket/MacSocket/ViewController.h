//
//  ViewController.h
//  MacSocket
//
//  Created by t3 on 2017/5/24.
//  Copyright © 2017年 feyddy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class GCDAsyncSocket;
@interface ViewController : NSViewController

/**创建一个服务器*/
@property(nonatomic, strong) GCDAsyncSocket *service;

@end

