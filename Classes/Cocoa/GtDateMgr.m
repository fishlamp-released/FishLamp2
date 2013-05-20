//
//  NSDate+Decoding.m
//  fBee
//
//  Created by Mike Fullerton on 5/29/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDateMgr.h"

#import "ISO8601DateFormatter.h"

@implementation GtDateMgr

GtSynthesizeSingleton(GtDateMgr);

- (id) init
{
	if((self = [super init]))
	{
		m_formatter = [[ISO8601DateFormatter alloc] init];
		m_formatter.parsesStrictly = NO;

	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_formatter);
	GtSuperDealloc();
}

- (NSDate*) ISO8601StringToDate:(NSString*) string
{
	return [m_formatter dateFromString:string];
}

- (NSDate*) ISO3339StringToDate:(NSString*) string
{
//			    NSDateFormatter* rfc3339DateFormatter = GtReturnAutoreleased([[NSDateFormatter alloc] init]);
//
//				[rfc3339DateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
//				[rfc3339DateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
//				[rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

	//			data = [rfc3339DateFormatter dateFromString:data];


	return [m_formatter dateFromString:string];
}

- (NSString*) ISO8601DateToString:(NSDate*) date
{
	return [m_formatter stringFromDate:date];
}

- (NSString*) ISO3339DateToString:(NSDate*) date
{
	GtAssertFailed(@"not implemented");

	return nil;
}


@end
