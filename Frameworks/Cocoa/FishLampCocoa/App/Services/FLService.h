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
#import "FLAtomicProperties.h"

@protocol FLService <FLObservable>

@property (readonly, assign) id context;
- (void) wasAddedToContext:(FLContext*) context;

@property (readonly, assign) BOOL isServiceOpen;
- (void) openService;
- (void) closeService;

@end

@interface FLService : FLObservable<FLService> {
@private
    __unsafe_unretained id<FLService> _context;
    BOOL _isServiceOpen;
}
@end

#define FLDeclareService(__NAME__, __TYPE__) \
    @class __TYPE__; \
    @protocol __TYPE__##ServiceRegistration <NSObject> \
        @property (readwrite, strong) __TYPE__* __NAME__; \
    @end

#define FLSynthesizeService(__GETTER__, __SETTER__, __TYPE__) \
    - (__TYPE__*) __GETTER__ { \
        return FLAtomicPropertyGet(&_##__GETTER__); \
    } \
    - (void) __SETTER__:(__TYPE__*) service { \
        [self setService:service forName:@#__GETTER__]; \
        FLAtomicPropertySet(&_##__GETTER__, service); \
    }

    