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
      encounteredError:(NSError*) error;

// TODO: these need a little love

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(NSNumber*) amount;

- (void) httpRequest:(FLHttpRequest*) httpRequest didWriteBytes:(NSNumber*) amount;

@end

typedef void (^FLBlockWithHttpByteCount)(unsigned long count);

@interface FLHttpRequestObserver : FLFinisher<FLHttpRequestObserver> {
@private
    FLBlock _willAuthenticateBlock;
    FLBlock _didAuthenticateBlock;
    FLBlock _willOpenBlock;
    FLBlock _didOpenBlock;
   
    fl_result_block_t _willCloseBlock;
    fl_result_block_t _didCloseBlock;
    fl_result_block_t _observerDidFinishBlock;
    
    FLBlockWithError _encounteredErrorBlock;
    
    FLBlockWithHttpByteCount _didWriteBytesBlock;
    FLBlockWithHttpByteCount _didReadBytesBlock;
}
+ (id) httpRequestObserver;
@property (readwrite, copy, nonatomic) FLBlock willAuthenticateBlock;
@property (readwrite, copy, nonatomic) FLBlock didAuthenticateBlock;
@property (readwrite, copy, nonatomic) FLBlock willOpenBlock;
@property (readwrite, copy, nonatomic) FLBlock didOpenBlock;
@property (readwrite, copy, nonatomic) fl_result_block_t willCloseBlock;
@property (readwrite, copy, nonatomic) fl_result_block_t didCloseBlock;
@property (readwrite, copy, nonatomic) fl_result_block_t didFinishBlock;
@property (readwrite, copy, nonatomic) FLBlockWithError encounteredErrorBlock;
@property (readwrite, copy, nonatomic) FLBlockWithHttpByteCount didWriteBytesBlock;
@property (readwrite, copy, nonatomic) FLBlockWithHttpByteCount didReadBytesBlock;
@end
