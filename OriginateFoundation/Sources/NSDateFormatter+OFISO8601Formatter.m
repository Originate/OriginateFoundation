//
//  NSDateFormatter+OFISO8601Formatter.h
//  OriginateFoundation
//
//  Created by Allen Wu on 2016-06-14.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "NSDateFormatter+OFISO8601Formatter.h"

@implementation NSDateFormatter (OFISO8601Formatter)

+ (instancetype)sharedISO8601DateFormatter
{
    static NSDateFormatter *ISO8601Formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ISO8601Formatter = [[NSDateFormatter alloc] init];
        ISO8601Formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        ISO8601Formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        ISO8601Formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    });
    
    return ISO8601Formatter;
}

+ (NSDate *)of_dateFromISO8601String:(NSString *)string
{
    return [[NSDateFormatter sharedISO8601DateFormatter] dateFromString:string];
}

+ (NSString *)of_ISO8601StringFromDate:(NSDate *)date
{
    return [[NSDateFormatter sharedISO8601DateFormatter] stringFromDate:date];
}

@end
