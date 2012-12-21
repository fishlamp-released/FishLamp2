//
//  FLHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHttpRequest.h"
#import "FLAppInfo.h"
#import "FLMutableHTTPRequest.h"

#if IOS
#import <UIKit/UIKit.h>
#endif


@interface FLHttpRequest ()
@property (readwrite, assign, nonatomic) unsigned long long postLength;
@property (readwrite, strong, nonatomic) NSURL* requestURL;
@property (readwrite, strong, nonatomic) NSString* HTTPMethod;
@property (readwrite, strong, nonatomic) NSDictionary* allHTTPHeaderFields;
@property (readwrite, strong, nonatomic) NSString* userAgentHeader;
@property (readwrite, strong, nonatomic) NSData* HTTPBody;
@property (readwrite, strong, nonatomic) NSInputStream* HTTPBodyStream;
@property (readwrite, strong, nonatomic) NSString* postBodyFilePath;
@property (readwrite, assign, nonatomic, getter=isPostRequest) BOOL postRequest;
@property (readwrite, strong, nonatomic) NSString* hostHeader;
@property (readwrite, assign, nonatomic) unsigned long long contentLengthHeader;
@property (readwrite, strong, nonatomic) NSString* contentTypeHeader;
@end

@implementation FLHttpRequest

void GetSystemVersion( int* major, int* minor, int* bugfix )
{
	// sensible default
	static int mMajor = 10;
	static int mMinor = 8;
	static int mBugfix = 0;

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSString* versionString = [[NSDictionary dictionaryWithContentsOfFile:@"/System/Library/CoreServices/SystemVersion.plist"] objectForKey:@"ProductVersion"];
		NSArray* versions = [versionString componentsSeparatedByString:@"."];
		check( versions.count >= 2 );
		if ( versions.count >= 1 ) {
			mMajor = [[versions objectAtIndex:0] integerValue];
		}
		if ( versions.count >= 2 ) {
			mMinor = [[versions objectAtIndex:1] integerValue];
		}
		if ( versions.count >= 3 ) {
			mBugfix = [[versions objectAtIndex:2] integerValue];
		}
	});

	*major = mMajor;
	*minor = mMinor;
	*bugfix = mBugfix;
}

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import "FLAppInfo.h"

NSString* FLMachineModel()
{
    size_t len = 0;
    sysctlbyname("hw.model", NULL, &len, NULL, 0);

    if (len)
    {
        char *model = malloc(len*sizeof(char));
        sysctlbyname("hw.model", model, &len, NULL, 0);
        NSString *model_ns = [NSString stringWithUTF8String:model];
        free(model);
        return model_ns;
    }

    return @"UnknownMac"; //incase model name can't be read
}

static NSString* s_defaultUserAgent = nil;
+ (void) initialize {
    if(!s_defaultUserAgent) {
        [self setDefaultUserAgent:[FLAppInfo userAgent]];
        
        if(!s_defaultUserAgent) {
        
#if IOS        
            NSString* defaultUserAgent = [NSString stringWithFormat:@"%@/%@ (%@; %@; %@; %@; %@;)", 
                [FLAppInfo appName], 
                [FLAppInfo appVersion],
                [FLAppInfo bundleIdentifier],

                [UIDevice currentDevice].model,
                [UIDevice currentDevice].machineName,
                [UIDevice currentDevice].systemName,
                [UIDevice currentDevice].systemVersion];
#else
            int versionMajor=0, versionMinor=0, versionBugFix=0;
            GetSystemVersion(&versionMajor, &versionMinor, &versionBugFix);
    
            NSString* defaultUserAgent = [NSString stringWithFormat:@"%@/%@ (%@; %@; %d.%d.%d;)", 
                [FLAppInfo appName], 
                [FLAppInfo appVersion],
                [FLAppInfo bundleIdentifier],
                FLMachineModel(),
//                [UIDevice currentDevice].machineName,
//                [UIDevice currentDevice].systemName,
//                [UIDevice currentDevice].systemVersion];
                versionMajor, versionMinor, versionBugFix];
#endif                

            [FLHttpRequest setDefaultUserAgent:defaultUserAgent];
//            [NSURLRequest setDefaultUserAgent:defaultUserAgent];
        
        }
    }
}

+ (NSString*) defaultUserAgent {
    return s_defaultUserAgent;
}   

+ (void) setDefaultUserAgent:(NSString*) userAgent {
    FLAssignObjectWithRetain(s_defaultUserAgent, userAgent);
}

@synthesize HTTPMethod = _HTTPMethod;
@synthesize requestURL = _requestURL;
@synthesize postBodyFilePath = _postBodyFilePath;
@synthesize postLength = _postLength;
@synthesize HTTPBody = _postData;
@synthesize allHTTPHeaderFields = _requestHeaders;
@synthesize HTTPBodyStream = _HTTPBodyStream;

#if FL_MRC
- (void) dealloc {
    [_postData release];
    [_HTTPMethod release];
    [_requestURL release];
    [_postBodyFilePath release];
    [_requestHeaders release];
    [super dealloc];
}
#endif

-(id) initWithURL:(NSURL*) url HTTPMethod:(NSString*) HTTPMethod {
    if((self = [super init])) {
        self.requestURL = url;
        self.HTTPMethod = HTTPMethod;
        _requestHeaders = [[NSMutableDictionary alloc] init];
        
        if(FLStringIsEmpty(self.HTTPMethod)) {
            self.HTTPMethod = @"GET";
        }
        
        [self setUserAgentHeader:[FLHttpRequest defaultUserAgent]];
    }
    
    return self;
}

