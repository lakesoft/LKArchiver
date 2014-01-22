//
//  LKArchiver.h
//  LKArchiver
//
//  Created by Hiroshi Hashiguchi on 2014/01/21.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKArchiver : NSObject

#pragma mark - API
+ (instancetype)sharedArchiver;

- (BOOL)archiveRootObject:(id <NSCoding>)rootObject forKey:(NSString*)key;
- (id)unarchiveObjectForKey:(NSString*)key;
- (BOOL)removeArchiveForKey:(NSString*)key;

#pragma mark - Orverwritten
- (NSString*)path;

@end
