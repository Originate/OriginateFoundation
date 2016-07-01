//
//  OFFunctionalTests.m
//  OriginateFoundationTests
//
//  Created by Philip Kluz on 2016-07-01.
//  Copyright © 2016 Originate Inc. All rights reserved.
//
//  Based on PKFunctional by Philip Kluz. Released under the MIT license.
//  Copyright © 2015 Philip Kluz. All rights reserved.
//
//  PKFunctional > NSArray+PKFunctional.h
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Philip Kluz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

@import UIKit;
@import XCTest;
@import OriginateFoundation;

@interface OFFunctionalTests : XCTestCase

@end

@implementation OFFunctionalTests


- (void)testArrayMapEmpty
{
    NSArray *numbers = @[];
    NSArray *expected = @[];
    
    NSArray *result = [numbers of_map:nil];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of map (= %@) did not match expected value (= %@).", result, expected);
}

- (void)testArrayMap
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *expected = [self arrayOfNumbersIncremented];
    
    NSArray *result = [numbers of_map:^NSNumber *(NSNumber *number)
                       {
                           return @([number integerValue] + 1);
                       }];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of map (= %@) did not match expected value (= %@).", result, expected);
}

- (void)testArrayMapIndexEmpty
{
    NSArray *numbers = @[];
    NSArray *expected = @[];
    
    NSArray *result = [numbers of_mapIndex:nil];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of mapIndex (= %@) did not match expected value (= %@).", result, expected);
}

- (void)testArrayMapIndex
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *expected = [self arrayOfNumbersIncremented];
    
    NSArray *result = [numbers of_mapIndex:^NSNumber *(NSNumber *number, NSUInteger idx)
                       {
                           NSLog(@"Index: %@", @(idx));
                           return @([number integerValue] + 1);
                       }];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of mapIndex (= %@) did not match expected value (= %@).", result, expected);
}

- (void)testArrayFilter
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *evenNumbers = [self arrayOfEvenNumbers];
    
    NSArray *result = [numbers of_filter:^BOOL(NSNumber *number)
                       {
                           return [number integerValue] % 2 == 0;
                       }];
    
    XCTAssert([evenNumbers isEqualToArray:result], @"Error: Result of filter (= %@) did not match expected value (= %@).", result, evenNumbers);
}

- (void)testArrayReversal
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *reversed = [self reversedArrayOfNumbers];
    
    NSArray *result = [numbers of_reverse];
    
    XCTAssert([reversed isEqualToArray:result], @"Error: Result of array reversal (= %@) did not match expected value (= %@).", result, reversed);
}

- (void)testArrayTail
{
    NSArray *numbers = [self arrayOfEvenNumbers];
    NSArray *tail = [self evenNumbersTail];
    
    NSArray *result = [numbers of_tail];
    
    XCTAssert([tail isEqualToArray:result], @"Error: Result of array tail (= %@) did not match expected value (= %@).", result, tail);
}

- (void)testArrayInitial
{
    NSArray *numbers = [self arrayOfEvenNumbers];
    NSArray *initial = [self evenNumbersInitial];
    
    NSArray *result = [numbers of_initial];
    
    XCTAssert([initial isEqualToArray:result], @"Error: Result of array initial (= %@) did not match expected value (= %@).", result, initial);
}

- (void)testArrayTake
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *take = [self arrayOfNumbersTake3];
    
    NSArray *result = [numbers of_take:3];
    
    XCTAssert([take isEqualToArray:result], @"Error: Result of array take 3 (= %@) did not match expected value (= %@).", result, take);
}

- (void)testArrayTakeZero
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *take = [NSArray array];
    
    NSArray *result = [numbers of_take:0];
    
    XCTAssert([take isEqualToArray:result], @"Error: Result of array take 0 (= %@) did not match expected value (= %@).", result, take);
}

- (void)testArrayTakeMax
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *take = [self arrayOfNumbers];
    
    NSArray *result = [numbers of_take:99];
    
    XCTAssert([take isEqualToArray:result], @"Error: Result of array take 99 (= %@) did not match expected value (= %@).", result, take);
}

