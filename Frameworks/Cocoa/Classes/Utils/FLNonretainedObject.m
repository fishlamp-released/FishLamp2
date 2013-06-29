//
//  FLNonretainedObject.m
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/5/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLNonretainedObject.h"

@implementation FLNonretainedObject

@dynamic object;

+ (FLNonretainedObject*) nonretainedObject:(id) object {
	return FLAutorelease([[FLNonretainedObject alloc] initWithObject:object]);
}

@end
