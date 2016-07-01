//
//  OFSafeBlockTests.m
//  OriginateFoundationTests
//
//  Created by Philip Kluz on 2016-06-23.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

@import XCTest;
@import OriginateFoundation;

@interface OFSafeBlockTests : XCTestCase

@end

@implementation OFSafeBlockTests

#pragma mark - OFSafeBlockTests

- (void)testMainThreadBlockExecution
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Main Thread Execution."];
    
    void (^testBlock)(BOOL test) = ^void(BOOL test) {
        XCTAssert([[NSThread currentThread] isMainThread]);
        [expectation fulfill];
    };
    
    OF_SAFE_EXEC_MAIN(testBlock, YES);
    
    [self waitForExpectationsWithTimeout:5.0
                                 handler:^(NSError * _Nullable error) {
                                     if(error) {
                                         XCTFail(@"Expectation Failed With Error: %@", error);
                                     }
                                 }];
}

- (void)testOffMainThreadBlockExecution
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Off-Main Thread Execution."];
    
    void (^testBlock)(BOOL test) = ^void(BOOL test) {
        XCTAssert(![[NSThread currentThread] isMainThread]);
        [expectation fulfill];
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OF_SAFE_EXEC(testBlock, YES);
    });
    
    [self waitForExpectationsWithTimeout:5.0
                                 handler:^(NSError * _Nullable error) {
                                     if(error) {
                                         XCTFail(@"Expectation Failed With Error: %@", error);
                                     }
                                 }];
}

@end
