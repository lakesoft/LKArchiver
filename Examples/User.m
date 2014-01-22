//
//  User.m
//  LKArchiver
//
//  Created by Hiroshi Hashiguchi on 2014/01/22.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.mail = [aDecoder decodeObjectForKey:@"mail"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.mail forKey:@"mail"];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ | %@", self.name, self.mail];
}
@end
