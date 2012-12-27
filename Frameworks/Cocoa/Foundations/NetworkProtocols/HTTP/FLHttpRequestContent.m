//
//  FLHttpRequestContent.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestContent.h"

@interface FLHttpRequestContent ()
@end

@implementation FLHttpRequestContent

@synthesize httpHeaders = _httpHeaders;
@synthesize postBodyFilePath = _postBodyFilePath;
@synthesize bodyData = _postData;
@synthesize bodyStream = _bodyStream;

- (id) init {
    self = [super init];
    if(self) {
        _httpHeaders = [[FLHttpRequestHeaders alloc] init];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_httpHeaders release];
    [_postData release];
    [_bodyStream release];
    [_postBodyFilePath release];
    [super dealloc];
}
#endif

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

    self.bodyData = content;
	[self.httpHeaders setContentTypeHeader:typeContentHeader];
	[self.httpHeaders setContentLengthHeader:[content length]];
}

- (void) setContentWithFilePath:(NSString*) path 
              typeContentHeader:(NSString*) typeContentHeader {
	FLAssertStringIsNotEmpty_v(typeContentHeader, nil);
    FLAssert_v([[NSFileManager defaultManager] fileExistsAtPath:path], @"File at %@ doesn't exist", path);

	[self.httpHeaders setContentTypeHeader:typeContentHeader];
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

- (void) setBodyData:(NSData*) data {
    self.httpHeaders.postLength = 0;
    FLReleaseWithNil(_postBodyFilePath);
    FLSetObjectWithRetain(_postData, data);
    if (_postData) {
        self.httpHeaders.postLength = _postData.length;
        self.httpHeaders.httpMethod = @"POST";
	}
}

- (void) setPostBodyFilePath:(NSString*) path {
    self.httpHeaders.postLength = 0;
    FLReleaseWithNil(_postData);
    
    FLSetObjectWithRetain(_postBodyFilePath, path);
    if(FLStringIsNotEmpty(_postBodyFilePath)) {
        NSError* err = nil;
            self.httpHeaders.postLength = [[[NSFileManager defaultManager] attributesOfItemAtPath:self.postBodyFilePath error:&err] fileSize];
        
        if(err) {
           FLThrowError(FLAutorelease(err));
        }
        self.httpHeaders.httpMethod = @"POST";
	}
}

- (NSInputStream*) bodyStream {
    if(!_bodyStream) {
        if(FLStringIsNotEmpty(self.postBodyFilePath)) {
            _bodyStream = [[NSInputStream alloc] initWithFileAtPath:self.postBodyFilePath];
        }
    }
    return _bodyStream;
}



@end
