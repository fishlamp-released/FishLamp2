//
//  NSString+GUID.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/3/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "NSString+GUID.h"
#import "FLCoreFoundation.h"

@implementation NSString (GUID)

+ (NSString*) guidString {
	CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
	NSString* str = FLAutorelease(bridge_transfer_(NSString*, CFUUIDCreateString(kCFAllocatorDefault, uuid)));
	CFRelease(uuid);
	return str;
}

+ (NSString*) zeroGuidString {
	
// TODO. Use static create methods or dispatch_once    
    static NSString* s_zero_guid = nil;
	if(!s_zero_guid) {
		@synchronized(self) {
			if(!s_zero_guid) {
				CFUUIDRef uuid = CFUUIDCreateWithBytes(kCFAllocatorDefault, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
				s_zero_guid = bridge_transfer_(NSString*, CFUUIDCreateString(kCFAllocatorDefault, uuid));
				CFRelease(uuid);
			}
		}
	}
	
	return s_zero_guid;
	
}

@end