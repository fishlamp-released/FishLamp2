//
//  FLHttpStream.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLReadStream.h"
#import "FLHttpMessage.h"
#import "FLHttpRequestHeaders.h"
#import "FLStreamWorker.h"

@interface FLHttpStream : FLReadStream


- (id) initWithURL:(NSURL*) url
        httpMethod:(NSString*) method
           headers:(NSDictionary*) headers
          bodyData:(NSData*) data;

- (id) initWithURL:(NSURL*) url
        httpMethod:(NSString*) method
           headers:(NSDictionary*) headers
        bodyStream:(NSInputStream*) data;

- (id) initWithHeaders:(FLHttpRequestHeaders*) headers 
        withBodyStream:(NSInputStream*) inputStream;

- (id) initWithHeaders:(FLHttpRequestHeaders*) headers 
         withBodyData:(NSData*) bodyData;

+ (id) httpStream:(NSURL*) url
             httpMethod:(NSString*) method
                headers:(NSDictionary*) headers
               bodyData:(NSData*) data;

+ (id) httpStream:(NSURL*) url
             httpMethod:(NSString*) method
                headers:(NSDictionary*) headers
             bodyStream:(NSInputStream*) data;

+ (id) httpStream:(FLHttpRequestHeaders*) headers 
         withBodyStream:(NSInputStream*) inputStream;

+ (id) httpStream:(FLHttpRequestHeaders*) headers 
           withBodyData:(NSData*) bodyData;

- (FLHttpMessage*) readResponseHeaders;

- (unsigned long) bytesWritten;

@end

