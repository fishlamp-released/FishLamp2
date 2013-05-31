////
////  FLHttpRequestObserver.h
////  FishLampCocoa
////
////  Created by Mike Fullerton on 2/12/13.
////  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
////
//
//#import "FLDispatch.h"
//
//@class FLHttpRequest;
//
//
//
////typedef void (^FLBlockWithHttpByteCount)(unsigned long count);
////
////@interface FLHttpRequestObserver : FLFinisher<FLHttpRequestObserver> {
////@private
////    FLBlock _willAuthenticateBlock;
////    FLBlock _didAuthenticateBlock;
////    FLBlock _willOpenBlock;
////    FLBlock _didOpenBlock;
////   
////    fl_result_block_t _willCloseBlock;
////    fl_result_block_t _didCloseBlock;
////    fl_result_block_t _observerDidFinishBlock;
////    
////    FLBlockWithError _wasTerminatedBlock;
////    
////    FLBlockWithHttpByteCount _didWriteBytesBlock;
////    FLBlockWithHttpByteCount _didReadBytesBlock;
////}
////+ (id) httpRequestObserver;
////@property (readwrite, copy, nonatomic) FLBlock willAuthenticateBlock;
////@property (readwrite, copy, nonatomic) FLBlock didAuthenticateBlock;
////@property (readwrite, copy, nonatomic) FLBlock willOpenBlock;
////@property (readwrite, copy, nonatomic) FLBlock didOpenBlock;
////@property (readwrite, copy, nonatomic) fl_result_block_t willCloseBlock;
////@property (readwrite, copy, nonatomic) fl_result_block_t didCloseBlock;
////@property (readwrite, copy, nonatomic) fl_result_block_t didFinishBlock;
////@property (readwrite, copy, nonatomic) FLBlockWithError encounteredErrorBlock;
////@property (readwrite, copy, nonatomic) FLBlockWithHttpByteCount didWriteBytesBlock;
////@property (readwrite, copy, nonatomic) FLBlockWithHttpByteCount didReadBytesBlock;
////@end
