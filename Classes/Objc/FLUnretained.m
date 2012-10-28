//
//  FLUnretained.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUnretained.h"
#import "FLDeallocNotifier.h"

@implementation FLUnretained

@synthesize notifier = _notifier;

//- (void) setToNil:(FLDeletedObjectReference*) sender {
//    FLAssert_v(sender.deletedObject == _object, @"message sent to wrong unretained?");
//    self.object = nil;
//    _deadObject = sender.deletedObject;
//}

- (id) object {
    return _weakRef.object;
}

#if FL_NO_ARC
- (void) dealloc {
    [_weakRef release];
    [super dealloc];
}
#endif

- (void) setObject:(id) object {
    _deadObject = object;
    _weakRef.object = object;
}

- (id) init {
    _weakRef = [FLWeakReference new];
    return self;
}

- (id) initWithObject:(id) object {
    self = [self init];
    if(self) {
        self.object = object;
    }
    return self;
}

+ (id) unretained:(id) object {
	return FLReturnAutoreleased([[[self class] alloc] initWithObject:object]);
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    id myObject = self.object;
    if (myObject ) {
        [invocation setTarget:myObject];
        [invocation invoke];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel  {
    return [self.object methodSignatureForSelector:sel];
}

- (BOOL) isEqual:(id) object {
    
    id myObject = self.object;
    
    if(self == object || myObject == object) {
        return YES;
    }
    
    id theObject = object;
    if([object isKindOfClass:[FLUnretained class]]) {
        theObject = [object object];
    
        if( theObject == myObject ) {
            return YES;
        }
    }

    if(myObject) {
        return theObject ? [myObject isEqual:theObject] : NO;
    }
    else if(_deadObject && theObject == _deadObject) {
        return YES;
    }

    return NO;
}

- (NSUInteger)hash {
    return _weakRef.hash;
}

- (NSString*) description {
    id myObject = self.object;
    return myObject ? [myObject description] : @"(NULL)";
}

@end

@implementation NSObject (FLUnretained)
- (id) unretained {
    return [FLUnretained unretained:self];
}
@end

#if TEST
@interface FLUnretainedUnitTests : FLSanityCheck
@end

@implementation FLUnretainedUnitTests

- (void) testMethodForwarding {

    NSString* str = @"hello world";
    
    id unretained = [str unretained];
    
    FLAssertIsNotNil_(unretained);

    FLAssert_([unretained rangeOfString:@"hello"].location == 0);

    FLTestLog(@"Testing 123: %@", [unretained description]);
    
    NSString* newString = [NSString stringWithString:unretained];
    
    FLAssertObjectsAreEqual_(newString, str);
    
    FLTestLog(@"Testing 345: %@", newString);
}

- (void) testDeletion_off {
    
//    NSString* str = [[NSString alloc] initWithFormat:@"hello %@", @"world"];
//    
//    id unretained = [str unretained];
//    FLReleaseWithNil(str);
//    
//    FLAsyncRunner* runner = [FLAsyncRunner asyncRunner];
//    [runner waitForCondition:^(BOOL* metCondition){
//        *metCondition = ([unretained object] == nil);
//    }];
//
//    FLAssert_(runner.isFinished);
//    FLAssertIsNil_([unretained object]);
    
}
@end
#endif

