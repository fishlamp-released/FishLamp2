//
//	NSObject+Comparison.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampMinimum.h"

/// @category NSObject(GtComparison)
///  An extension to NSObject to help with copying objects

@interface NSObject (GtComparison)
+ (BOOL) objectIsEqual:(id) object toObject:(id) anotherObject;
@end