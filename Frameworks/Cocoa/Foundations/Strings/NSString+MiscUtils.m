//
//  NSString+MiscUtils.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "NSString+MiscUtils.h"

#define KILO (1 << 10)
#define MEGA (1 << 20)
#define GIGA ((unsigned)1 << 30)

@implementation NSString (MiscUtils)

+ (NSString*) localizedStringForByteSize:(long long) size {
	if ( size < KILO ) {
		return [NSString stringWithFormat:@"%lld bytes", size];
	} 
    else if ( size < MEGA ) {
		return [NSString stringWithFormat:@"%.1f KB", size /(float)KILO];
	} 
    else if ( size < GIGA ) {
		return [NSString stringWithFormat:@"%.1f MB", size /(float)MEGA];
	} 
    else {
		return [NSString stringWithFormat:@"%.1f GB", size /(float)GIGA];
	}
}

+ (NSString*) localizedStringForTime:(int) secs
{
	NSMutableString *time = [NSMutableString string];
	if ( secs > 3600 ) {
		[time appendFormat:@"%d %@ ", secs / 3600, NSLocalizedString(@"hours", nil)];
		secs = secs % 3600;
	}
	if ( secs > 60 ) {
		[time appendFormat:@"%d %@ ", secs / 60, NSLocalizedString(@"minutes", nil)];
		secs = secs % 60;
	}
	[time appendFormat:@"%d %@", secs, NSLocalizedString(@"seconds", nil)];
	return time;
}

@end

