//
//  FLPropertiesTests.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLPropertiesTests.h"

@implementation FLPropertiesTests

//CFTypeRef ptr = (__bridge_retained CFTypeRef) [[FLWeakRefTestObject alloc] initWithBlock:^(id sender){
//}];
//
//_weakRef = [FLWeakReference weakReference:(__bridge id) ptr];
//[_weakRef addNotifierWithBlock:^(id sender) {
//    [asyncTask setFinished];
//}];
//
//NSLog(@"This is from the background thread: %@", [_weakRef object]);
//
//CFRelease(ptr);

+ (void) addTestCasesToSanityChecks:(NSMutableArray*) array {
//    [array addObject:autorelease_([FLCriticalWeakRefTest new])];
}

@end