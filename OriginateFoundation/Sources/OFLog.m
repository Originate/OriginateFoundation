//
//  OFLog.m
//  OriginateFoundation
//
//  Created by Philip Kluz on 2016-06-23.
//  Copyright © 2016 Originate Inc. All rights reserved.
//
//  Based on PKLog by Philip Kluz.
//  Copyright © 2013 Philip Kluz. All rights reserved.
//
//
//  PKLog - The MIT License (MIT)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "OFLog.h"
#import <libgen.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-macros"

#define OF_STACK_IDX 0
#define OF_FRAMEWORK_IDX 1
#define OF_MEMORY_ADDR_IDX 2
#define OF_CLASS_CALLER_IDX 3
#define OF_FUNCTION_CALLER_IDX 4
#define OF_LINE_CALLER_IDX 5

#pragma clang diagnostic pop

#ifdef DEBUG
NSDateFormatter * __OFLogDateFormatter() {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.timeZone = [NSTimeZone localTimeZone];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
    });

    return formatter;
}

dispatch_queue_t __OFLogQueue() {
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.originate.foundation.log", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

#endif

void OFLog(NSString *format, ...)
{
#ifdef DEBUG
    if (format)
    {
        NSString *sourceString = [NSThread callStackSymbols][1];
        NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
        NSMutableArray *array = [[sourceString componentsSeparatedByCharactersInSet:separatorSet] mutableCopy];
        [array removeObject:@""];
        
        NSDateFormatter *dateFormatter = __OFLogDateFormatter();
        
        va_list argumentList;
        va_start(argumentList, format);
        
        NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:argumentList];
        
        const char *class = [array[OF_CLASS_CALLER_IDX] UTF8String];
        const char *line = [array[OF_LINE_CALLER_IDX] UTF8String];
        const char *dateTime = [[dateFormatter stringFromDate:[NSDate date]] UTF8String];
        
        NSString *stringToLog = [NSString stringWithFormat:@"%s [%s:%s] - %@\n", dateTime, class, line, formattedString];
        
        dispatch_async(__OFLogQueue(), ^{
            printf("%s", [stringToLog UTF8String]);
        });
        
        va_end(argumentList);
    }
#endif
}
