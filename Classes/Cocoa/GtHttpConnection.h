//
//  GtHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "CFHTTPMessageWrapper.h"
#import "CFHTTPStreamWrapper.h"

#import "GtHttpRequest.h"
#import "GtHttpResponse.h"

#define GtHttpRequestDefaultTimeout 120.0f

@protocol GtHttpConnectionDelegate;

@interface GtHttpConnection : NSObject<CFReadStreamWrapperDelegate> {
@private
    id<GtHttpConnectionDelegate> m_delegate;
    CFHTTPStreamWrapper* m_inputStream;
    GtHttpResponse* m_response;
    NSMutableArray* m_requestQueue;
    NSError* m_error;
    NSTimer* m_timeoutTimer;
    NSThread* m_thread; // not retained.
    
    unsigned long long m_lastBytesSent;
    unsigned long long m_bytesSent;
    
    NSUInteger m_retryCount;
    NSUInteger m_maxRetryCount;
    
    NSTimeInterval m_lastIdleEvent;
    NSTimeInterval m_lastIdleTimeSpan;
    NSTimeInterval m_timestamp;
    NSTimeInterval m_timeoutInterval;

    struct {
        unsigned int finished: 1;
        unsigned int startedActivityIndicator: 1;
        unsigned int timedOut : 1;
        unsigned int canRetry: 1;
    } m_flags;
}

@property (readwrite, assign, nonatomic) id<GtHttpConnectionDelegate> delegate;

- (id) initWithHttpRequest:(GtHttpRequest*) request;

+ (id) httpConnection:(GtHttpRequest*) request;

/** retry support */
@property (readwrite, assign, nonatomic) BOOL canRetry;
@property (readwrite, assign, nonatomic) NSUInteger maxRetryCount;
@property (readonly, assign, nonatomic) NSUInteger retryCount;

/** implementation objects */
@property (readonly, retain, nonatomic) GtHttpRequest* httpRequest;
@property (readonly, retain, nonatomic) GtHttpResponse* httpResponse;

@property (readonly, retain, nonatomic) NSError* error;

/** usage */
- (void) beginAsyncRequest;

- (void) performSynchronously;

/** canceling */
@property (readonly, assign, nonatomic) BOOL wasCancelled;
- (void) cancelRequest; // can be called from any thread.

/** timeouts */
@property (readwrite, assign, nonatomic) NSTimeInterval timeoutInterval;
@property (readonly, assign, nonatomic) BOOL hasTimedOut;
@property (readonly, assign, nonatomic) NSTimeInterval lastActivityTimestamp;

/** this is called automatically, but you can call it yourself if you need to */
- (void) updateLastActivityTimestamp;

/** override point */
- (void) prepareRequest;

@end

@protocol GtHttpConnectionDelegate <NSObject>

- (void) httpConnectionWillBegin:(GtHttpConnection*) connection;

- (void) httpConnectionDidComplete:(GtHttpConnection*) connection;

- (void) httpConnection:(GtHttpConnection*) connection
       didFailWithError:(NSError*) error;

- (void) httpConnectionWasCancelled:(GtHttpConnection*) connection;

- (void) httpConnectionDidTimeout:(GtHttpConnection*) connection;

- (void) httpConnection:(GtHttpConnection*) connection 
     didReceiveResponse:(GtHttpResponse*) response;

/** this is called after 1 second of inactivity and then every 1 second of subsequent inactivity after that. */
- (void) httpConnection:(GtHttpConnection*) connection 
                 isIdle:(NSTimeInterval) lastActivityTimestamp;

- (void) httpConnection:(GtHttpConnection*) connection 
              sentBytes:(unsigned long long) sentBytes 
         totalSentBytes:(unsigned long long) totalSentBytes 
totalBytesExpectedToSend:(unsigned long long) totalBytesExpectedToSend;

- (BOOL) httpConnection:(GtHttpConnection*) connection
    shouldRedirectToURL:(NSURL*) url;
    
- (BOOL) httpConnectionShouldRetry:(GtHttpConnection*) connection;

@end



