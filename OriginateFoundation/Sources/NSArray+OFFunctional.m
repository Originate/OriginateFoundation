//
//  NSArray+OFFunctional.h
//  OriginateFoundation
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

#import "NSArray+OFFunctional.h"

@implementation NSArray (OFFunctional)

- (NSArray *)of_map:(id (^)(id obj))func
{
    return [[self of_foldl:[NSMutableArray array]
                     block:^id(NSMutableArray *acc, id obj) {
        [acc addObject:func(obj)];
        return acc;
    }] copy];
}

- (NSArray *)of_mapIndex:(id (^)(id obj, NSUInteger idx))func
{
    return [[self of_foldlIndex:[NSMutableArray array]
                          block:^id(NSMutableArray *acc, id obj, NSUInteger idx) {
        [acc addObject:func(obj, idx)];
        return acc;
    }] copy];
}

- (NSArray *)of_filter:(BOOL (^)(id obj))func
{
    return [[self of_foldlIndex:[NSMutableArray array]
                          block:^id(NSMutableArray *acc, id obj, NSUInteger idx) {
        if (func(obj)) {
            [acc addObject:obj];
        }
        return acc;
    }] copy];
}

- (NSArray *)of_reverse
{
    return [[self of_foldr:[NSMutableArray array]
                     block:^id(NSMutableArray *acc, id obj) {
        [acc addObject:obj];
        return acc;
    }] copy];
}

- (NSArray *)of_tail
{
    if ([self count] == 0) {
        return nil;
    }
    
    return [self subarrayWithRange:NSMakeRange(1, [self count] - 1)];
}

- (NSArray *)of_initial
{
    if ([self count] == 0) {
        return nil;
    }
    
    return [self subarrayWithRange:NSMakeRange(0, [self count] - 1)];
}

- (NSArray *)of_take:(NSUInteger)value
{
    return [self subarrayWithRange:NSMakeRange(0, MIN(value, [self count]))];
}

- (NSArray *)of_takeWhile:(BOOL (^)(id obj))func
{
    if (!func) {
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (id obj in self) {
        if (func(obj)) {
            [result addObject:obj];
        } else {
            break;
        }
    }
    
    return [result copy];
}

- (NSArray *)of_flatten
{
    NSMutableArray *result = [NSMutableArray array];
    
    for (id obj in self) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [result addObjectsFromArray:[obj of_flatten]];
        } else {
            [result addObject:obj];
        }
    }
    
    return [result copy];
}

- (NSArray *)of_sort
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
}

- (id)of_secondObject
{
    if ([self count] > 1) {
        return self[1];
    }
    
    return nil;
}

- (id)of_maximum
{
    return [[self of_sort] lastObject];
}

- (id)of_minimum
{
    return [[self of_sort] firstObject];
}

- (NSArray *)of_zip:(NSArray *)array
{
    NSUInteger resultLength = MIN([self count], [array count]);
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < resultLength; i++) {
        [result addObject:@[self[i], array[i]]];
    }
    
    return [result copy];
}

- (NSArray *)of_zip:(NSArray *)array using:(id (^)(id, id))func
{
    if (!func) {
        return nil;
    }
    
    return [[self of_zip:array] of_map:^id(NSArray *pair) {
        id first = [pair firstObject];
        id second = [pair of_secondObject];
        
        return func(first, second);
    }];
}

- (id)of_foldlIndex:(id)initial block:(id (^)(id acc, id obj, NSUInteger idx))func
{
    if (!func) {
        return nil;
    }
    
    id result = initial;
    
    for (int i = 0; i < self.count; i++) {
        result = func(result, self[i], i);
    }
    
    return result;
}

- (id)of_foldrIndex:(id)initial block:(id (^)(id acc, id obj, NSUInteger idx))func
{
    if (!func) {
        return nil;
    }
    
    id result = initial;
    
    for (int i = (int)(self.count - 1); i >= 0; i--) {
        result = func(result, self[i], i);
    }
    
    return result;
}

- (id)of_foldl:(id)initial block:(id (^)(id acc, id obj))func
{
    return [self of_foldlIndex:initial
                         block:^id(id acc, id obj, NSUInteger _) {
        return func(acc, obj);
    }];
}

- (id)of_foldr:(id)initial block:(id (^)(id acc, id obj))func
{
    return [self of_foldrIndex:initial
                         block:^id(id acc, id obj, NSUInteger _) {
        return func(acc, obj);
    }];
}

- (BOOL)of_any:(BOOL(^)(id obj))func
{
    for (id obj in self) {
        if (func(obj)) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)of_all:(BOOL(^)(id obj))func
{
    for (id obj in self) {
        if (!func(obj)) {
            return NO;
        }
    }
    
    return YES;
}

- (id)of_find:(BOOL(^)(id obj))func
{
    for (id obj in self) {
        if (func(obj)) {
            return obj;
        }
    }
    
    return nil;
}

- (void)of_each:(void (^)(id obj))func
{
    if (!func) {
        return;
    }
    
    for (id obj in self) {
        func(obj);
    }
}

@end

