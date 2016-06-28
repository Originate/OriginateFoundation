//
//  OFSafeCast.h
//  OriginateFoundation
//
//  Created by Philip Kluz on 2016-06-28.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#ifndef SAFE_CAST

#define SAFE_CAST(object, targetClass) [object isKindOfClass:[targetClass class]] ? (targetClass*)object : nil;

#endif /* SAFE_CAST */
