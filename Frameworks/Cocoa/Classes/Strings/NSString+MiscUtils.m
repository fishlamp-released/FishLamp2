//
//  NSString+MiscUtils.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSString+MiscUtils.h"

#define KILO 1024 
#define MEGA 1048576 
#define GIGA 1073741824

@implementation NSString (MiscUtils)

+ (NSString*) localizedStringForByteSize:(long long) size {
	if ( size < KILO ) {
		return [NSString stringWithFormat:@"%lld bytes", size];
	} 
    else if ( size < MEGA ) {
		return [NSString stringWithFormat:@"%.2f KB", size /(float)KILO];
	} 
    else if ( size < GIGA ) {
		return [NSString stringWithFormat:@"%.2f MB", size /(float)MEGA];
	} 
    else {
		return [NSString stringWithFormat:@"%.2f GB", size /(float)GIGA];
	}
}

+ (NSString*) localizedStringForTime:(NSTimeInterval) secs {

	NSMutableString *time = [NSMutableString string];
	if ( secs > 3600 ) {
		[time appendFormat:@"%02ld %@ ", (long)floor(secs / 3600.0), NSLocalizedString(@"hours", nil)];
		secs = fmod(secs, 3600.0);
	}
	if ( secs > 60 ) {
		[time appendFormat:@"%02ld %@ ", (long)floor(secs / 60.0), NSLocalizedString(@"minutes", nil)];
		secs = fmod(secs, 60.0);
	}
	[time appendFormat:@"%02ld %@", (long)ceil(secs), NSLocalizedString(@"seconds", nil)];
	return time;
}

@end

