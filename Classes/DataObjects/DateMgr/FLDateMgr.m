//
//  NSDate+Decoding.m
//  fBee
//
//  Created by Mike Fullerton on 5/29/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLDateMgr.h"

#import "ISO8601DateFormatter.h"

@implementation FLDateMgr

FLSynthesizeSingleton(FLDateMgr);

- (id) init
{
	if((self = [super init]))
	{
		_formatter = [[ISO8601DateFormatter alloc] init];
		_formatter.parsesStrictly = NO;

	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_formatter);
	FLSuperDealloc();
}

- (NSDate*) ISO8601StringToDate:(NSString*) string
{
	return [_formatter dateFromString:string];
}

- (NSDate*) ISO3339StringToDate:(NSString*) string
{
//			    NSDateFormatter* rfc3339DateFormatter = FLReturnAutoreleased([[NSDateFormatter alloc] init]);
//
//				[rfc3339DateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
//				[rfc3339DateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
//				[rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

	//			data = [rfc3339DateFormatter dateFromString:data];


	return [_formatter dateFromString:string];
}

- (NSString*) ISO8601DateToString:(NSDate*) date
{
	return [_formatter stringFromDate:date];
}

- (NSString*) ISO3339DateToString:(NSDate*) date
{
	FLAssertFailed(@"not implemented");

	return nil;
}


@end