- (void)testArrayTakeWhile
{
    // Random:
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *expectedResult = [self arrayOfNumbersTake3];
    
    NSArray *result = [numbers of_takeWhile:^BOOL(NSNumber *number)
                       {
                           return [number integerValue] < 3;
                       }];
    
    XCTAssert([expectedResult isEqualToArray:result], @"Error: Result of array take while < 3 (= %@) did not match expected value (= %@).", result, expectedResult);
    
    // Empty Result:
    NSArray *expectedResultEmpty = [NSArray array];
    
    NSArray *resultEmpty = [numbers of_takeWhile:^BOOL(NSNumber *number)
                            {
                                return NO;
                            }];
    
    XCTAssert([expectedResultEmpty isEqualToArray:resultEmpty], @"Error: Result of array take while NO (= %@) did not match expected value (= %@).", resultEmpty, expectedResultEmpty);
    
    // All Result:
    NSArray *expectedResultAll = [numbers copy];
    
    NSArray *resultAll = [numbers of_takeWhile:^BOOL(NSNumber *number)
                          {
                              return YES;
                          }];
    
    XCTAssert([expectedResultAll isEqualToArray:resultAll], @"Error: Result of array take while YES (= %@) did not match expected value (= %@).", resultAll, expectedResultAll);
}

- (void)testFlatten
{
    NSArray *numbers = @[@[@0, @1], @[@2, @[@3, @4], @5, @[@6, @7, @8, @[@9], @[]]]];
    NSArray *expectedResult = [self arrayOfNumbers];
    
    NSArray *result = [numbers of_flatten];
    
    XCTAssert([expectedResult isEqualToArray:result], @"Error: Result of array flattening (= %@) did not match expected value (= %@).", result, expectedResult);
}

- (void)testArrayMinimum
{
    NSArray *numbers = [self arrayOfNumbers];
    NSNumber *expectedMinimum = @0;
    
    id minimum = [numbers of_minimum];
    
    XCTAssert([minimum isEqualToNumber:expectedMinimum], @"Error: Result of minimum (= %@) did not match expected value (= %@)", minimum, expectedMinimum);
}

- (void)testArrayMaximum
{
    NSArray *numbers = [self arrayOfNumbers];
    NSNumber *expectedMaximum = @9;
    
    id maximum = [numbers of_maximum];
    
    XCTAssert([maximum isEqualToNumber:expectedMaximum], @"Error: Result of maximum (= %@) did not match expected value (= %@)", maximum, expectedMaximum);
}

- (void)testArraySecondObject
{
    NSArray *numbers = [self arrayOfNumbers];
    NSNumber *expected = @1;
    
    id result = [numbers of_secondObject];
    
    XCTAssert([expected isEqualToNumber:result], @"Error: Result of second object (= %@) did not match expected value (= %@)", result, expected);
}

- (void)testArrayZip
{
    NSArray *numbers1 = [self arrayOfNumbers];
    NSArray *numbers2 = [self arrayOfNumbersTake3];
    NSArray *expected = @[@[@0, @0], @[@1, @1], @[@2, @2]];
    
    NSArray *result = [numbers1 of_zip:numbers2];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of zip (= %@) did not match expected value (= %@)", result, expected);
}

- (void)testArrayZipUsing
{
    NSArray *numbers1 = [self arrayOfNumbers];
    NSArray *numbers2 = [self arrayOfNumbersTake3];
    NSArray *expected = @[@0, @2, @4];
    
    NSArray *result = [numbers1 of_zip:numbers2 using:^id(id obj1, id obj2) {
        return @([obj1 integerValue] + [obj2 integerValue]);
    }];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of zip:using: (= %@) did not match expected value (= %@)", result, expected);
}

- (void)testArrayZipUsingNil
{
    NSArray *numbers1 = [self arrayOfNumbers];
    NSArray *numbers2 = [self arrayOfNumbersTake3];
    NSArray *expected = nil;
    
    NSArray *result = [numbers1 of_zip:numbers2 using:nil];
    
    XCTAssert(expected == result, @"Error: Result of zip:using: (= %@) did not match expected value (= %@)", result, expected);
}

