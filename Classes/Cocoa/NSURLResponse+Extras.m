//
//  NSURLResponse+(Extras).m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSURLResponse+Extras.h"
#import "GtStringBuilder.h"

@implementation NSHTTPURLResponse (Extras)

- (NSError*) simpleHttpResponseErrorCheck 
{
	NSInteger statusCode = [self statusCode];
	if(statusCode >= 400)
	{
		NSDictionary *errorInfo
		  = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
			  NSLocalizedString(@"Server returned error code:%d (%@)",@""),
				statusCode,
				[NSHTTPURLResponse localizedStringForStatusCode:statusCode]
				]
				forKey:NSLocalizedDescriptionKey];
	
	   return GtReturnAutoreleased([[NSError alloc] initWithDomain:GtErrorDomain 
			code:statusCode
			userInfo:errorInfo]);
	}

	return nil;
}

- (void) logToStringBuilder:(GtStringBuilder*) builder
{
	NSDictionary* headers = [self allHeaderFields];
	
	[builder appendLineWithFormat:@"HTTP response: %d (%@)", self.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:self.statusCode]];
	[builder appendLine:@"headers:"];
//	[builder tabIn];
	
	for(id key in headers)
	{
		[builder appendLineWithFormat:@"%@: %@", [key description], [[headers objectForKey:key] description]];
	}

//	[builder tabOut];
}

@end
