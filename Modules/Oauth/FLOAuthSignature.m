//
//  FLOAuthSignature.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLOAuthSignature.h"
#import "NSString+URL.h"
#import <CommonCrypto/CommonHMAC.h>
#import "Base64Transcoder.h"
#import "NSString+GUID.h"
#import "FLStringUtilities.h"

@implementation FLOAuthSignature

+ (NSString*) generateNonce
{
	return [NSString guidString];
}

+ (NSString *)generateTimestamp 
{
	return [NSString stringWithFormat:@"%d", (int)[[NSDate date] timeIntervalSince1970]];
}

- (FLOAuthSignature*) init
{
	if((self = [super init]))
	{
		m_parameters = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

+ (FLOAuthSignature*) OAuthSignature
{
	return FLReturnAutoreleased([[FLOAuthSignature alloc] init]);
}

- (void) dealloc
{
	FLRelease(m_parameters);
	FLSuperDealloc();
}

- (void) addParameter:(NSString*) parameter value:(NSString*) value
{
	FLAssertStringIsNotEmpty(parameter);
	FLAssertStringIsNotEmpty(value);

	[m_parameters setObject:value forKey:parameter];
}

NSInteger SortOAuthParameters(NSString* lhs, NSString* rhs, void* context)
{
	FLCAssertStringIsNotEmpty(lhs);
	FLCAssertStringIsNotEmpty(rhs);

	NSComparisonResult result = [lhs compare:rhs];
	
	if(result == NSOrderedSame)
	{
		NSDictionary* parms = (__fl_bridge NSDictionary*) context;
		result = [[parms objectForKey:lhs] compare:[parms objectForKey:rhs]];
	}

	return result;
}

- (NSString*) computeBaseURLForRequest:(FLHttpConnection*) connection
{
	NSArray* parameters = [[m_parameters allKeys] sortedArrayUsingFunction:SortOAuthParameters context:(__fl_bridge void*) m_parameters];

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
	
	NSArray* parameters = [[m_parameters allKeys] sortedArrayUsingFunction:SortOAuthParameters context:(__fl_bridge void*) m_parameters];
	
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
	FLDebugLog(@"OAuth auth header: %@", outString);
#endif
	
	return outString;
}

- (NSString *) buildHMAC_SHA1SignatureForRequest:(FLHttpConnection*) connection 
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
	NSString *base64EncodedResult = FLReturnAutoreleased([[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding]);
	
	return base64EncodedResult;
}



- (void) beginSigningRequest:(FLHttpConnection*) connection 
	consumerKey:(NSString*) consumerKey
{
	[self addParameter:kFLOAuthHeaderConsumerKey value:consumerKey];
	[self addParameter:kFLOAuthHeaderNonce value:[FLOAuthSignature generateNonce]];
	[self addParameter:kFLOAuthHeaderTimestamp value:[FLOAuthSignature generateTimestamp]];
	[self addParameter:kFLOAuthHeaderSignatureMethod value:kFLOAuthSignatureMethodHMAC_SHA1];
	[self addParameter:kFLOAuthHeaderVersion value:FLOAuthVersion];
}

- (void) signRequest:(FLHttpConnection*) connection withSecret:(NSString*) secret
{
	[self addParameter:kFLOAuthHeaderSignature value:[self buildHMAC_SHA1SignatureForRequest:connection withSecret:secret]];
}

- (void) addAuthenticationHeaderToRequest:(FLHttpConnection*) connection  oauthParametersOnly:(BOOL) oauthParametersOnly
{
	NSString* authHeader = [self buildAuthorizationHeader:oauthParametersOnly];
	[connection.httpRequest setHeader:FLOAuthHttpAuthorizationHeader data:authHeader];
}

@end


#if DEBUG

NSDictionary* FLGetHeaders(NSString* header)
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

BOOL FLCompareDicts(NSDictionary* lhsDict, NSDictionary* rhsDict)
{
	BOOL equal = YES;
	for(NSString* key in lhsDict)
	{
		NSString* lhsValue = [lhsDict objectForKey:key];
		NSString* rhsValue = [rhsDict objectForKey:key];
		if(!rhsValue)
		{
			equal = NO;
			FLDebugLog(@"rhs missing %@/%@", key, lhsValue);
		}
		else if(!FLStringsAreEqual(lhsValue, rhsValue))
		{
			equal = NO;
			FLDebugLog(@"value for key %@ are not equal: %@ != %@", key, lhsValue, rhsValue);
		}
		else 
		{
			FLDebugLog(@"found %@=%@ in both headers", key, lhsValue);
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

void FLDebugCompareHeaders(NSString* lhs, NSString* rhs)
{
	NSDictionary* lhsDict = FLGetHeaders(removeOAuth(lhs));
	NSDictionary* rhsDict = FLGetHeaders(removeOAuth(rhs));
	
	BOOL equal = FLCompareDicts(lhsDict, rhsDict);
	if(!FLCompareDicts(lhsDict, lhsDict))
	{
		equal = NO;
	}
	
	if(equal)
	{
		FLDebugLog(@"header:\n%@\n==\n%@", lhs, rhs);
	}
	else
	{
		FLDebugLog(@"header:\n%@\n!=\n%@", lhs, rhs);
	}
}

void FLDebugCompareStrings(NSString* lhs, NSString* rhs)
{
	FLDebugLog(@"lhs:\n%@", lhs);
	FLDebugLog(@"rhs:\n%@", rhs);

	if(lhs.length != rhs.length)
	{
		FLDebugLog(@"lhs length: %d != rhs length: %d", lhs.length, rhs.length);
	}

	NSMutableString* str = [NSMutableString string];
	for(int i = 0; i < (int) MAX(lhs.length, rhs.length); i++)
	{
		if(i >= (int)lhs.length)
		{
			FLDebugLog(@"lhs ran out of chars");
			FLDebugLog(str);
		}
		else if(i >= (int)rhs.length)
		{
			FLDebugLog(@"rhs ran out of chars");
			FLDebugLog(str);
		}
		else if([lhs characterAtIndex:i] == [rhs characterAtIndex:i])
		{
			[str appendFormat:@"%c", [lhs characterAtIndex:i]];
		}
		else
		{
			FLDebugLog(str);
			FLDebugLog(@"%d: %c != %c", i, [lhs characterAtIndex:i], [rhs characterAtIndex:i]); 
			return;
		}
	}
	
	FLDebugLog(@"%@\n==\n%@", lhs, rhs); 

}
void TestEncoding()
{
//	FLOAuthSignature* sig = [FLOAuthSignature OAuthSignature];
//	
//	//\alloc] initWithMethod:@"POST" url:[NSURL URLWithString:@"https://api.twitter.com/oauth/request_token"]];
//	
//	[sig addParameter:kFLOAuthHeaderCallback value:[@"http://localhost:3005/the_dance/process_callback?service_provider_id=11" urlEncodeString:NSUTF8StringEncoding]];
//
//	[sig addParameter:kFLOAuthHeaderConsumerKey value:@"GDdmIQH6jhtmLUypg82g"];
//	[sig addParameter:kFLOAuthHeaderNonce value:@"QP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk"];
//	[sig addParameter:kFLOAuthHeaderTimestamp value:@"1272323042"];
//	[sig addParameter:kFLOAuthHeaderSignatureMethod value:kFLOAuthSignatureMethodHMAC_SHA1];
//	[sig addParameter:kFLOAuthHeaderVersion value:FLOAuthVersion];
//	
//	NSString* baseUrl = [sig computeBaseURL];
//	
//	NSString* refString = @"POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Frequest_token&oauth_callback%3Dhttp%253A%252F%252Flocalhost%253A3005%252Fthe_dance%252Fprocess_callback%253Fservice_provider_id%253D11%26oauth_consumer_key%3DGDdmIQH6jhtmLUypg82g%26oauth_nonce%3DQP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1272323042%26oauth_version%3D1.0";
//	
//	FLDebugCompareStrings(
//		baseUrl, refString);
//	
////	baseUrl = [baseUrl urlEncodeString:NSUTF8StringEncoding];
//	
//	
////	if(FLStringsAreEqual(@"POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Frequest_token&oauth_callback%3Dhttp%253A%252F%252Flocalhost%253A3005%252Fthe_dance%252Fprocess_callback%253Fservice_provider_id%253D11%26oauth_consumer_key%3DGDdmIQH6jhtmLUypg82g%26oauth_nonce%3DQP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1272323042%26oauth_version%3D1.0
////", baseURL))
////{
////
////}
//	
//	NSString* key = [sig buildHMAC_SHA1Signature:[NSString stringWithFormat:@"%@&", @"MCD8BKwGdgPHvAuvgvz4EQpqDAtx89grbuNMRd7Eh98"]];
//
//	FLDebugCompareStrings(key, @"8wUi7m5HFQy76nowoCThusfgB+Q=");
//	
////	FLDebugLog(@"Keys are equal: %d", FLStringsAreEqual(@"8wUi7m5HFQy76nowoCThusfgB+Q=", key));
//
//	FLDebugLog(key);
//
//	[sig addParameter:kFLOAuthHeaderSignature value:key];
//
//	NSString* authHeader = [sig buildAuthorizationHeader];
//	NSString* refAuthHeader = @"OAuth oauth_nonce=\"QP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk\", oauth_callback=\"http%3A%2F%2Flocalhost%3A3005%2Fthe_dance%2Fprocess_callback%3Fservice_provider_id%3D11\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1272323042\", oauth_consumer_key=\"GDdmIQH6jhtmLUypg82g\", oauth_signature=\"8wUi7m5HFQy76nowoCThusfgB%2BQ%3D\", oauth_version=\"1.0\"";
//	
//	FLDebugCompareStrings(authHeader, refAuthHeader);

}
//
//void test2(NSString* consumerKey)
//{
//
//	FLOAuthSignature* sig = [[FLOAuthSignature alloc] initWithMethod:@"POST" url:@"http://api.twitter.com/oauth/request_token"];
//	
////	[sig addParameter:kFLOAuthHeaderCallback value:[@"http://localhost:3005/the_dance/process_callback?service_provider_id=11" urlEncodeString:NSUTF8StringEncoding]];
//
//	[sig addParameter:kFLOAuthHeaderConsumerKey value:consumerKey];
//	[sig addParameter:kFLOAuthHeaderNonce value:@"AA79DF97-AEA9-4DBA-96A6-C9C203E263C0"];
//	[sig addParameter:kFLOAuthHeaderTimestamp value:@"1305849268"];
//	[sig addParameter:kFLOAuthHeaderSignature value:kFLOAuthHeaderSignatureMethod];
//	[sig addParameter:kFLOAuthHeaderVersion value:kFLOAuthHeaderVersion];
//	
//	NSString* baseUrl = [sig computeBaseURL];
//	
////	NSString* refString = @"POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Frequest_token&oauth_callback%3Dhttp%253A%252F%252Flocalhost%253A3005%252Fthe_dance%252Fprocess_callback%253Fservice_provider_id%253D11%26oauth_consumer_key%3DGDdmIQH6jhtmLUypg82g%26oauth_nonce%3DQP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1272323042%26oauth_version%3D1.0";
////	
////	FLDebugCompareStrings(
////		baseUrl, refString);
//	
////	baseUrl = [baseUrl urlEncodeString:NSUTF8StringEncoding];
//		
//	NSString* key = [sig buildHMAC_SHA1Signature:[NSString stringWithFormat:@"%@&", [FLTwitter instance].consumerSecret]];
//
//	FLDebugCompareStrings(key, [@"TV9uaB7Wl4w9uRW4%2BQ6K%2FkEQeYg%3D" urlDecodeString:NSUTF8StringEncoding]);
//	
////	FLDebugLog(@"Keys are equal: %d", FLStringsAreEqual(@"8wUi7m5HFQy76nowoCThusfgB+Q=", key));
//
//	FLDebugLog(key);
//
//	[sig addParameter:kFLOAuthHeaderSignature value:key];
//
//
//	
//	NSString* authHeader = [sig buildAuthorizationHeader];
//	
//	FLDebugLog(authHeader);
//	
////	NSString* refAuthHeader = @"OAuth oauth_nonce=\"QP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk\", oauth_callback=\"http%3A%2F%2Flocalhost%3A3005%2Fthe_dance%2Fprocess_callback%3Fservice_provider_id%3D11\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1272323042\", oauth_consumer_key=\"GDdmIQH6jhtmLUypg82g\", oauth_signature=\"8wUi7m5HFQy76nowoCThusfgB%2BQ%3D\", oauth_version=\"1.0\"";
//	
////	FLDebugCompareStrings(authHeader, refAuthHeader);
//
//
//}

#endif
