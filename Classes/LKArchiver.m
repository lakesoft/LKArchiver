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
+ (NSString*)_filePathForKey:(NSString*)key
{
    NSString* filename = [key stringByAppendingPathExtension:@"archive"];
    return [self.path stringByAppendingPathComponent:filename];
}

+ (void)_createDirectoryForKey:(NSString*)key
{
    if ([key rangeOfString:@"/"].length > 0) {
        NSString* dir = [[self _filePathForKey:key] stringByDeletingLastPathComponent];
        if (![NSFileManager.defaultManager fileExistsAtPath:dir]) {
            NSError* error = nil;
            [NSFileManager.defaultManager createDirectoryAtPath:dir
                                    withIntermediateDirectories:YES
                                                     attributes:nil
                                                          error:&error];
            if (error) {
                NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
            }
        }
    }
}

#pragma mark - API

+ (BOOL)archiveRootObject:(id <NSCoding>)rootObject forKey:(NSString*)key
{
    key = [key stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
    if (key.length == 0) {
        return NO;
    }
    @try {
        [self _createDirectoryForKey:key];
        return [NSKeyedArchiver archiveRootObject:rootObject
                                           toFile:[self _filePathForKey:key]];
    } @catch (NSException* e) {
        NSLog(@"%s: %@", __PRETTY_FUNCTION__, e);
        return NO;
    }
}

+ (id)unarchiveObjectForKey:(NSString*)key
{
    id object = nil;
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:[self _filePathForKey:key]];
    } @catch (NSException* e) {
        NSLog(@"%s: %@", __PRETTY_FUNCTION__, e);
    }
    return object;
}

+ (id)unarchiveObjectForKey:(NSString*)key defaultObject:(id(^)())defaultObject
{
    id object = [self unarchiveObjectForKey:key];
    if (object == nil) {
        object = defaultObject();
    }
    return object;
}

+ (id)unarchiveObjectForKey:(NSString*)key failure:(void(^)())failure
{
    id object = [self unarchiveObjectForKey:key];
    if (object == nil) {
        failure();
    }
    return object;
}


+ (BOOL)removeArchiveForKey:(NSString*)key
{
    BOOL result = YES;
    NSString* filePath = [self _filePathForKey:key];
    if ([self archiveExistsForKey:key]) {
        NSError* error = nil;
        result = [NSFileManager.defaultManager removeItemAtPath:filePath
                                                          error:&error];
        if (error) {
            NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
        }
    }
    return result;
}

+ (BOOL)archiveExistsForKey:(NSString*)key
{
    return [NSFileManager.defaultManager fileExistsAtPath:[self _filePathForKey:key]];
}

#pragma mark - Orverwritten
+ (NSString*)path
{
    NSLog(@"%s: must be overwritten in subclass.", __PRETTY_FUNCTION__);
    return nil;
}



@end
