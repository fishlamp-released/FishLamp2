////
////  FLHttpRequestObserver.m
////  FishLampCocoa
////
////  Created by Mike Fullerton on 2/12/13.
////  Copyright (c) 2013 Mike Fullerton. All rights reserved.
////
//
//#import "FLHttpRequestObserver.h"
//
//@implementation FLHttpRequestObserver 
//
//+ (id) httpRequestObserver {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//@synthesize willAuthenticateBlock = _willAuthenticateBlock;
//@synthesize didAuthenticateBlock = _didAuthenticateBlock;
//@synthesize willOpenBlock = _willOpenBlock;
//@synthesize didOpenBlock = _didOpenBlock;
//@synthesize willCloseBlock = _willCloseBlock;
//@synthesize didCloseBlock = _didCloseBlock;
//@synthesize encounteredErrorBlock = _encounteredErrorBlock;
//@synthesize didWriteBytesBlock = _didWriteBytesBlock;
//@synthesize didReadBytesBlock = _didReadBytesBlock;
//@synthesize didFinishBlock = _observerDidFinishBlock;
//
//#if FL_MRC
//- (void) dealloc {
//    [_willAuthenticateBlock release];
//    [_didAuthenticateBlock release];
//    [_willOpenBlock release];
//    [_didOpenBlock release];
//    [_willCloseBlock release];
//    [_didCloseBlock release];
//    [_encounteredErrorBlock release];
//    [_didWriteBytesBlock release];
//    [_didReadBytesBlock release];
//    [_observerDidFinishBlock release];
//    [super dealloc];
//}
//#endif
//
//#define FLInvokeBlock(b, ...) \
//    if(b) { \
//        b(__VA_ARGS__); \
//    }
//
//- (void) httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest {
//    FLInvokeBlock(self.didAuthenticateBlock);
//}
//
//- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest {
//    FLInvokeBlock(self.willOpenBlock);
//}
//
//- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest {
//    FLInvokeBlock(self.didOpenBlock);
//}
//
//- (void) httpRequest:(FLHttpRequest*) httpRequest 
//   willCloseWithResult:(FLResult) result {
//    FLInvokeBlock(self.willCloseBlock, result);
//}   
//
//- (void) httpRequest:(FLHttpRequest*) httpRequest 
//    didCloseWithResult:(FLResult) result {
//    FLInvokeBlock(self.didCloseBlock, result);
//}    
//
//- (void) httpRequest:(FLHttpRequest*) httpRequest
//      encounteredError:(NSError*) error {
//    FLInvokeBlock(self.encounteredErrorBlock, error);
//}
//
//- (void) httpRequestDidReadBytes:(FLHttpRequest*) httpRequest  amount:(NSNumber*) amount{
//    FLInvokeBlock(self.didReadBytesBlock, amount);
//}
//
//- (void) httpRequestDidWriteBytes:(FLHttpRequest*) httpRequest  amount:(NSNumber*) amount {
//    FLInvokeBlock(self.didWriteBytesBlock, amount);
//}
//
//@end