- (id) initWithURL:(NSURL*) url  {
    return [self initWithURL:url HTTPMethod:nil];
}

- (NSInputStream*) HTTPBodyStream {
    if(_HTTPBodyStream) {
        return _HTTPBodyStream;
    }
    if(FLStringIsNotEmpty(self.postBodyFilePath)) {
        return [NSInputStream inputStreamWithFileAtPath:self.postBodyFilePath];
    }
    return nil;
}

- (void) copyTo:(FLHttpRequest*) request {
    request.HTTPMethod = FLAutorelease([self.HTTPMethod copy]);
    request.allHTTPHeaderFields = FLAutorelease([self.allHTTPHeaderFields mutableCopy]);
    request.requestURL = FLAutorelease([self.requestURL copy]);
    request.postBodyFilePath = FLAutorelease([self.postBodyFilePath copy]);
    request.HTTPBody = FLAutorelease([self.HTTPBody copy]);
    request.postLength = self.postLength;
    request.HTTPBodyStream = FLAutorelease([self.HTTPBodyStream copy]);
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    FLHttpRequest* request = [[FLMutableHttpRequest alloc] initWithURL:self.requestURL HTTPMethod:self.HTTPMethod];
    [self copyTo:request];
    return request;
}

- (id)copyWithZone:(NSZone *)zone {
    FLHttpRequest* request = [[[self class] alloc] initWithURL:self.requestURL HTTPMethod:self.HTTPMethod];
    [self copyTo:request];
    return request;
}

+ (id) httpRequestWithURL:(NSURL*) url {
    return FLAutorelease([[[self class] alloc] initWithURL:url HTTPMethod:@"GET"]);
}

+ (id) httpRequest {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
	FLAssertStringIsNotEmpty_v(field, nil);
    FLAssertIsNotNil_v(value, nil);
    [_requestHeaders setObject:value forKey:field];
}

- (NSString *) valueForHTTPHeaderField:(NSString *) field {
    return [_requestHeaders objectForKey:field];
}

- (BOOL) hasHTTPHeaderField:(NSString*) header {
    FLAssertStringIsNotEmpty_v(header, nil);

	return [_requestHeaders objectForKey:header] != nil;
}

- (void) removeHTTPHeaderField:(NSString*) headerName {
    [_requestHeaders removeObjectForKey:headerName];
}

- (BOOL) isPostRequest {
	return FLStringsAreEqualCaseInsensitive(self.HTTPMethod, @"POST");
}

- (void) setPostRequest:(BOOL) isPost {
    if(isPost != self.isPostRequest) {
        self.HTTPMethod = isPost ? @"POST" : @"GET";
    }
}

- (NSString*) userAgentHeader {
    return [self valueForHTTPHeaderField:@"User-Agent"];
}

- (void) setUserAgentHeader:(NSString*) userAgent {
	[self setValue:userAgent forHTTPHeaderField:@"User-Agent"];
}

- (NSString*) HTTPVersion {
    return FLHttpRequestDefaultHTTPVersion;
}

- (void) setHTTPMethod:(NSString *)HTTPMethod {
    FLAssignObjectWithRetain(_HTTPMethod, HTTPMethod);
    
    if(self.isPostRequest) {
        [self setValue:[NSString stringWithFormat:@"%@ HTTP/%@", self.requestURL.path, [self HTTPVersion]] forHTTPHeaderField:@"POST"];
        [self setValue:[NSString stringWithFormat:@"%qu", _postLength] forHTTPHeaderField:@"Content-Length"];
    }
    else {
        [self removeHTTPHeaderField:@"POST"];
        [self removeHTTPHeaderField:@"Content-Length"];
    }
}

- (NSString*) hostHeader {
    return [self valueForHTTPHeaderField:@"HOST"];
}

- (void) setHostHeader:(NSString*) host {
	[self setValue:host forHTTPHeaderField:@"HOST"];
}

- (unsigned long long) contentLengthHeader {
    NSString* length = [self valueForHTTPHeaderField:@"Content-Length"];
    return length ? length.longLongValue : 0;
}

-(void) setContentLengthHeader:(unsigned long long) length {
	[self setValue:[NSString stringWithFormat:@"%llu", length] forHTTPHeaderField:@"Content-Length"];
}

- (void) setHTTPBody:(NSData*) data {
    _postLength = 0;
    FLReleaseWithNil(_postBodyFilePath);
    FLAssignObjectWithRetain(_postData, data);
    if (_postData) {
        _postLength = _postData.length;
        self.HTTPMethod = @"POST";
	}
}

- (void) setPostBodyFilePath:(NSString*) path {
    _postLength = 0;
    FLReleaseWithNil(_postData);
    
    FLAssignObjectWithRetain(_postBodyFilePath, path);
    if(FLStringIsNotEmpty(_postBodyFilePath)) {
        NSError* err = nil;
        _postLength= [[[NSFileManager defaultManager] attributesOfItemAtPath:self.postBodyFilePath error:&err] fileSize];
        
        if(err) {
           FLThrowError(FLAutorelease(err));
        }
        self.HTTPMethod = @"POST";
	}
}

- (NSString*) contentTypeHeader {
    return [self valueForHTTPHeaderField:@"Content-Type"];
}

-(void) setContentTypeHeader:(NSString*) contentType {
	FLAssertStringIsNotEmpty_v(contentType, nil);
    
	[self setValue:contentType forHTTPHeaderField:@"Content-Type"];
}


@end

