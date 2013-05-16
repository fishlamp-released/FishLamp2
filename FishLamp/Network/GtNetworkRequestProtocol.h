//
//  GtNetworkRequestProtocol.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/9/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

@protocol GtNetworkRequestProtocol <NSObject>

- (NSData*) receivedData;
- (NSError*) error;
- (NSString*) host;
- (NSURLResponse*) response;
- (NSString*) url;
- (NSMutableURLRequest*) request;

- (void) send;

- (void) cancel;
- (BOOL) wasCancelled;

- (id) delegate;
- (void) setDelegate:(id) delegate;

@end