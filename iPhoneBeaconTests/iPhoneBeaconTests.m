//
//  iPhoneBeaconTests.m
//  iPhoneBeaconTests
//
//  Created by Ayaka Tominaga on 2014/11/24.
//  Copyright (c) 2014年 Ayaka Tominaga
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface iPhoneBeaconTests : XCTestCase

@end

@implementation iPhoneBeaconTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
