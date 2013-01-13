//
//  FLService.h
//  FLCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLFinisher.h"
#import "FLResult.h"
#import "FLObservable.h"
#import "FLServiceProvider.h"
#import "FLServiceManager.h"

@class FLServiceManager;

@interface FLService : FLObservable<FLServiceProvider> {
@private
    __unsafe_unretained id _context;
}
@end
//
//@interface FLRequestHandlingService : FLService {
//@private
//    NSMutableDictionary* _requestHandlers;
//}
//
//- (void) setRequestHandler:(SEL) handler 
//     forServiceRequestType:(id) serviceRequestType;
//
//@end

