//
//  UserHistory.h
//  LKArchiver
//
//  Created by Hiroshi Hashiguchi on 2014/01/22.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface UserHistory : NSObject

+ (instancetype)sharedHistory;
- (void)addUser:(User*)user;
- (void)save;
- (void)load;

@end
