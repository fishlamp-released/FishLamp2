//
//  GtNetworkRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/9/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtNetworkRequestProtocol.h"

#define GtDefaultTimeout 20.0

@interface GtNetworkRequest : NSObject<GtNetworkRequestProtocol> {
@private
// retained	
    NSURLConnection* m_connection;
	NSCondition* m_lock;
	NSMutableData* m_receivedData;
	NSMutableURLRequest* m_request;
	NSURLResponse* m_response;
	NSError* m_error;
	NSString* m_host;
	NSString* m_url;
    
// data    
	NSTimeInterval m_timeoutTimestamp;

// not retained
	NSTimer* m_timeoutTimer;
	id m_delegate;

    NSTimeInterval m_timeout;
	
	struct {
#if IN_THREAD
		unsigned int locked:1;
#endif
		unsigned int cancelled:1;
        unsigned int timeout:6;
	} m_flags;
}

-(id) initWithUrl:(NSString*) urlString;

@property (readwrite, assign, nonatomic) NSTimeInterval timeout;
@property (readonly, assign, nonatomic) NSData* receivedData;
@property (readwrite, assign, nonatomic) NSError* error;
@property (readonly, assign, nonatomic) NSString* host;
@property (readonly, assign, nonatomic) NSURLResponse* response;
@property (readonly, assign, nonatomic) NSString* url;
@property (readonly, assign, nonatomic) NSMutableURLRequest* request;
@property (readwrite, assign, nonatomic) id delegate;

- (void) send;

- (void) cancel;
- (BOOL) wasCancelled;

+ (void) setTimeoutInSeconds:(NSTimeInterval) timeout;
+ (NSTimeInterval) timeoutInSeconds;

- (void) stopTimeoutTimer;
- (void) updateTimestamp;

@end

@interface GtNetworkRequest (Internal)

- (void) connection:(NSURLConnection *)connection 
 didReceiveResponse:(NSURLResponse *)response;
 
- (void) connection:(NSURLConnection*)connection 
     didReceiveData:(NSData *)data;
	 
- (void) connection:(NSURLConnection*)connection 
   didFailWithError:(NSError *)error;
   
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

- (void)connection:(NSURLConnection *)connection 
   didSendBodyData:(NSInteger)bytesWritten 
 totalBytesWritten:(NSInteger)totalBytesWritten 
 totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;


@end

@protocol GtNetworkRequestDelegate <NSObject>

- (void) networkRequest:(GtNetworkRequest *) request 
	didSendBodyData:(NSInteger)bytesWritten 
	totalBytesWritten:(NSInteger)totalBytesWritten 
	totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;

@end
