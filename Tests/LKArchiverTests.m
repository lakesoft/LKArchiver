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
#import "LKCachesDirectoryArchiver.h"

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
    BOOL result = [LKDocumentDirectoryArchiver archiveRootObject:list forKey:@"TEST-11"];

    XCTAssertTrue(result, @"");
    
    NSArray* array = [LKDocumentDirectoryArchiver unarchiveObjectForKey:@"TEST-11"];
    for (int i=0; i < 10; i++) {
        TestObject* obj = array[i];
        NSString* name = [NSString stringWithFormat:@"NAME-%d", i];
        NSString* mail = [NSString stringWithFormat:@"MAIL-%d", i];
        XCTAssertEqualObjects(obj.name, name, @"");
        XCTAssertEqualObjects(obj.mail, mail, @"");
    }
    
    NSArray* array2 = [LKDocumentDirectoryArchiver unarchiveObjectForKey:@"TEST-12"];
    XCTAssertNil(array2, @"");
}

- (void)testRemoveAndExists
{
    [LKDocumentDirectoryArchiver removeArchiveForKey:@"TEST-21"];
    
    NSMutableArray* list = @[].mutableCopy;
    for (int i=0; i < 10; i++) {
        TestObject* obj = TestObject.new;
        obj.name = [NSString stringWithFormat:@"NAME-%d", i];
        obj.mail = [NSString stringWithFormat:@"MAIL-%d", i];
        [list addObject:obj];
    }
    [LKDocumentDirectoryArchiver archiveRootObject:list forKey:@"TEST-21"];
    
    BOOL result1 = [LKDocumentDirectoryArchiver archiveExistsForKey:@"TEST-21"];
    XCTAssertTrue(result1, @"");

    BOOL result2 = [LKDocumentDirectoryArchiver removeArchiveForKey:@"TEST-21"];
    XCTAssertTrue(result2, @"");
    
    id result3 = [LKDocumentDirectoryArchiver unarchiveObjectForKey:@"TEST-21"];
    XCTAssertNil(result3, @"");

    BOOL result4 = [LKDocumentDirectoryArchiver archiveExistsForKey:@"TEST-21"];
    XCTAssertFalse(result4, @"");
}


- (void)testDefaultObject
{
    id object = [LKDocumentDirectoryArchiver unarchiveObjectForKey:@"TEST-31"
                                                     defaultObject:^id{
                                                         return @"NILCASE-31";
                                                     }];
    XCTAssertEqualObjects(object, @"NILCASE-31", @"");
}


- (void)testFailure
{
    __block NSString* str = nil;

    id object = [LKDocumentDirectoryArchiver unarchiveObjectForKey:@"TEST-41"
                 failure:^{
                     str = @"FAILURE";
                 }];
    XCTAssertNil(object, @"");
    XCTAssertEqualObjects(str, @"FAILURE", @"");
}


- (void)testDirectory
{
    NSString* documentPath1 = LKDocumentDirectoryArchiver.path;
    NSString* documentPath2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    XCTAssertEqualObjects(documentPath1, documentPath2, @"");
    
    NSString* cachePath1 = LKCachesDirectoryArchiver.path;
    NSString* cachePath2 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    XCTAssertEqualObjects(cachePath1, cachePath2, @"");
}


- (void)testArchiveOnLayers
{
    NSMutableDictionary* list = @{}.mutableCopy;
    NSArray* keys = @[
                      @"dirA10/fileA11"           , @"dirA10/fileA12",
                      @"dirA10/dir20/file21"      , @"dirA10/dir20/file22",
                      @"dirA10/dir20/dir30/file31", @"dirA10/dir20/dir30/file32",
                      @"dirA10/dir20/dir31/file31", @"dirA10/dir20/dir31/file32",
                      @"dirB10/fileA11"           , @"dirB10/fileA12",
                      @"dirB10/dir20/file21"      , @"dirB10/dir20/file22",
                      @"dirB10/dir20/dir30/file31", @"dirB10/dir20/dir30/file32",
                      @"dirB10/dir20/dir31/file31", @"dirB10/dir20/dir31/file32",
                      ];
    for (NSString* key in keys) {
        NSMutableArray* objs = @[].mutableCopy;
        for (int i=0; i < 10; i++) {
            TestObject* obj = TestObject.new;
            obj.name = [NSString stringWithFormat:@"NAME-%@-%d", key, i];
            obj.mail = [NSString stringWithFormat:@"MAIL-%@-%d", key, i];
            [objs addObject:obj];
        }
        list[key] = objs;
    }

    for (NSString* key in keys) {
        BOOL result = [LKDocumentDirectoryArchiver archiveRootObject:list forKey:key];
        XCTAssertTrue(result, @"Archive with multi layers key");
    }

    for (NSString* key in keys) {
        NSDictionary* list = [LKDocumentDirectoryArchiver unarchiveObjectForKey:key];
        for (int i=0; i < 10; i++) {
            TestObject* obj = list[key][i];
            NSString* name = [NSString stringWithFormat:@"NAME-%@-%d", key, i];
            NSString* mail = [NSString stringWithFormat:@"MAIL-%@-%d", key,i];
            XCTAssertEqualObjects(obj.name, name, @"");
            XCTAssertEqualObjects(obj.mail, mail, @"");
        }
    }
    
    NSString* key2 = @"dirB10/dir20/dir31/file31";
    BOOL result21 = [LKDocumentDirectoryArchiver archiveExistsForKey:key2];
    XCTAssertTrue(result21, @"");
    
    BOOL result22 = [LKDocumentDirectoryArchiver removeArchiveForKey:key2];
    XCTAssertTrue(result22, @"");
    
    id result23 = [LKDocumentDirectoryArchiver unarchiveObjectForKey:key2];
    XCTAssertNil(result23, @"");
    
    BOOL result24 = [LKDocumentDirectoryArchiver archiveExistsForKey:key2];
    XCTAssertFalse(result24, @"");

    BOOL result25 = [LKDocumentDirectoryArchiver removeArchiveForKey:key2];
    XCTAssertTrue(result25, @"");

}

- (void)testArchiveRoot
{
    TestObject* obj = TestObject.new;
    obj.name = [NSString stringWithFormat:@"NAME"];
    obj.mail = [NSString stringWithFormat:@"MAIL"];
    BOOL result1 = [LKDocumentDirectoryArchiver archiveRootObject:obj forKey:@"/root"];
    XCTAssertTrue(result1, @"Archive with root key");

    BOOL result2 = [LKDocumentDirectoryArchiver archiveRootObject:obj forKey:@"/"];
    XCTAssertFalse(result2, @"Archive with root key");
}

@end
