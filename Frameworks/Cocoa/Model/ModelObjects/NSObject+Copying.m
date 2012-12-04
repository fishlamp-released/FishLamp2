//
//  NSObject+Copying.m
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "NSObject+Copying.h"

@implementation NSObject (FLCopyable)
- (void) copySelfTo:(id) object {
}
@end

id FLCopyOrRetainObject(id src) {	
	if([src conformsToProtocol:@protocol(NSMutableCopying)]) {
		return autorelease_([src mutableCopy]);
	}
	else if([src conformsToProtocol:@protocol(NSCopying)]) {
		return autorelease_([src copy]);
	}
	else {
		return autorelease_(retain_(src));
	}
	
	return nil;
}
