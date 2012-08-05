//
//  CFHTTPMessageWrapper.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//
#import "FishLampCore.h"

#import <Foundation/Foundation.h>

@interface CFHTTPMessageWrapper : NSObject<NSCopying> {
@private
    CFHTTPMessageRef _message;
}
@property (readonly, assign, nonatomic) CFHTTPMessageRef messageRef; 

@property (readonly, assign, nonatomic) BOOL isHeaderComplete;
@property (readonly, retain, nonatomic) NSString* httpVersion;
@property (readonly, copy, nonatomic) NSDictionary* allHeaders;

/** request */ 
@property (readonly, assign, nonatomic) BOOL isRequest;
@property (readonly, retain, nonatomic) NSURL* requestURL;
@property (readonly, retain, nonatomic) NSString* requestMethod;

/** response */
@property (readonly, assign, nonatomic) NSInteger responseStatusCode;
@property (readonly, retain, nonatomic) NSString* responseStatusLine;

/** body */
@property (readwrite, retain, nonatomic) NSData* bodyData;

- (id) initWithHttpMessageRef:(CFHTTPMessageRef) ref; // takes ownership
- (id) initWithURL:(NSURL*) url requestMethod:(NSString*) requestMethodOrNil; // defaults to GET if nil
- (id) init;

- (void) setHeader:(NSString*) header value:(NSString*) value;
- (NSString*) valueForHeader:(NSString*) header;

- (void) setHeaders:(NSDictionary*) headers;

@end
