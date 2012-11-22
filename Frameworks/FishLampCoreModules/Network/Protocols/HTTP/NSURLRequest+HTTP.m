//
//  NSURLRequest+HTTP.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "NSURLRequest+HTTP.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+URL.h"
#import "FLStringBuilder.h"

@implementation NSURLRequest (HTTP)
static NSString* s_defaultUserAgent = nil;

+ (void) setDefaultUserAgent:(NSString*) userAgent
{
	FLRetainObject_(s_defaultUserAgent, userAgent);
}

+ (NSString*) defaultUserAgent
{
	return s_defaultUserAgent;
}

- (BOOL) hasHeader:(NSString*) header
{
	return [self valueForHTTPHeaderField:header] != nil;
}

- (NSString*) postHeader
{
	return [NSString stringWithFormat:@"%@ HTTP/1.1", self.URL.path];
}

- (void) logToStringBuilder:(FLStringBuilder*) builder {
	
    NSDictionary* headers = [self allHTTPHeaderFields];
	
	[builder appendLine:@"HTTP request:"];
    [builder appendLineWithFormat:@"HTTP Method:%@", self.HTTPMethod];
    [builder appendLineWithFormat:@"URL: %@", [[self.URL absoluteString] urlDecodeString:NSUTF8StringEncoding]];
	[builder appendLine:@"All Headers:"];
	[builder appendIndentedBlock: ^{
        for(id key in headers) {
            [builder appendLineWithFormat:@"%@: %@", [key description], [[headers objectForKey:key] description]];
        }
    }];
	
    [builder appendLine:@"Body:"];
	
	NSData* data = [self HTTPBody];
	NSString* stringData = autorelease_([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
	if(stringData) {
        [builder appendIndentedBlock:^{
            [builder appendLine:stringData];
        }];
    }
    
    [builder appendLine:@"eod"];
		
}

- (BOOL) willPostRequest
{
	return FLStringsAreEqual([self HTTPMethod], @"POST");
}

@end


@implementation NSMutableURLRequest (HTTP)


- (void) setUserAgentHeader:(NSString*) userAgent
{
	FLAssertStringIsNotEmpty_v(userAgent, nil);

	[self setHeader:@"User-Agent" data:userAgent];
}

- (void) setDefaultUserAgentHeader
{
	if(FLStringIsNotEmpty([NSURLRequest defaultUserAgent]))
	{
		[self setUserAgentHeader:s_defaultUserAgent];
	}
}

-(void) setHeader:(NSString*)headerName data:(NSString*)data
{
	[self setValue:data forHTTPHeaderField:headerName];
}

-(void) setUtf8Content:(NSString*) content
{
	[self setContentWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
           typeContentHeader:@"text/xml; charset=utf-8" ];
}

- (void) setFormUrlEncodedContent:(NSString*) content
{
	[self setContentWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
           typeContentHeader:@"application/x-www-form-urlencoded" ]; 
}

-(void) setContentTypeHeader:(NSString*) contentType
{
	[self setHeader:@"Content-Type" data:contentType];
}

-(void) setContentLengthHeader:(unsigned long long) length
{
	NSString* contentLength = [[NSString alloc] initWithFormat:@"%llu", length];
	[self setHeader:@"Content-Length" data:contentLength];
	FLReleaseWithNil_(contentLength);
}

- (void) setContentWithData:(NSData*) content
          typeContentHeader:(NSString*) typeContentHeader
{
	[self setHTTPBody:content];
	[self setContentTypeHeader:typeContentHeader];
	[self setContentLengthHeader:[content length]];
}

- (void) setContentWithInputStream:(NSInputStream*) stream
                       typeContentHeader: (NSString*) typeContentHeader 
						inputSize:(unsigned long long) size
{
	[self setContentTypeHeader:typeContentHeader];
	[self setContentLengthHeader:size];
	[self setHTTPBodyStream:stream];
}

- (void) setContentWithFilePath:(NSString*) path 
              typeContentHeader:(NSString*) typeContentHeader
{
	unsigned long long fileSize = 0;
	NSError* err = 0;
	if([NSFileManager getFileSize:path outSize:&fileSize outError:&err]) {
		FLThrowError_(autorelease_(err));
	}

	NSInputStream* stream = autorelease_([[NSInputStream alloc] initWithFileAtPath:path]);
	[self setContentWithInputStream:stream
        typeContentHeader:typeContentHeader 
		inputSize:fileSize];
}

- (void) setHostHeader:(NSString*) host
{
	FLAssertStringIsNotEmpty_v(host, nil);
	[self setHeader:@"HOST" data:host];
}

- (void) setHTTPMethodToPost
{
	[self setHTTPMethod:@"POST"];
	[self setValue:self.postHeader forHTTPHeaderField:@"POST"];
}

- (void) setImageContentWithFilePath:(NSString*) filePath
{
	FLAssertStringIsNotEmpty_v(filePath, nil);
	[self setContentWithFilePath:filePath typeContentHeader:@"image/jpeg"];
}

- (void) setImageContentWithData:(NSData*) imageData
{
	FLAssertIsNotNil_v(imageData, nil);
	FLAssert_v(imageData.length > 0, @"Empty data");
	[self setContentWithData:imageData typeContentHeader:@"image/jpeg"];
}

- (void) setImageContentWithInputStream:(NSInputStream*) stream   inputSize:(NSUInteger) size
{
	FLAssertIsNotNil_v(stream, nil);
	[self setContentWithInputStream:stream typeContentHeader:@"image/jpeg" inputSize:size];
}

@end
