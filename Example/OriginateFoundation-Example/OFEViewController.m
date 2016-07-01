//
//  OFEViewController.m
//  OriginateFoundation-Example
//
//  Created by Philip Kluz on 2016-07-01.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "OFEViewController.h"

@interface OFEViewController ()

@end

@implementation OFEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    OFLog(@"Hello World #1.");
    OFLogModule(@"XMS", @"Hello World #2.");
    
    [self exampleBlockInvocation];
    [self exampleBlockInvocationMainThread];
    [self exampleISO8601DateParsing];
}

- (void)exampleBlockInvocation
{
    OF_SAFE_EXEC(^(void){
        OFLog(@"Executed Block");
    });
    
    void (^nilBlock)(void) = nil;
    OF_SAFE_EXEC(nilBlock);
}

- (void)exampleBlockInvocationMainThread
{
    OF_SAFE_EXEC_MAIN(^(void){
        OFLog(@"Executed Block on Main Thread: %@.", [NSThread isMainThread] ? @"YES" : @"NO");
    });
    
    void (^nilBlock)(void) = nil;
    OF_SAFE_EXEC_MAIN(nilBlock);
}

- (void)exampleISO8601DateParsing
{
    NSString *ISO8601String = @"2016-07-01T19:59:59Z";
    NSDate *parsed = [NSDateFormatter of_dateFromISO8601String:ISO8601String];
    
    OFLog(@"Parsed NSDate: %@.", parsed);
}

@end
