//
//  LKCacheDirectoryArchiver.m
//  LKArchiver
//
//  Created by Hiroshi Hashiguchi on 2014/01/21.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import "LKCachesDirectoryArchiver.h"

@implementation LKCachesDirectoryArchiver

+ (NSString*)path
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

@end