- (void)testArrayFoldr
{
    NSArray *numbers = [self arrayOfNumbers];
    NSNumber *sum = @(45);
    
    NSNumber *result = [numbers of_foldr:@(0) block:^NSNumber *(NSNumber *number, NSNumber *obj)
                        {
                            return @([number integerValue] + [obj integerValue]);
                        }];
    
    XCTAssert([sum isEqualToNumber:result], @"Error: Result of array foldl (= %@) did not match expected value (= %@).", result, sum);
}

- (void)testArrayFoldl
{
    NSArray *numbers = [self arrayOfDivisibleNumbers];
    NSNumber *quotient = @(2);
    
    NSNumber *result = [numbers of_foldl:@(256) block:^NSNumber *(NSNumber *number, NSNumber *obj)
                        {
                            return @([number floatValue] / [obj floatValue]);
                        }];
    
    XCTAssert([quotient isEqualToNumber:result], @"Error: Result of array foldl (= %@) did not match expected value (= %@).", result, quotient);
}

- (void)testArrayAny
{
    BOOL anyThrees = [[self arrayOfNumbers] of_any:^BOOL(id obj) {
        return [obj integerValue] == 3;
    }];
    
    XCTAssert(anyThrees);
    
    BOOL anyOdds = [[self arrayOfEvenNumbers] of_any:^BOOL(id obj) {
        return [obj integerValue] % 2 == 1;
    }];
    
    XCTAssertFalse(anyOdds);
}

- (void)testArrayAll
{
    BOOL allLessThanTen = [[self arrayOfNumbers] of_all:^BOOL(id obj) {
        return [obj integerValue] < 10;
    }];
    
    XCTAssert(allLessThanTen);
    
    BOOL allGreaterThanZero = [[self arrayOfNumbers] of_all:^BOOL(id obj) {
        return [obj integerValue] > 0;
    }];
    
    XCTAssertFalse(allGreaterThanZero);
}

- (void)testArrayFind
{
    NSArray *numbers = [self arrayOfNumbers];
    
    NSNumber *foundNumber = [numbers of_find:^BOOL(id obj) {
        return [obj integerValue] == 5;
    }];
    
    XCTAssert([foundNumber isEqualToNumber:@(5)]);
    
    foundNumber = [numbers of_find:^BOOL(id obj) {
        return [obj integerValue] == 1234;
    }];
    
    XCTAssertNil(foundNumber);
}

- (void)testArrayEach
{
    __block NSInteger sum = 0;
    
    NSArray *numbers = [self arrayOfNumbers];
    
    [numbers of_each:^(NSNumber *number) {
        sum += [number integerValue];
    }];
    
    XCTAssert(sum == 45);
}

#pragma mark - Test Data

- (NSArray *)arrayOfNumbers
{
    return @[@(0), @(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9)];
}

- (NSArray *)arrayOfNumbersTake3
{
    return @[@(0), @(1), @(2)];
}

- (NSArray *)arrayOfDivisibleNumbers
{
    return @[@(16), @(1), @(2), @(4)];
}

- (NSArray *)reversedArrayOfNumbers
{
    return @[@(9), @(8), @(7), @(6), @(5), @(4), @(3), @(2), @(1), @(0)];
}

- (NSArray *)arrayOfEvenNumbers
{
    return @[@(0), @(2), @(4), @(6), @(8)];
}

- (NSArray *)evenNumbersTail
{
    return @[@(2), @(4), @(6), @(8)];
}

- (NSArray *)evenNumbersInitial
{
    return @[@(0), @(2), @(4), @(6)];
}

- (NSArray *)arrayOfOddNumbers
{
    return @[@(1), @(3), @(5), @(7), @(9)];
}

- (NSArray *)arrayOfNumbersIncremented
{
    return @[@(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9), @(10)];
}

@end