//
//  LKArchiver.m
//  LKArchiver
//
//  Created by Hiroshi Hashiguchi on 2014/01/21.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import "LKArchiver.h"

@implementation LKArchiver

#pragma mark - Privates
- (NSString*)_filePathForKey:(NSString*)key
{
    NSString* filename = [key stringByAppendingPathExtension:@"archive"];
    return [self.path stringByAppendingPathComponent:filename];
}

#pragma mark - API
+ (instancetype)sharedArchiver
{
    static NSMutableDictionary* _archivers;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _archivers = @{}.mutableCopy;
    });
    
    id archiver = nil;
    
    @synchronized (self) {
        NSString* archiverKey = NSStringFromClass(self.class);
        
        archiver = _archivers[archiverKey];
        if (archiver == nil) {
            archiver = self.new;
            _archivers[archiverKey] = archiver;
        }
    }
    return archiver;
}

- (BOOL)archiveRootObject:(id <NSCoding>)rootObject forKey:(NSString*)key
{
    return [NSKeyedArchiver archiveRootObject:rootObject
                                       toFile:[self _filePathForKey:key]];
}

- (id)unarchiveObjectForKey:(NSString*)key
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self _filePathForKey:key]];
}

- (BOOL)removeArchiveForKey:(NSString*)key
{
    BOOL result = YES;
    NSString* filePath = [self _filePathForKey:key];
    if ([NSFileManager.defaultManager fileExistsAtPath:filePath]) {
        NSError* error = nil;
        result = [NSFileManager.defaultManager removeItemAtPath:filePath
                                                          error:&error];
        if (error) {
            NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
        }
    }
    return result;
}

#pragma mark - Orverwritten
- (NSString*)path
{
    NSLog(@"%s: must be overwritten in subclass.", __PRETTY_FUNCTION__);
    return nil;
}



@end
