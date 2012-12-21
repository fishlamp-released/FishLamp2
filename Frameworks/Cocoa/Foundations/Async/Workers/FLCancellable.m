//
//  FLCancellable.m
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCancellable.h"
//#import "FLFinisher.h"
//
//@interface FLCancellable ()
////@property (readwrite, strong) NSMutableArray* cancelled;
////@property (readwrite, assign) BOOL wasCancelled;
//@end
//
//@implementation FLCancellable 
//
//+ (id) cancelHandler {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_dependents release];
//    [super dealloc];
//}
//#endif
//
//- (void) requestCancel {
//    @synchronized(self) {
//        for(id<FLCancellable> obj in _dependents) {
//            [obj requestCancel];
//        }
//    }
//}
//
//- (void) addDependent:(id<FLCancellable>) dependent {
//    @synchronized(self) {
//        if(!_dependents) {
//            _dependents= [[NSMutableArray alloc] init];
//        }
//    
//        [_dependents addObject:dependent];
//    }
//}
//
//- (void) removeDependent:(id<FLCancellable>) dependent {
//    @synchronized(self) {
//        [_dependents removeObject:dependent]    ;
//    }
//}
//
////
////- (FLResult) runBlock:(FLResult (^)()) block forDependent:(id<FLCancellable>) dependent {
////
////    @try {
////        [self addDependent:dependent];
////        if(self.wasCancelled) {
////            return [NSError cancelError];
////        }
////        
////        if(block) {
////            return block();
////        }
////    }
////    @catch(NSException* ex) {
////        return ex.error;
////    }
////    @finally {
////        [self removeDependent:dependent];
////    }
////    
////    return nil;
////}
//
//
//@end

