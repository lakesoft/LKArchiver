//
//  LKDocumentDirectoryArchiver.m
//  LKArchiver
//
//  Created by Hiroshi Hashiguchi on 2014/01/21.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import "LKDocumentDirectoryArchiver.h"

@implementation LKDocumentDirectoryArchiver

+ (NSString*)path
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

@end
