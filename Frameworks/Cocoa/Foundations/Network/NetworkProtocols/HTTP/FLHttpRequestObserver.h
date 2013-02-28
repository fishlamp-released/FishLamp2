//
//  FLHttpRequestObserver.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDispatch.h"

@class FLHttpRequest;

@protocol FLHttpRequestObserver <NSObject>
@optional

- (void) httpRequestWillAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequest:(FLHttpRequest*) httpRequest 
    didCloseWithResult:(FLResult) result;

- (void) httpRequest:(FLHttpRequest*) httpRequest
      didEncounterError:(NSError*) error;

// TODO: these need a little love

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(NSNumber*) amount;

- (void) httpRequest:(FLHttpRequest*) httpRequest didWriteBytes:(NSNumber*) amount;

@end

typedef void (^FLBlockWithHttpByteCount)(unsigned long count);

@interface FLHttpRequestObserver : FLFinisher<FLHttpRequestObserver> {
@private
    FLBlock _willAuthenticate;
    FLBlock _didAuthenticate;
    FLBlock _willOpen;
    FLBlock _didOpen;
   
    FLBlockWithResult _willClose;
    FLBlockWithResult _didClose;
    FLBlockWithResult _observerDidFinish;
    
    FLBlockWithError _encounteredError;
    
    FLBlockWithHttpByteCount _didWriteBytes;
    FLBlockWithHttpByteCount _didReadBytes;
}
+ (id) httpRequestObserver;
@property (readwrite, copy, nonatomic) FLBlock willAuthenticate;
@property (readwrite, copy, nonatomic) FLBlock didAuthenticate;
@property (readwrite, copy, nonatomic) FLBlock willOpen;
@property (readwrite, copy, nonatomic) FLBlock didOpen;
@property (readwrite, copy, nonatomic) FLBlockWithResult willClose;
@property (readwrite, copy, nonatomic) FLBlockWithResult didClose;
@property (readwrite, copy, nonatomic) FLBlockWithResult didFinish;
@property (readwrite, copy, nonatomic) FLBlockWithError encounteredError;
@property (readwrite, copy, nonatomic) FLBlockWithHttpByteCount didWriteBytes;
@property (readwrite, copy, nonatomic) FLBlockWithHttpByteCount didReadBytes;
@end
