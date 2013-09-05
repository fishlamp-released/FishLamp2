//
//  FLFacebookHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStringUtils.h"
#import "NSString+URL.h"
#import "FLObjectDescriber.h"
#import "FLJsonParser.h"
#import "FLObjectBuilder.h"
#import "FLFacebookService.h"
#import "FLFacebookHttpRequest.h"


@implementation FLFacebookHttpRequest

@synthesize object = _object;
@synthesize outputObject = _outputObject;
@synthesize inputObject = _inputObject;

#if FL_MRC
- (void) dealloc {
    [_inputObject release];
    [_outputObject release];
    [_object release];
    [super dealloc];
}
#endif

- (BOOL) willAddParametersToURL {
	return YES;
}

- (void) addParametersToURLString:(NSMutableString*) url {
	if(self.inputObject) {
		
        FLObjectDescriber* describer = [[self.inputObject class] objectDescriber];
	
		for(NSString* propertyName in describer.properties) {
			id obj = [self.inputObject valueForKey:propertyName];
			if(obj) {
				FLAssertWithComment([obj isKindOfClass:[NSString class]], @"not a string"); 
				if(FLStringIsNotEmpty(obj)) {
					[url appendAndEncodeURLParameter:obj name:propertyName seperator:@"&"];
				}
			}
		}
	}
}

- (NSDictionary*) responseParsedIntoDictionary:(FLHttpResponse*) httpResponse {
    
    NSData* responseData = [httpResponse responseData];

// look for error
    NSDictionary* response = [[FLJsonParser jsonParser] parseData:responseData];
    
//    rootObject:nil withDecoder:self.dataDecoder];
//    FLThrowIfError(parser.error);

    if([response objectForKey:@"error"]) {
        FLDebugLog(@"Got facebookService error: %@", [response description]);
    
        FLThrowErrorCodeWithComment(@"Facebook", 1,
            @"%@ = \"%@\"",
            NSLocalizedString(@"Unexpected Facebook Response", nil),
            [response objectForKey:@"error"]);
    }
    
    return response;
}

- (void) willSendHttpRequest {

}


- (FLResult) resultFromHttpResponse:(FLHttpResponse*) response {

    return response;
}

//
//- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
//    FLFacebookService* facebook = self.facebookService;
//
//    NSString* userID = facebook.facebookNetworkSession.userId;
//
//	NSMutableString* url = [self buildURL:facebook.encodedToken user:userID object:self.object params:nil];
//	
//	if([self willAddParametersToURL]) {
//		[self addParametersToURLString:url];
//	}
//	
//	NSURL* URL = [NSURL URLWithString:url];
//	FLAssertIsNotNilWithComment(URL, nil);
//    
//    FLHttpRequest* httpRequest = [FLHttpRequest httpPostRequestWithURL:URL];
//
//    FLHttpResponse* httpResponse = [self sendHttpRequest:httpRequest];
//    
//    NSDictionary* responseDictionary = [self responseParsedIntoDictionary:httpResponse];
//   
//    if(!self.outputObject) {
//        return responseDictionary;
//    }
//   
//    FLObjectBuilder* builder = [FLObjectBuilder objectBuilder];
//    [builder buildObjectsFromDictionary:responseDictionary withRootObject:self.outputObject];
//    
//    return self.outputObject;
//}

- (FLFacebookError*) errorFromURLParams:(NSDictionary*) params
{
	if([params valueForKey:@"error"])
	{
		FLFacebookError* error = [FLFacebookError facebookError];
		error.error = [params valueForKey:@"error"];
		error.error_reason = [params valueForKey:@"error_reason"];
		error.error_description = [params valueForKey:@"error_description"];
		return error;
	}

	return nil;
}

