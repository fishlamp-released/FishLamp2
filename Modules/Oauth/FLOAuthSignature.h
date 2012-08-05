//
//  FLOAuthSignature.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLOAuthApp.h"
#import "FLOAuthEnums.h"
#import "FLHttpConnection.h"

@interface FLOAuthSignature : NSObject {
@private
	NSMutableDictionary* m_parameters;
}

- (id) init;

+ (FLOAuthSignature*) OAuthSignature;

- (void) beginSigningRequest:(FLHttpConnection*) request consumerKey:(NSString*) consumerKey;

- (void) addParameter:(NSString*) parameter value:(NSString*) unencodedURLValue;

- (void) signRequest:(FLHttpConnection*) request withSecret:(NSString*) secret;

- (void) addAuthenticationHeaderToRequest:(FLHttpConnection*) request oauthParametersOnly:(BOOL) oauthParametersOnly;

@end

@interface FLOAuthSignature (Internal)

- (NSString *) buildHMAC_SHA1SignatureForRequest:(FLHttpConnection*) request withSecret:(NSString *)inSecret;

- (NSString*) buildAuthorizationHeader:(BOOL) oauthParametersOnly;

#if DEBUG
- (NSString*) computeBaseURLForRequest:(FLHttpConnection*) request;
#endif
@end


#if DEBUG
extern void FLDebugCompareStrings(NSString* lhs, NSString* rhs);
extern void TestEncoding();
extern void FLDebugCompareHeaders(NSString* lhs, NSString* rhs);
#endif
