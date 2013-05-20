//	This file was generated at 5/20/11 4:06 PM by PackMule. DO NOT MODIFY!!
//
//	GtOauthEnums.m
//	Project: FishLamp
//	Schema: GtOauth
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOauthEnums.h"
@implementation GtOauthEnumLookup
GtSynthesizeSingleton(GtOauthEnumLookup);
- (id) init {
	if((self = [super init])) {
		m_strings = [[NSDictionary alloc] initWithObjectsAndKeys:
			[NSNumber numberWithInt:GtOAuthHeaderConsumerKey], kGtOAuthHeaderConsumerKey, 
			[NSNumber numberWithInt:GtOAuthHeaderToken], kGtOAuthHeaderToken, 
			[NSNumber numberWithInt:GtOAuthHeaderSignatureMethod], kGtOAuthHeaderSignatureMethod, 
			[NSNumber numberWithInt:GtOAuthHeaderTimestamp], kGtOAuthHeaderTimestamp, 
			[NSNumber numberWithInt:GtOAuthHeaderNonce], kGtOAuthHeaderNonce, 
			[NSNumber numberWithInt:GtOAuthHeaderSignature], kGtOAuthHeaderSignature, 
			[NSNumber numberWithInt:GtOAuthHeaderCallback], kGtOAuthHeaderCallback, 
			[NSNumber numberWithInt:GtOAuthHeaderVersion], kGtOAuthHeaderVersion, 
			[NSNumber numberWithInt:GtOAuthSignatureMethodHMAC_SHA1], kGtOAuthSignatureMethodHMAC_SHA1, 
			[NSNumber numberWithInt:GtOAuthSignatureMethodRSA_SHA1], kGtOAuthSignatureMethodRSA_SHA1, 
			[NSNumber numberWithInt:GtOAuthSignatureMethodPlaintext], kGtOAuthSignatureMethodPlaintext, 
		 nil];
	}
	return self;
}

- (NSInteger) lookupString:(NSString*) inString {
	NSNumber* num = [m_strings objectForKey:inString];
	if(!num) { return NSNotFound; } 
	return [num intValue];
}

- (NSString*) stringFromOAuthHeader:(GtOAuthHeader) inEnum {
	switch(inEnum) {
		case GtOAuthHeaderConsumerKey: return kGtOAuthHeaderConsumerKey;
		case GtOAuthHeaderToken: return kGtOAuthHeaderToken;
		case GtOAuthHeaderSignatureMethod: return kGtOAuthHeaderSignatureMethod;
		case GtOAuthHeaderTimestamp: return kGtOAuthHeaderTimestamp;
		case GtOAuthHeaderNonce: return kGtOAuthHeaderNonce;
		case GtOAuthHeaderSignature: return kGtOAuthHeaderSignature;
		case GtOAuthHeaderCallback: return kGtOAuthHeaderCallback;
		case GtOAuthHeaderVersion: return kGtOAuthHeaderVersion;
	}
	return nil;
}

- (GtOAuthHeader) oAuthHeaderFromString:(NSString*) inString {
	return (GtOAuthHeader) [self lookupString:inString];
}


- (NSString*) stringFromOAuthSignatureMethod:(GtOAuthSignatureMethod) inEnum {
	switch(inEnum) {
		case GtOAuthSignatureMethodHMAC_SHA1: return kGtOAuthSignatureMethodHMAC_SHA1;
		case GtOAuthSignatureMethodRSA_SHA1: return kGtOAuthSignatureMethodRSA_SHA1;
		case GtOAuthSignatureMethodPlaintext: return kGtOAuthSignatureMethodPlaintext;
	}
	return nil;
}

- (GtOAuthSignatureMethod) oAuthSignatureMethodFromString:(NSString*) inString {
	return (GtOAuthSignatureMethod) [self lookupString:inString];
}

@end
