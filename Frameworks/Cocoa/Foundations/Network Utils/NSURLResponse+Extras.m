//
//  NSURLResponse+(Extras).m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "NSURLResponse+Extras.h"
#import "FLPrettyString.h"

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
	
	   return FLAutorelease([[NSError alloc] initWithDomain:[FLFrameworkErrorDomain instance] 
			code:statusCode
			userInfo:errorInfo]);
	}

	return nil;
}

- (void) logToStringBuilder:(FLPrettyString*) prettyString {

	NSDictionary* headers = [self allHeaderFields];
	
	[prettyString appendLineWithFormat:@"HTTP response: %d (%@)", self.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:self.statusCode]];

	[prettyString appendLine:@"headers:"];

    [prettyString indent:^{
        for(id key in headers) {
            [prettyString appendLineWithFormat:@"%@: %@", [key description], [[headers objectForKey:key] description]];
        }
    }];
}

@end
