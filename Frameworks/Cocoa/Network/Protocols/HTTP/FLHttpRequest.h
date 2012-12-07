//
//  FLHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"
#import "FLHttpMessage.h"
#import "FLRunnable.h"

#define FLHttpRequestDefaultHTTPVersion @"1.1"

@interface FLHttpRequest : NSObject<NSCopying, NSMutableCopying> {
@private
    NSString* _HTTPMethod;
    NSMutableDictionary* _requestHeaders;
    NSURL* _requestURL;
    NSString* _postBodyFilePath;
    NSData* _postData;
    unsigned long long _postLength;
    NSInputStream* _HTTPBodyStream;
}

- (id) initWithURL:(NSURL*) url;

+ (id) httpRequest;
+ (id) httpRequestWithURL:(NSURL*) url;

@property (readonly, strong, nonatomic) NSURL* requestURL;

//
// headers
//
@property (readonly, strong, nonatomic) NSDictionary* allHTTPHeaderFields;
@property (readonly, strong, nonatomic) NSString* HTTPMethod;
@property (readonly, assign, nonatomic, getter=isPostRequest) BOOL postRequest;
@property (readonly, strong, nonatomic) NSString* hostHeader;
@property (readonly, strong, nonatomic) NSString* userAgentHeader;
@property (readonly, assign, nonatomic) unsigned long long contentLengthHeader;
@property (readonly, strong, nonatomic) NSString* contentTypeHeader;

- (NSString *) valueForHTTPHeaderField:(NSString *) field;
- (BOOL) hasHTTPHeaderField:(NSString*) header;

//
// Content
//
@property (readonly, strong, nonatomic) NSString* postBodyFilePath;
@property (readonly, strong, nonatomic) NSData* HTTPBody;
@property (readonly, strong, nonatomic) NSInputStream* HTTPBodyStream;

// 
// MISC
// 

// by default this is loaded from [FLAppInfo userAgent];
+ (void) setDefaultUserAgent:(NSString*) userAgent;
+ (NSString*) defaultUserAgent;

@end

// mutable

