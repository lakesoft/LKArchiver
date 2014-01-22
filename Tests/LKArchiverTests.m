//
//  LKArchiverTests.m
//  LKArchiverTests
//
//  Created by Hiroshi Hashiguchi on 2014/01/21.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestObject.h"
#import "LKDocumentDirectoryArchiver.h"
#import "LKCacheDirectoryArchiver.h"

@interface LKArchiverTests : XCTestCase

@end

@implementation LKArchiverTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testArchive
{
    NSMutableArray* list = @[].mutableCopy;
    for (int i=0; i < 10; i++) {
        TestObject* obj = TestObject.new;
        obj.name = [NSString stringWithFormat:@"NAME-%d", i];
        obj.mail = [NSString stringWithFormat:@"MAIL-%d", i];
        [list addObject:obj];
    }
    BOOL result = [LKDocumentDirectoryArchiver.sharedArchiver archiveRootObject:list forKey:@"TEST-11"];

    XCTAssertTrue(result, @"");
    
    NSArray* array = [LKDocumentDirectoryArchiver.sharedArchiver unarchiveObjectForKey:@"TEST-11"];
    for (int i=0; i < 10; i++) {
        TestObject* obj = array[i];
        NSString* name = [NSString stringWithFormat:@"NAME-%d", i];
        NSString* mail = [NSString stringWithFormat:@"MAIL-%d", i];
        XCTAssertEqualObjects(obj.name, name, @"");
        XCTAssertEqualObjects(obj.mail, mail, @"");
    }
    
    NSArray* array2 = [LKDocumentDirectoryArchiver.sharedArchiver unarchiveObjectForKey:@"TEST-12"];
    XCTAssertNil(array2, @"");
}

- (void)testRemove
{
    NSMutableArray* list = @[].mutableCopy;
    for (int i=0; i < 10; i++) {
        TestObject* obj = TestObject.new;
        obj.name = [NSString stringWithFormat:@"NAME-%d", i];
        obj.mail = [NSString stringWithFormat:@"MAIL-%d", i];
        [list addObject:obj];
    }
    [LKDocumentDirectoryArchiver.sharedArchiver archiveRootObject:list forKey:@"TEST-21"];

    BOOL result = [LKDocumentDirectoryArchiver.sharedArchiver removeArchiveForKey:@"TEST-21"];
    XCTAssertTrue(result, @"");
    
    id result2 = [LKDocumentDirectoryArchiver.sharedArchiver unarchiveObjectForKey:@"TEST-21"];
    XCTAssertNil(result2, @"");
}


- (void)testDirectory
{
    NSString* documentPath1 = LKDocumentDirectoryArchiver.sharedArchiver.path;
    NSString* documentPath2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    XCTAssertEqualObjects(documentPath1, documentPath2, @"");
    
    NSString* cachePath1 = LKCacheDirectoryArchiver.sharedArchiver.path;
    NSString* cachePath2 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    XCTAssertEqualObjects(cachePath1, cachePath2, @"");
}

@end
