//
//  FLService.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObservable.h"
#import "FLContextual.h"
#import "FLContext.h"

@protocol FLService <FLObservable>

+ (id) serviceID;

@property (readonly, assign) id context;
- (void) wasAddedToContext:(FLContext*) context;

@property (readonly, assign) BOOL isServiceOpen;
- (void) openService;
- (void) closeService;

+ (id) serviceFromContext:(id) context;
+ (id) optionalServiceFromContext:(id) context;

@end

@interface FLService : FLObservable<FLService> {
@private
    __unsafe_unretained id<FLService> _context;
    BOOL _isServiceOpen;
}
@end

#define synthesize_service_(__NAME__, __TYPE__) \
    - (__TYPE__*) __NAME__ { return [__TYPE__ serviceFromContext:self]; } 