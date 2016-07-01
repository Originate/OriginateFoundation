//
//  OFSafeBlock.h
//  OriginateFoundation
//
//  Created by Philip Kluz on 2016-06-28.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#ifndef OF_SAFE_EXEC

#define OF_SAFE_EXEC(block,...)      (block ? block(__VA_ARGS__) : nil)
#define OF_SAFE_EXEC_MAIN(block,...) if (block && [[NSThread currentThread] isMainThread]) {\
                                         block(__VA_ARGS__);\
                                     } else if (block) {\
                                         dispatch_async(dispatch_get_main_queue(), ^{\
                                             block(__VA_ARGS__);\
                                         });\
                                     }

#endif /* OF_SAFE_EXEC */
