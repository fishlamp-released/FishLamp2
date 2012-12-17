//
//  FLFailable.h
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@protocol FLFallibleDelegate;

@protocol FLFallible <NSObject>
@optional
@property (readwrite, assign) id<FLFallibleDelegate> fallibleDelegate;
- (BOOL) tryHandlingError:(NSError*) error;
@end

@protocol FLFallibleDelegate <NSObject>
- (BOOL) tryHandlingError:(NSError*) error forObject:(id) object;
@end

//@interface NSObject (FLFallible) 
//- (BOOL) tryHandlingError:(NSError*) error;
//@end

NS_INLINE
BOOL FLTryHandlingErrorForObject(NSError* error, id object) {
    if( [object respondsToSelector:@selector(fallibleDelegate)] &&
        [[object fallibleDelegate] tryHandlingError:error forObject:object]) {
        return YES;
    }

    if( [object respondsToSelector:@selector(tryHandlingError:)] && 
        [object tryHandlingError:error]) {
        return YES;
    }

    return NO;
}