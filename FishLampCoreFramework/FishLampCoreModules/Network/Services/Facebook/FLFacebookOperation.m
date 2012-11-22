//
//  FLFacebookOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLStringUtils.h"
#import "NSString+URL.h"
#import "FLObjectDescriber.h"
#import "FLJsonParser.h"
#import "FLObjectBuilder.h"
#import "FLFacebookMgr.h"
#import "FLFacebookOperation.h"

@implementation FLFacebookOperation

synthesize_(object)


#if FL_MRC
- (void) dealloc {

    [_object release];
    [super dealloc];
}
#endif



- (BOOL) willAddParametersToURL {
	return YES;
}

- (void) addParametersToURLString:(NSMutableString*) url {
	if(self.input) {
		
        FLObjectDescriber* describer = [[self.input class] sharedObjectDescriber];
	
		for(NSString* propertyName in describer.propertyDescribers) {
			id obj = [self.input valueForKey:propertyName];
			if(obj) {
				FLAssert_v([obj isKindOfClass:[NSString class]], @"not a string"); 
				if(FLStringIsNotEmpty(obj)) {
					[url appendAndEncodeURLParameter:obj name:propertyName seperator:@"&"];
				}
			}
		}
	}
}


- (void) runSelf {
    FLFacebookMgr* facebook = [FLFacebookMgr serviceFromContext:self.context];

    NSString* userID = facebook.facebookNetworkSession.userId;

	NSMutableString* url = [FLFacebookMgr buildURL:facebook.encodedToken user:userID object:self.object params:nil];
	
	if([self willAddParametersToURL]) {
		[self addParametersToURLString:url];
	}
	
	NSURL* URL = [NSURL URLWithString:url];
	FLAssertIsNotNil_v(URL, nil);
    
    self.URL = URL;

    [super runSelf];
    
    if(!self.error) {
    
        NSData* responseData = self.httpResponse.responseData;
    
        FLJsonParser* parser = [FLJsonParser jsonParser];
		NSDictionary* response = [parser parseJsonData:responseData rootObject:nil];
        FLThrowError_(parser.error);

        if([response objectForKey:@"error"])
        {
            FLDebugLog(@"Got facebookService error: %@", [response description]);
        
            FLThrowErrorCode_v(@"Facebook", 1,
                @"%@ = \"%@\"",
                NSLocalizedString(@"Unexpected Facebook Response", nil),
                [response objectForKey:@"error"]);
        }
        else
        {
            FLObjectBuilder* builder = [[FLObjectBuilder alloc] init];
            [builder buildObjectsFromDictionary:response withRootObject:self.operationOutput];
            release_(builder);
        }
    }
}

@end

