//
//  OFDateFormatterTests.m
//  OriginateFoundationTests
//
//  Created by Philip Kluz on 2016-06-23.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

@import XCTest;
@import OriginateFoundation;

@interface OFDateFormatterTests : XCTestCase

@end

@implementation OFDateFormatterTests

#pragma mark - OFDateFormatterTests

- (void)testDateFormatterStringFromDate
{
    NSString *fixedString = [[self class] fixedString];
    NSDate *fixedDate = [[self class] fixedDate];
    NSString *computed = [NSDateFormatter of_ISO8601StringFromDate:fixedDate];
    
    XCTAssert([computed isEqualToString:fixedString]);
}

- (void)testDateFormatterDateFromString
{
    NSString *fixedString = [[self class] fixedString];
    NSDate *fixedDate = [[self class] fixedDate];
    NSDate *computed = [NSDateFormatter of_dateFromISO8601String:fixedString];
    
    XCTAssert([computed isEqualToDate:fixedDate]);
}

#pragma mark - Data

+ (NSString *)fixedString
{
    return @"2016-07-01T19:59:59Z";
}

+ (NSDate *)fixedDate
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2016;
    components.month = 7;
    components.day = 1;
    components.hour = 19;
    components.minute = 59;
    components.second = 59;
    components.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    return [calendar dateFromComponents:components];
}

@end
