//
//	NSObject+Comparison.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLObjc.h"

/// @category NSObject(FLComparison)
///  An extension to NSObject to help with copying objects

@interface NSObject (FLComparison)
+ (BOOL) objectIsEqualToObject:(id) object toObject:(id) anotherObject;
@end

NS_INLINE
BOOL FLObjectsAreEqual(id lhs, id rhs) {
    return lhs == rhs || (lhs && rhs && [lhs isEqual:rhs]);
}