- (FLFacebookNetworkSession*) sessionFromURLParams:(NSDictionary*) params {
	NSString *accessToken = [params valueForKey:@"access_token"];
	if(FLStringIsNotEmpty(accessToken))
	{
		FLFacebookNetworkSession* facebookNetworkSession = [FLFacebookNetworkSession facebookNetworkSession];
		facebookNetworkSession.access_token = accessToken;
		facebookNetworkSession.expiration_date = [NSDate distantFuture];
		
	// We have an access token, so parse the expiration date.
		NSString *expTime = [params valueForKey:@"expires_in"];
		if(FLStringIsNotEmpty(expTime))
		{
			int expVal = [expTime intValue];
			if (expVal != 0) 
			{
				facebookNetworkSession.expiration_date = [NSDate dateWithTimeIntervalSinceNow:expVal];
			}
		}
	
		return facebookNetworkSession;
	}
	
	return nil;
}


- (NSMutableString*) buildURL:(NSString*) authenticationToken
	user:(NSString*) user
	object:(NSString*) object
	params:(NSString*) firstParameter, ...
{
	NSMutableString* url = FLStringIsEmpty(object) ? 
		[NSMutableString stringWithFormat: @"https://graph.facebook.com/%@?access_token=%@", user, authenticationToken] :
		[NSMutableString stringWithFormat: @"https://graph.facebook.com/%@/%@?access_token=%@", user, object, authenticationToken];

	if(FLStringIsNotEmpty(firstParameter))
	{
		va_list valist;
		va_start(valist, firstParameter);   
		NSString* key = firstParameter;
		id obj = nil;
		while ((obj = va_arg(valist, id)))
		{ 
			if(key)
			{
				NSString* value = (NSString*) obj;
				[url appendFormat:@"&%@=%@", key, [value urlEncodeString:NSUTF8StringEncoding]];
				key = nil;
			}
			else
			{
				key = (NSString*) obj;
			}
		}
		va_end(valist);
	}
	return url;
}


- (NSDictionary*)parseURLParams:(NSString *)query {
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	NSMutableDictionary *params = FLAutorelease([[NSMutableDictionary alloc] init]);
	
	for (NSString *pair in pairs) 
	{
		NSArray *kv = [pair componentsSeparatedByString:@"="];
		if(kv.count == 2)
		{
			NSString *val = [[kv objectAtIndex:1] urlDecodeString:NSUTF8StringEncoding];
			[params setObject:val forKey:[kv objectAtIndex:0]];
		}
	}
	return params;
}

- (NSString*)serializeURL:(NSString *)baseUrl
				   params:(NSDictionary *)params
			   httpMethod:(NSString *)httpMethod 
{
	NSURL* parsedURL = [NSURL URLWithString:baseUrl];

	NSString* queryPrefix = parsedURL.query ? @"&" : @"?";

	NSMutableArray* pairs = [NSMutableArray array];
	
	for (NSString* key in [params keyEnumerator]) 
	{
#if IOS    
		if (	([[params valueForKey:key] isKindOfClass:[SDKImage class]])
				||([[params valueForKey:key] isKindOfClass:[NSData class]])) 
		{
			if ([httpMethod isEqualToString:@"GET"]) 
			{
				FLDebugLog(@"can not use GET to upload a file");
			}
		
			continue;
		}
#endif

		NSString* escaped_value = FLAutorelease(bridge_transfer_(NSString*,
                                        CFURLCreateStringByAddingPercentEscapes(
                                            NULL, /* allocator */
                                            bridge_(void*,[params objectForKey:key]),
                                            NULL, /* charactersToLeaveUnescaped */
                                            bridge_(void*,@"!*'();:@&=+$,/?%#[]"),
                                            kCFStringEncodingUTF8)));

		[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
	}
  
	NSString* query = [pairs componentsJoinedByString:@"&"];

	return [NSString stringWithFormat:@"%@%@%@", baseUrl, queryPrefix, query];
}

// from facebook demo app
- (NSString *)serializeURL:(NSString *)baseUrl
				   params:(NSDictionary *)params 
{
  return [self serializeURL:baseUrl params:params httpMethod:@"GET"];
}




@end

