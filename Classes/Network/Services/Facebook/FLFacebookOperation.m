//
//  FLFacebookOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookOperation.h"
#import "FLJsonNetworkOperationProtocolHandler.h"
#import "FLStringUtils.h"
#import "NSString+URL.h"
#import "FLFacebookFetchStatusListResponse.h"
#import "FLObjectDescriber.h"
#import "FLJsonParser.h"
#import "FLObjectBuilder.h"

@implementation FLFacebookOperation

@synthesize userId = _userId;
@synthesize object = _object;

+ (id) facebookOperation
{
	return FLReturnAutoreleased([[[self class] alloc] init]);
}	

- (void) dealloc
{
	FLRelease(_userId);
	FLRelease(_object);
	FLSuperDealloc();
}

- (void) didInit
{
	[super didInit];
	self.userId = [FLFacebookMgr instance].session.userId;
	self.serverContext = [FLFacebookMgr instance];
	self.responseHandler = nil; // [FLJsonNetworkOperationProtocolHandler instance];
}

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
    [super runSelf];
    
    if(self.didSucceed) {
    
        NSData* responseData = self.httpResponse.responseData;
    
        FLJsonParser* parser = [FLJsonParser jsonParser];
		NSDictionary* response = [parser parseJsonData:responseData rootObject:nil];
        FLThrowIfError_(parser.error);

        if([response objectForKey:@"error"])
        {
            FLDebugLog(@"Got facebook error: %@", [response description]);
        
            FLThrowErrorCode_v(@"Facebook", 1,
                @"%@ = \"%@\"",
                NSLocalizedString(@"Unexpected Facebook Response", nil),
                [response objectForKey:@"error"]);
        }
        else
        {
            FLObjectBuilder* builder = [[FLObjectBuilder alloc] init];
            [builder buildObjectsFromDictionary:response withRootObject:self.operationOutput];
            FLRelease(builder);
        }
    }
}

- (NSURL*) createURL {
	NSMutableString* url = [FLFacebookMgr buildURL:[FLFacebookMgr instance].encodedToken user:self.userId object:self.object params:nil];
	
	
	if([self willAddParametersToURL]) {
		[self addParametersToURLString:url];
	}
	
	NSURL* URL = [NSURL URLWithString:url];
	FLAssertIsNotNil_v(URL, nil);
	
	return URL;
}


@end

