//
//  OFEAppDelegate.m
//  OriginateFoundation-Example
//
//  Created by Philip Kluz on 2016-07-01.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "OFEAppDelegate.h"
#import "OFEViewController.h"

@implementation OFEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[OFEViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
