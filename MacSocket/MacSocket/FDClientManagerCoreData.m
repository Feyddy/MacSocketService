//
//  FDClientManagerCoreData.m
//  MacSocket
//
//  Created by t3 on 2017/5/24.
//  Copyright © 2017年 feyddy. All rights reserved.
//

#import "FDClientManagerCoreData.h"

@implementation FDClientManagerCoreData

static FDClientManagerCoreData *shareManager;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[FDClientManagerCoreData alloc] init];
    });
    return shareManager;
}

// 上下文，对数据库的操作
- (NSManagedObjectContext *)managerContext {
    if (_managerContext == nil) {
        
        //创建一个实体类(OC文件) -->关联CoreData模型文件
        //一顿的给实体类赋值属性!!(对应的就是Sql中的字段)
        
        // 创建模型实体类：Client.xcdatamodeld
        // 创建一个Client表，修改Client表的class中的Codegen为第一个
        // 添加内容port,ipaddress,connecttime,disconnecttime
        // 创建上下文
        _managerContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        // 创建模型文件
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Client" withExtension:@"momd"]];
        
        // 设置持久化存储协调器
        NSPersistentStoreCoordinator *per = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        // 数据库文件地址
        NSURL *url = [NSURL fileURLWithPath:@"/Users/t3/Desktop/iOS-Mac搭建socket服务器/coredata/Client.db"];
        [per addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:nil];
        
        
        // 赋值给上下文
        _managerContext.persistentStoreCoordinator = per;
        
    }
    return _managerContext;
}

@end
