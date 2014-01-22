//
//  User.h
//  LKArchiver
//
//  Created by Hiroshi Hashiguchi on 2014/01/22.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* mail;

@end
