//
//  GtOAuthSignature.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtOAuthApp.h"
#import "GtOAuthEnums.h"
#import "GtHttpConnection.h"

@interface GtOAuthSignature : NSObject {
@private
	NSMutableDictionary* m_parameters;
}

- (id) init;

+ (GtOAuthSignature*) OAuthSignature;

- (void) beginSigningRequest:(GtHttpConnection*) request consumerKey:(NSString*) consumerKey;

- (void) addParameter:(NSString*) parameter value:(NSString*) unencodedURLValue;

- (void) signRequest:(GtHttpConnection*) request withSecret:(NSString*) secret;

- (void) addAuthenticationHeaderToRequest:(GtHttpConnection*) request oauthParametersOnly:(BOOL) oauthParametersOnly;

@end

@interface GtOAuthSignature (Internal)

- (NSString *) buildHMAC_SHA1SignatureForRequest:(GtHttpConnection*) request withSecret:(NSString *)inSecret;

- (NSString*) buildAuthorizationHeader:(BOOL) oauthParametersOnly;

#if DEBUG
- (NSString*) computeBaseURLForRequest:(GtHttpConnection*) request;
#endif
@end


#if DEBUG
extern void GtDebugCompareStrings(NSString* lhs, NSString* rhs);
extern void TestEncoding();
extern void GtDebugCompareHeaders(NSString* lhs, NSString* rhs);
#endif
