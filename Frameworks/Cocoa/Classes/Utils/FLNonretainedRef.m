//
//  FLNonretainedRef.m
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/5/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLNonretainedRef.h"

@implementation FLNonretainedRef

@dynamic object;

+ (FLNonretainedRef*) nonretained:(id) object {
	return FLAutorelease([[FLNonretainedRef alloc] initWithObject:object]);
}

@end
