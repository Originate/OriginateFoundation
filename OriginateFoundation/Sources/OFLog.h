//
//  OFLog.h
//  OriginateFoundation
//
//  Created by Philip Kluz on 2016-06-23.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#ifndef OFLog_h
#define OFLog_h

#ifdef DEBUG
    #define OFLog(fmt, ...) NSLog((@"%s:%d > " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define OFLogModule(module, fmt, ...) NSLog((@"[%@] %s:%d > " fmt), module, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
    #define OFLog(...)
    #define OFLogModule(...)
#endif

#endif
