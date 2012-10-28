//
//	FLBase64Encoding.m
//	FishLamp
//
//	Created By Mike Fullerton on 4/23/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLBase64Encoding.h"
#import "Base64Transcoder.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (Base64Encoding)

- (void)base64Encode:(NSData**) outData
{
	if(self.length == 0)
	{
		if(outData)
		{
			*outData = [[NSData alloc] init]; 
		}
		return;
	}

	char* buffer = nil;
	@try
	{
		size_t encodedSize = EstimateBas64EncodedDataSize(self.length);
		buffer = malloc(encodedSize);
	
		if(Base64EncodeData(self.bytes, self.length, buffer, &encodedSize))
		{
			if(outData)
			{
				*outData = [[NSData alloc] initWithBytes:buffer length:encodedSize];
			}
		}
		else
		{
			FLThrowError_([NSError errorWithDomain:NSCocoaErrorDomain code:NSFormattingError userInfo:nil]);
		}
	}
	@finally
	{
		if(buffer)
		{
			free(buffer);
		}
	}
}

- (void)base64Decode:(NSData**) outData
{
	if(self.length == 0)
	{
		if(outData)
		{
			*outData = [[NSData alloc] init]; 
		}
		return;
	}

	char* buffer = nil;
	
	@try
	{
		size_t decodedSize = EstimateBas64DecodedDataSize(self.length);
		buffer = malloc(decodedSize);
		if(Base64DecodeData(self.bytes, self.length, buffer, &decodedSize))
		{
			if(outData)
			{
				*outData = [[NSData alloc] initWithBytes:buffer length:decodedSize];
			}
		}
		else
		{
			FLThrowError_([NSError errorWithDomain:NSCocoaErrorDomain code:NSFormattingError userInfo:nil]);
		}		
	}
	@finally
	{
		if(buffer)
		{
			free(buffer);
		}
	}
}

- (NSData*) base64Decode
{
	NSData* data = nil;
	[self base64Decode:&data];
	return FLReturnAutoreleased(data);
}

- (NSData*) base64Encode
{
	NSData* data = nil;
	[self base64Encode:&data];
	return FLReturnAutoreleased(data);
}


+ (void)base64DecodeString:(NSString*) str outData:(NSData**) outData
{
	NSData* encodedData = [str dataUsingEncoding: NSASCIIStringEncoding]; // autorealeased
	
	[encodedData base64Decode:outData];
}

- (void) base64EncodeToString:(NSString**) outString
{
	NSData* encoded = nil; 
	
	@try
	{
		[self base64Encode:&encoded];
	
		*outString = [[NSString alloc] initWithBytes:[encoded bytes] 
									length:[encoded length] 
									encoding:NSASCIIStringEncoding];
	}
	@finally
	{
		FLReleaseWithNil(encoded);
	}
}

+ (void) concatAndEncodeSHA256:(NSData*) lhs 
	rhs:(NSData*) rhs 
	outData:(NSData**) outData
{
	NSMutableData* tempData = nil;
	
	@try
	{
		tempData = [[NSMutableData alloc] initWithData:lhs];
		[tempData appendData:rhs];
		
		const char hash[CC_SHA256_DIGEST_LENGTH];
		CC_SHA256((char*) [tempData bytes],
				  (unsigned int) [tempData length], 
				  (unsigned char*) hash);
	
		*outData = [[NSData alloc] initWithBytes:hash length:CC_SHA256_DIGEST_LENGTH];
	}
	@finally
	{
		FLReleaseWithNil(tempData);
	}
}

@end

@implementation NSString (Base64Encoding)

- (void) base64Encode:(NSString**) outString
{
	NSData* unEncodedData = [self dataUsingEncoding: NSASCIIStringEncoding]; // autoreleased
	[unEncodedData base64EncodeToString: outString]; // autoreleased
}

- (void) base64Decode:(NSString**) outString
{
	NSData* decodedData = nil;
	[NSData base64DecodeString:self outData:&decodedData]; //autoreleased
	@try
	{
		*outString = [[NSString alloc] initWithBytes:[decodedData bytes] 
						length:[decodedData length] 
						encoding:NSASCIIStringEncoding];
	}
	@finally
	{
		FLReleaseWithNil(decodedData);
	}
}
 

@end