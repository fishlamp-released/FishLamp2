//
//  FLHttpOperation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"
#import "FLHttpRequest.h"

@interface FLHttpOperation : FLAsyncOperation {
@private
}


- (void) httpRequestWillAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequest:(FLHttpRequest*) httpRequest 
    didCloseWithResult:(FLPromisedResult) result;

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(NSNumber*) amount;

- (void) httpRequest:(FLHttpRequest*) httpRequest didWriteBytes:(NSNumber*) amount;

@end

@protocol FLHttpOperationDelegate <NSObject>

- (void) httpOperation:(FLHttpOperation*) operation 
httpRequestWillAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpOperation:(FLHttpOperation*) operation 
httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpOperation:(FLHttpOperation*) operation 
   httpRequestWillOpen:(FLHttpRequest*) httpRequest;

- (void) httpOperation:(FLHttpOperation*) operation 
    httpRequestDidOpen:(FLHttpRequest*) httpRequest;

- (void) httpOperation:(FLHttpOperation*) operation 
           httpRequest:(FLHttpRequest*) httpRequest 
    didCloseWithResult:(FLPromisedResult) result;

- (void) httpOperation:(FLHttpOperation*) operation 
           httpRequest:(FLHttpRequest*) httpRequest 
          didReadBytes:(NSNumber*) amount;

- (void) httpOperation:(FLHttpOperation*) operation 
           httpRequest:(FLHttpRequest*) httpRequest 
         didWriteBytes:(NSNumber*) amount;


@end
