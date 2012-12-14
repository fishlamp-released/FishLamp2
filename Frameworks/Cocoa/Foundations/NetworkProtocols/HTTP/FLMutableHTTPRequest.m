//
//  FLMutableHTTPRequest.m
//  Downloader
//
//  Created by Mike Fullerton on 11/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLMutableHTTPRequest.h"

@interface FLHttpRequest ()
- (void) setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;
- (void) removeHTTPHeaderField:(NSString*) field;
- (id) initWithURL:(NSURL*) url HTTPMethod:(NSString*) HTTPMethod;
@end

@implementation FLMutableHttpRequest

@dynamic HTTPMethod;
@dynamic requestURL;
@dynamic postBodyFilePath;
@dynamic HTTPBody;
@dynamic allHTTPHeaderFields;
@dynamic userAgentHeader;
@dynamic hostHeader;
@dynamic contentLengthHeader;
@dynamic contentTypeHeader;
@dynamic HTTPBodyStream;
@dynamic postRequest;

-(id) initWithURL:(NSURL*) url HTTPMethod:(NSString*) HTTPMethod {
    return [super initWithURL:url HTTPMethod:HTTPMethod];
}

+ (id) httpRequestWithURL:(NSURL*) url HTTPMethod:(NSString*) HTTPMethod {
    return FLAutorelease([[[self class] alloc] initWithURL:url HTTPMethod:HTTPMethod]);
}

+ (id) httpPostRequestWithURL:(NSURL*) url {
    return FLAutorelease([[[self class] alloc] initWithURL:url HTTPMethod:@"POST"]);
}

- (void) removeHTTPHeaderField:(NSString*) headerName {
    [super removeHTTPHeaderField:headerName];
}

- (void) setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [super setValue:value forHTTPHeaderField:field];
}

-(void) setUtf8Content:(NSString*) content {
    FLAssertIsNotNil_v(content, nil);

	[self setContentWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
           typeContentHeader:@"text/xml; charset=utf-8" ];
}

- (void) setFormUrlEncodedContent:(NSString*) content {
    FLAssertIsNotNil_v(content, nil);
    
	[self setContentWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
           typeContentHeader:@"application/x-www-form-urlencoded" ]; 
}

- (void) setContentWithData:(NSData*) content
          typeContentHeader:(NSString*) typeContentHeader {
    FLAssertIsNotNil_v(content, nil);
	FLAssertStringIsNotEmpty_v(typeContentHeader, nil);

    self.HTTPBody = content;
	[self setContentTypeHeader:typeContentHeader];
	[self setContentLengthHeader:[content length]];
}

- (void) setContentWithFilePath:(NSString*) path 
              typeContentHeader:(NSString*) typeContentHeader {
	FLAssertStringIsNotEmpty_v(typeContentHeader, nil);
    FLAssert_v([[NSFileManager defaultManager] fileExistsAtPath:path], @"File at %@ doesn't exist", path);

	[self setContentTypeHeader:typeContentHeader];
    self.postBodyFilePath = path;
}

- (void) setJpegContentWithFilePath:(NSString*) filePath {
	[self setContentWithFilePath:filePath typeContentHeader:@"image/jpeg"];
}

- (void) setJpegContentWithData:(NSData*) imageData {
	FLAssertIsNotNil_v(imageData, nil);
	FLAssert_v(imageData.length > 0, @"Empty data");
	[self setContentWithData:imageData typeContentHeader:@"image/jpeg"];
}


@end
