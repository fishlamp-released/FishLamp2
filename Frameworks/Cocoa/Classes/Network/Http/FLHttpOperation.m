//
//  FLHttpOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpOperation.h"

@implementation FLHttpOperation


- (void) httpRequestWillAuthenticate:(FLHttpRequest*) httpRequest {
    FLPerformSelector2(self.delegate, @selector(httpOperation:httpRequestWillAuthenticate:), self, httpRequest);
}

- (void) httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest {
    FLPerformSelector2(self.delegate, @selector(httpOperation:httpRequestDidAuthenticate:), self, httpRequest);
}

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest {
    FLPerformSelector2(self.delegate, @selector(httpOperation:httpRequestWillOpen:), self, httpRequest);
}

- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest {
    FLPerformSelector2(self.delegate, @selector(httpOperation:httpRequestDidOpen:), self, httpRequest);
}

- (void) httpRequest:(FLHttpRequest*) httpRequest 
  didCloseWithResult:(FLPromisedResult) result {

    FLPerformSelector3(self.delegate, @selector(httpOperation:httpRequest:didCloseWithResult:), self, httpRequest, result);
}    

- (void) httpRequest:(FLHttpRequest*) httpRequest 
        didReadBytes:(NSNumber*) amount {

    FLPerformSelector3(self.delegate, @selector(httpOperation:httpRequest:didReadBytes:), self, httpRequest, amount);
}

- (void) httpRequest:(FLHttpRequest*) httpRequest 
       didWriteBytes:(NSNumber*) amount {

    FLPerformSelector3(self.delegate, @selector(httpOperation:httpRequest:didWriteBytes:), self, httpRequest, amount);
}


@end
