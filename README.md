# OriginateFoundation
> OriginateFoundation bundles fundamental categories and classes commonly used to streamline iOS development.

# Installation with CocoaPods
Add the following lines to your Podfile and run `pod install`:

```ruby
source 'https://github.com/Originate/CocoaPods.git'
pod 'OriginateFoundation'
```

# Installation with Carthage
Add the following line to your Cartfile and run `carthage update`:
```
github "Originate/OriginateFoundation"
```

# Requirements
- iOS 8.0+

# Usage
## Import the Framework
After adding the module to your respective build target, you need to import it wherever you would like to use it.

```objective-c
@import OriginateFoundation;
```

## Executing Blocks Safely
When designing or consuming block based APIs, we sometimes do not care about a `completionBlock` or similar. In those cases it is common to pass `nil` as the arguments value. If we were to try and execute a `nil` block, the application will crash.

### OF_SAFE_EXEC()
In order to avoid having to write…
```objective-c
if (completionHandler) {
    completionHandler(arg1, arg2,…);
}
```
…all the time, `OriginateFoundation` provides the `OF_SAFE_EXEC()` family of macros. The above code can be re-written as:
```objective-c
// Will safely execute on the current queue.
OF_SAFE_EXEC(completionHandler, arg1, arg2,…);
```

### OF_SAFE_EXEC_MAIN()
The above case is often times also commonly accompanied / wrapped by a `dispatch_async` onto the main queue. In case we are on the main queue already, we’re unnecessarily delaying the execution of the block by pushing it to the end of the queue. 

`OF_SAFE_EXEC_MAIN()` can assist in this case, by guaranteeing that the passed block will be both checked for presence, and executed immediately in case we are already on the main queue. If we are not on the main queue, execution is scheduled asynchronously on it.

```objective-c
// Will safely execute on the main queue (immediately if possible).
OF_SAFE_EXEC_MAIN(completionHandler, arg1, arg2,…);
```

## Logging
The default `NSLog()` function does not get stripped automatically when building for release. Neither does it contain information about the function and context in which it was used. 

### OFLog()
`OFLog()` ensures that…
- …the logging statements are only included when building for DEBUG builds.
- …additional information regarding the call-site is automatically included.

```objective-c
// MyViewController.m
43: …
44: - (void)viewDidLoad {
45:    OFLog(@"Hello World");
46: }
47: …
```

```objective-c
// Output:
2016-07-01 12:00:00.000 BUILD_TARGET[PID:MACHPORT] -[MyViewController viewDidLoad]:45 > Hello World.
```

### OFLogModule()
`OFLogModule()` behaves the same as `OFLog()`, except that it takes an additional parameter at the first position, which can be any object type. The idea is to have a convenient way to scope log statements by module or severity for easier parsing afterwards.

```objective-c
// MyViewController.m
43: …
44: - (void)viewDidLoad {
45:    OFLogModule(@"AppCore", @"Application Core Loaded");
46: }
47: …
```

```objective-c
// Output:
2016-07-01 12:00:00.000 BUILD_TARGET[PID:MACHPORT] [AppCore] -[MyViewController viewDidLoad]:45 > Hello World.
```

## ISO8601DateFormatter
Up until and including iOS 9, `Foundation` did not provide built-in mechanisms to parse ISO8601 date-time strings. Our category on `NSDateFormatter` makes this simple:

```objective-c
NSString *string = @"2016-07-01T19:59:59Z"; // ISO 8601 String
NSDate *date = [NSDateFormatter string];
```

```objective-c
NSDate *date = [NSDate date];
NSString *string = [NSDate of_ISO8601StringFromDate:date];
```

## OFFunctional
Based on [PKFunctional](https://github.com/pkluz/PKFunctional) you have access to an entire class of commonly used higher-order functions. This includes but is not limited to `map`, `filter`, `reduce`, `zip` and others.

```objective-c
NSArray *numbers = @[@1, @2, @3, @4];
NSArray *doubled = [numbers of_map:^NSNumber *(NSNumber *number) {
    return @([number integerValue] * 2);
}];

// `doubled` is now equal to @[@2, @4, @6, @8].
```

Consult `NSArray+OFFunctional.h` for more details and `OFFunctionalTests.m` for example usage.

# License
`OriginateFoundation` is available under the MIT license. See the LICENSE file for more info.