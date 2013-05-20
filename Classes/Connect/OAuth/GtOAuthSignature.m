//
//  GtOAuthSignature.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOAuthSignature.h"
#import "NSString+URL.h"
#import <CommonCrypto/CommonHMAC.h>
#import "Base64Transcoder.h"
#import "NSString+GUID.h"

@implementation GtOAuthSignature

+ (NSString*) generateNonce
{
	return [NSString guidString];
}

+ (NSString *)generateTimestamp 
{
	return [NSString stringWithFormat:@"%d", (int)[[NSDate date] timeIntervalSince1970]];
}

- (GtOAuthSignature*) init
{
	if((self = [super init]))
	{
		m_parameters = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

+ (GtOAuthSignature*) OAuthSignature
{
	return GtReturnAutoreleased([[GtOAuthSignature alloc] init]);
}

- (void) dealloc
{
	GtRelease(m_parameters);
	GtSuperDealloc();
}

- (void) addParameter:(NSString*) parameter value:(NSString*) value
{
	GtAssertIsValidString(parameter);
	GtAssertIsValidString(value);

	[m_parameters setObject:value forKey:parameter];
}

NSInteger SortOAuthParameters(NSString* lhs, NSString* rhs, void* context)
{
	GtAssertIsValidString(lhs);
	GtAssertIsValidString(rhs);

	NSComparisonResult result = [lhs compare:rhs];
	
	if(result == NSOrderedSame)
	{
		NSDictionary* parms = (NSDictionary*) context;
		result = [[parms objectForKey:lhs] compare:[parms objectForKey:rhs]];
	}

	return result;
}

- (NSString*) computeBaseURLForRequest:(GtHttpConnection*) connection
{
	NSArray* parameters = [[m_parameters allKeys] sortedArrayUsingFunction:SortOAuthParameters context:m_parameters];

	NSMutableString* outString = [NSMutableString string];
	for(NSString* parm in parameters)
	{
		NSString* value = [m_parameters objectForKey:parm];
	
		value = [value urlEncodeString:NSUTF8StringEncoding];

		if(outString.length)
		{	
			[outString appendFormat:@"&%@=%@", parm, value];
		}
		else
		{
			[outString appendFormat:@"%@=%@", parm, value];
		}
	}
	
	return [NSString stringWithFormat:@"%@&%@&%@", 
			connection.httpRequest.requestMethod, 
			[connection.httpRequest.requestUrl.absoluteString urlEncodeString:NSUTF8StringEncoding],
			[outString urlEncodeString:NSUTF8StringEncoding]];
}

- (NSString*) buildAuthorizationHeader:(BOOL) oauthParametersOnly
{
	NSMutableString* outString = [NSMutableString stringWithFormat:@"OAuth"];
	
	NSArray* parameters = [[m_parameters allKeys] sortedArrayUsingFunction:SortOAuthParameters context:m_parameters];
	
	BOOL first = YES;
	for(NSString* parm in parameters)
	{
		if(!oauthParametersOnly || [parm rangeOfString:@"oauth"].length > 0)
		{
			NSString* value = [m_parameters objectForKey:parm];
		
			value = [value urlEncodeString:NSUTF8StringEncoding];
		
			if(first)
			{	
				first = NO;
				[outString appendFormat:@" %@=\"%@\"", parm, value];
			}
			else
			{
				[outString appendFormat:@", %@=\"%@\"", parm, value];
			}
		}
	}

#if LOG
	GtLog(@"OAuth auth header: %@", outString);
#endif
	
	return outString;
}

- (NSString *) buildHMAC_SHA1SignatureForRequest:(GtHttpConnection*) connection 
	withSecret:(NSString *)inSecret
{
	NSString* inText = [self computeBaseURLForRequest:connection];

	NSData *secretData = [inSecret dataUsingEncoding:NSUTF8StringEncoding];
	NSData *textData = [inText dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];

	CCHmacContext hmacContext;
	bzero(&hmacContext, sizeof(CCHmacContext));
    CCHmacInit(&hmacContext, kCCHmacAlgSHA1, secretData.bytes, secretData.length);
    CCHmacUpdate(&hmacContext, textData.bytes, textData.length);
    CCHmacFinal(&hmacContext, result);
	
	//Base64 Encoding
	char base64Result[32];
	size_t theResultLength = 32;
	Base64EncodeData((const char*) result, 
		20, 
		base64Result, 
		&theResultLength);
		
	NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
	NSString *base64EncodedResult = GtReturnAutoreleased([[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding]);
	
	return base64EncodedResult;
}



- (void) beginSigningRequest:(GtHttpConnection*) connection 
	consumerKey:(NSString*) consumerKey
{
	[self addParameter:kGtOAuthHeaderConsumerKey value:consumerKey];
	[self addParameter:kGtOAuthHeaderNonce value:[GtOAuthSignature generateNonce]];
	[self addParameter:kGtOAuthHeaderTimestamp value:[GtOAuthSignature generateTimestamp]];
	[self addParameter:kGtOAuthHeaderSignatureMethod value:kGtOAuthSignatureMethodHMAC_SHA1];
	[self addParameter:kGtOAuthHeaderVersion value:GtOAuthVersion];
}

- (void) signRequest:(GtHttpConnection*) connection withSecret:(NSString*) secret
{
	[self addParameter:kGtOAuthHeaderSignature value:[self buildHMAC_SHA1SignatureForRequest:connection withSecret:secret]];
}

- (void) addAuthenticationHeaderToRequest:(GtHttpConnection*) connection  oauthParametersOnly:(BOOL) oauthParametersOnly
{
	NSString* authHeader = [self buildAuthorizationHeader:oauthParametersOnly];
	[connection.httpRequest setHeader:GtOAuthHttpAuthorizationHeader data:authHeader];
}

@end


#if DEBUG

NSDictionary* GtGetHeaders(NSString* header)
{	
	NSMutableDictionary* dict = [NSMutableDictionary dictionary];
	NSArray* list = [header componentsSeparatedByString:@","];
	for(NSString* item in list)
	{
		NSArray* pair = [item componentsSeparatedByString:@"="];
		if(pair.count == 2)
		{
			[dict setObject:[[pair objectAtIndex:1] trimmedString] forKey:[[pair objectAtIndex:0] trimmedString] ];
		}
	}
	
	return dict;
}

BOOL GtCompareDicts(NSDictionary* lhsDict, NSDictionary* rhsDict)
{
	BOOL equal = YES;
	for(NSString* key in lhsDict)
	{
		NSString* lhsValue = [lhsDict objectForKey:key];
		NSString* rhsValue = [rhsDict objectForKey:key];
		if(!rhsValue)
		{
			equal = NO;
			GtLog(@"rhs missing %@/%@", key, lhsValue);
		}
		else if(!GtStringsAreEqual(lhsValue, rhsValue))
		{
			equal = NO;
			GtLog(@"value for key %@ are not equal: %@ != %@", key, lhsValue, rhsValue);
		}
		else 
		{
			GtLog(@"found %@=%@ in both headers", key, lhsValue);
		}
	}
	
	return equal;
}

NSString* removeOAuth(NSString* str)
{
	if([str hasPrefix:@"OAuth "])
	{
		return [str substringFromIndex:@"OAuth ".length];
	}
	
	return str;
}

/*
void GtDebugCompareHeaders(NSString* lhs, NSString* rhs)
{
	NSDictionary* lhsDict = GtGetHeaders(removeOAuth(lhs));
	NSDictionary* rhsDict = GtGetHeaders(removeOAuth(rhs));
	
	BOOL equal = GtCompareDicts(lhsDict, rhsDict);
	if(!GtCompareDicts(lhsDict, lhsDict))
	{
		equal = NO;
	}
	
	if(equal)
	{
		GtLog(@"header:\n%@\n==\n%@", lhs, rhs);
	}
	else
	{
		GtLog(@"header:\n%@\n!=\n%@", lhs, rhs);
	}
}

void GtDebugCompareStrings(NSString* lhs, NSString* rhs)
{
	GtLog(@"lhs:\n%@", lhs);
	GtLog(@"rhs:\n%@", rhs);

	if(lhs.length != rhs.length)
	{
		GtLog(@"lhs length: %d != rhs length: %d", lhs.length, rhs.length);
	}

	NSMutableString* str = [NSMutableString string];
	for(int i = 0; i < (int) MAX(lhs.length, rhs.length); i++)
	{
		if(i >= (int)lhs.length)
		{
			GtLog(@"lhs ran out of chars");
			GtLog(str);
		}
		else if(i >= (int)rhs.length)
		{
			GtLog(@"rhs ran out of chars");
			GtLog(str);
		}
		else if([lhs characterAtIndex:i] == [rhs characterAtIndex:i])
		{
			[str appendFormat:@"%c", [lhs characterAtIndex:i]];
		}
		else
		{
			GtLog(str);
			GtLog(@"%d: %c != %c", i, [lhs characterAtIndex:i], [rhs characterAtIndex:i]); 
			return;
		}
	}
	
	GtLog(@"%@\n==\n%@", lhs, rhs); 

}
*/

void TestEncoding()
{
//	GtOAuthSignature* sig = [GtOAuthSignature OAuthSignature];
//	
//	//\alloc] initWithMethod:@"POST" url:[NSURL URLWithString:@"https://api.twitter.com/oauth/request_token"]];
//	
//	[sig addParameter:kGtOAuthHeaderCallback value:[@"http://localhost:3005/the_dance/process_callback?service_provider_id=11" urlEncodeString:NSUTF8StringEncoding]];
//
//	[sig addParameter:kGtOAuthHeaderConsumerKey value:@"GDdmIQH6jhtmLUypg82g"];
//	[sig addParameter:kGtOAuthHeaderNonce value:@"QP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk"];
//	[sig addParameter:kGtOAuthHeaderTimestamp value:@"1272323042"];
//	[sig addParameter:kGtOAuthHeaderSignatureMethod value:kGtOAuthSignatureMethodHMAC_SHA1];
//	[sig addParameter:kGtOAuthHeaderVersion value:GtOAuthVersion];
//	
//	NSString* baseUrl = [sig computeBaseURL];
//	
//	NSString* refString = @"POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Frequest_token&oauth_callback%3Dhttp%253A%252F%252Flocalhost%253A3005%252Fthe_dance%252Fprocess_callback%253Fservice_provider_id%253D11%26oauth_consumer_key%3DGDdmIQH6jhtmLUypg82g%26oauth_nonce%3DQP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1272323042%26oauth_version%3D1.0";
//	
//	GtDebugCompareStrings(
//		baseUrl, refString);
//	
////	baseUrl = [baseUrl urlEncodeString:NSUTF8StringEncoding];
//	
//	
////	if(GtStringsAreEqual(@"POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Frequest_token&oauth_callback%3Dhttp%253A%252F%252Flocalhost%253A3005%252Fthe_dance%252Fprocess_callback%253Fservice_provider_id%253D11%26oauth_consumer_key%3DGDdmIQH6jhtmLUypg82g%26oauth_nonce%3DQP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1272323042%26oauth_version%3D1.0
////", baseURL))
////{
////
////}
//	
//	NSString* key = [sig buildHMAC_SHA1Signature:[NSString stringWithFormat:@"%@&", @"MCD8BKwGdgPHvAuvgvz4EQpqDAtx89grbuNMRd7Eh98"]];
//
//	GtDebugCompareStrings(key, @"8wUi7m5HFQy76nowoCThusfgB+Q=");
//	
////	GtLog(@"Keys are equal: %d", GtStringsAreEqual(@"8wUi7m5HFQy76nowoCThusfgB+Q=", key));
//
//	GtLog(key);
//
//	[sig addParameter:kGtOAuthHeaderSignature value:key];
//
//	NSString* authHeader = [sig buildAuthorizationHeader];
//	NSString* refAuthHeader = @"OAuth oauth_nonce=\"QP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk\", oauth_callback=\"http%3A%2F%2Flocalhost%3A3005%2Fthe_dance%2Fprocess_callback%3Fservice_provider_id%3D11\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1272323042\", oauth_consumer_key=\"GDdmIQH6jhtmLUypg82g\", oauth_signature=\"8wUi7m5HFQy76nowoCThusfgB%2BQ%3D\", oauth_version=\"1.0\"";
//	
//	GtDebugCompareStrings(authHeader, refAuthHeader);

}
//
//void test2(NSString* consumerKey)
//{
//
//	GtOAuthSignature* sig = [[GtOAuthSignature alloc] initWithMethod:@"POST" url:@"http://api.twitter.com/oauth/request_token"];
//	
////	[sig addParameter:kGtOAuthHeaderCallback value:[@"http://localhost:3005/the_dance/process_callback?service_provider_id=11" urlEncodeString:NSUTF8StringEncoding]];
//
//	[sig addParameter:kGtOAuthHeaderConsumerKey value:consumerKey];
//	[sig addParameter:kGtOAuthHeaderNonce value:@"AA79DF97-AEA9-4DBA-96A6-C9C203E263C0"];
//	[sig addParameter:kGtOAuthHeaderTimestamp value:@"1305849268"];
//	[sig addParameter:kGtOAuthHeaderSignature value:kGtOAuthHeaderSignatureMethod];
//	[sig addParameter:kGtOAuthHeaderVersion value:kGtOAuthHeaderVersion];
//	
//	NSString* baseUrl = [sig computeBaseURL];
//	
////	NSString* refString = @"POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Frequest_token&oauth_callback%3Dhttp%253A%252F%252Flocalhost%253A3005%252Fthe_dance%252Fprocess_callback%253Fservice_provider_id%253D11%26oauth_consumer_key%3DGDdmIQH6jhtmLUypg82g%26oauth_nonce%3DQP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1272323042%26oauth_version%3D1.0";
////	
////	GtDebugCompareStrings(
////		baseUrl, refString);
//	
////	baseUrl = [baseUrl urlEncodeString:NSUTF8StringEncoding];
//		
//	NSString* key = [sig buildHMAC_SHA1Signature:[NSString stringWithFormat:@"%@&", [GtTwitter instance].consumerSecret]];
//
//	GtDebugCompareStrings(key, [@"TV9uaB7Wl4w9uRW4%2BQ6K%2FkEQeYg%3D" urlDecodeString:NSUTF8StringEncoding]);
//	
////	GtLog(@"Keys are equal: %d", GtStringsAreEqual(@"8wUi7m5HFQy76nowoCThusfgB+Q=", key));
//
//	GtLog(key);
//
//	[sig addParameter:kGtOAuthHeaderSignature value:key];
//
//
//	
//	NSString* authHeader = [sig buildAuthorizationHeader];
//	
//	GtLog(authHeader);
//	
////	NSString* refAuthHeader = @"OAuth oauth_nonce=\"QP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk\", oauth_callback=\"http%3A%2F%2Flocalhost%3A3005%2Fthe_dance%2Fprocess_callback%3Fservice_provider_id%3D11\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1272323042\", oauth_consumer_key=\"GDdmIQH6jhtmLUypg82g\", oauth_signature=\"8wUi7m5HFQy76nowoCThusfgB%2BQ%3D\", oauth_version=\"1.0\"";
//	
////	GtDebugCompareStrings(authHeader, refAuthHeader);
//
//
//}

#endif
