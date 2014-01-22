//
//  UserHistory.m
//  LKArchiver
//
//  Created by Hiroshi Hashiguchi on 2014/01/22.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import "UserHistory.h"
#import "LKDocumentDirectoryArchiver.h"

#define ARCHIVE_KEY @"UserHistory"

@interface UserHistory()
@property (strong, nonatomic) NSMutableArray* users;
@end

@implementation UserHistory

+ (instancetype)sharedHistory
{
    static UserHistory* _sharedHistory = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHistory = self.new;
    });
    return _sharedHistory;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self load];
    }
    return self;
}

- (void)addUser:(User*)user
{
    [self.users addObject:user];
}

- (void)save
{
    [LKDocumentDirectoryArchiver archiveRootObject:self.users forKey:ARCHIVE_KEY];
}

- (void)load
{
    self.users = [LKDocumentDirectoryArchiver unarchiveObjectForKey:ARCHIVE_KEY];
    if (self.users == nil) {
        self.users = @[].mutableCopy;
    }
}

- (NSString*)description
{
    return [self.users description];
}

@end
