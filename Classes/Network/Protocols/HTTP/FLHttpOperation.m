//
//	FLHttpOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLHttpOperation.h"
#import "FLTraceOff.h"

@interface FLHttpOperation ()
@property (readwrite, strong) FLHttpResponse* httpResponse;
@end

@implementation FLHttpOperation

synthesize_(httpResponse);
synthesize_(URL);
synthesize_(httpAuthenticator);
synthesize_(httpConnectionAuthenticator);

- (void) didInit {
}

- (id) init {
	if((self = [super init])) {
        [self didInit];
	}
	
	return [self initWithURL:nil];
}

- (id) initWithURL:(NSURL*) url {
	if((self = [super init])) {	
		self.URL = url;
        [self didInit];
	}
	
	return self;
}

- (id) initWithURLString:(NSString*) url {
	return [self initWithURL:[NSURL URLWithString:url]];
}

+ (id) httpOperationWithURL:(NSURL*) url {
	return autorelease_([[[self class] alloc] initWithURL:url]);
}

dealloc_(
    [_httpConnectionAuthenticator release];
    [_httpAuthenticator release];
    [_httpResponse release];
    [_URL release];
)

- (FLHttpConnection*) httpConnection {
    return (FLHttpConnection*) self.networkConnection;
}

- (void) setHttpConnection:(FLHttpConnection*) connection {
    self.networkConnection = connection;
}
 
- (FLHttpConnection*) createNetworkConnection {
    return  [FLHttpConnection httpConnection:[FLHttpRequest httpRequestWithURL:self.URL requestMethod:@"GET"]];
}

- (FLHttpRequest*) httpRequest {
    return self.httpConnection.httpRequest;
}

- (void) prepareAuthenticatedConnection:(FLHttpConnection*) connection {

#if DEBUG
    if(self.httpConnectionAuthenticator) {
        FLTrace(@"Adding security token to request in %@", NSStringFromClass([self class]));
    }
#endif

    FLPerformSelector2(self.httpConnectionAuthenticator, @selector(authenticateConnection:withContext:), connection, self.context);
}

- (void) authenticateSelf {
    FLPerformSelector1(self.httpAuthenticator, @selector(authenticateOperation:), self);
}

- (void) prepareSelf {
    [self authenticateSelf];
    [super prepareSelf];
}

- (void) runSelf {
    [self prepareAuthenticatedConnection:self.httpConnection];
    [super runSelf];
}

- (void) handleAsyncResultFromConnection:(id) result {
    FLHttpResponse* httpResponse = result;
    FLAssertIsNotNil_(httpResponse);
    FLAssertIsKindOfClass_(httpResponse, FLHttpResponse);
    self.httpResponse = httpResponse;
}

@end

