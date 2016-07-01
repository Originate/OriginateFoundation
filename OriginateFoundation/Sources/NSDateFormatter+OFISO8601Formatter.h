//
//  NSDateFormatter+OFISO8601Formatter.h
//  OriginateFoundation
//
//  Created by Allen Wu on 2016-06-14.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

@import Foundation;

@interface NSDateFormatter (OFISO8601Formatter)

/// Returns a date from an ISO8601 formatted string
+ (NSDate *)of_dateFromISO8601String:(NSString *)string;

/// Returns an ISO8601 formatted string from a date
+ (NSString *)of_ISO8601StringFromDate:(NSDate *)date;

@end
