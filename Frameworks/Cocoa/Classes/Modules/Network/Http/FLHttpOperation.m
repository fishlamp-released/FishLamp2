//
//  FLHttpOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/24/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHttpOperation.h"

@interface FLHttpOperation ()
@property (readwrite, strong, nonatomic) FLHttpRequest* httpRequest;
@end

@implementation FLHttpOperation
@synthesize httpRequest = _httpRequest;

- (id) init {	
    return [self initWithHttpRequest:nil];
}

- (id) initWithHttpRequest:(FLHttpRequest*) request {
	self = [super init];
	if(self) {
		self.httpRequest = request;
        self.httpRequest.delegate = self;
	}
	return self;
}

+ (id) httpOperation:(FLHttpRequest*) request {
    return FLAutorelease([[[self class] alloc] initWithHttpRequest:request]);
}

- (void) dealloc {  
    _httpRequest.delegate = nil;
#if FL_MRC
	[_httpRequest release];
	[super dealloc];
#endif
}

- (void) setFinishedWithResult:(id) result error:(NSError*) error {
    [self.finisher setFinishedWithResult:result error:error];
}

- (id) startAsyncOperation {
    [self runChildAsynchronously:self.httpRequest completion:^(id result, NSError* error) {
        [self setFinishedWithResult:result];
    }];
    
    return nil;
}

- (void) httpRequestWillAuthenticate:(FLHttpRequest*) httpRequest {
    FLPerformSelector1(self.delegate, @selector(httpRequestWillAuthenticate:), httpRequest);
}

- (void) httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest {
    FLPerformSelector1(self.delegate, @selector(httpRequestDidAuthenticate:), httpRequest);
}

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest {
    FLPerformSelector1(self.delegate, @selector(httpRequestWillOpen:), httpRequest);
}

- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest {
    FLPerformSelector1(self.delegate, @selector(httpRequestDidOpen:), httpRequest);
}

- (void) httpRequest:(FLHttpRequest*) httpRequest 
  didCloseWithResult:(id) result
               error:(NSError*) error {

    FLPerformSelector3(self.delegate, @selector(httpRequest:didCloseWithResult:error:), httpRequest, result, error);
}    

- (void) httpRequest:(FLHttpRequest*) httpRequest 
        didReadBytes:(NSNumber*) amount {

    FLPerformSelector2(self.delegate, @selector(httpRequest:didReadBytes:), httpRequest, amount);
}

- (void) httpRequest:(FLHttpRequest*) httpRequest 
       didWriteBytes:(NSNumber*) amount {

    FLPerformSelector2(self.delegate, @selector(httpRequest:didWriteBytes:), httpRequest, amount);
}


@end
