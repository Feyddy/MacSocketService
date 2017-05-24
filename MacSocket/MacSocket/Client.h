//
//  Client.h
//  MacSocket
//
//  Created by t3 on 2017/5/24.
//  Copyright © 2017年 feyddy. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Client : NSManagedObject

// 端口号
@property(nonatomic, strong) NSNumber *port;

// IP地址
@property (nonatomic, copy) NSString *ipaddress;

// 连接时间
@property (nonatomic, strong) NSDate *connecttime;

// 断开时间
@property (nonatomic, strong) NSDate *disconnecttime;

@end
