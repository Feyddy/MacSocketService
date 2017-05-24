//
//  FDClientManagerCoreData.h
//  MacSocket
//
//  Created by t3 on 2017/5/24.
//  Copyright © 2017年 feyddy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface FDClientManagerCoreData : NSObject

// 管理对象上下文
@property (nonatomic ,strong) NSManagedObjectContext *managerContext;

// 单例
+ (instancetype)shareManager;
@end
