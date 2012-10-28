//
//  NSURLResponse+(Extras).m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "NSURLResponse+Extras.h"
#import "FLStringBuilder.h"

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
	
	   return FLReturnAutoreleased([[NSError alloc] initWithDomain:FLFrameworkErrorDomainName 
			code:statusCode
			userInfo:errorInfo]);
	}

	return nil;
}

- (void) logToStringBuilder:(FLStringBuilder*) builder {

	NSDictionary* headers = [self allHeaderFields];
	
	[builder appendLineWithFormat:@"HTTP response: %d (%@)", self.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:self.statusCode]];

	[builder appendLine:@"headers:"];

    [builder appendIndentedBlock:^{
        for(id key in headers) {
            [builder appendLineWithFormat:@"%@: %@", [key description], [[headers objectForKey:key] description]];
        }
    }];
}

@end
