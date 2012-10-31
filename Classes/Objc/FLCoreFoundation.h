//
//  FLCoreFoundationUtils.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#if FL_ARC

    #define FLBridgeTransferFromCFRef(__TYPE_REF__) \
                ((__bridge_transfer id) __TYPE_REF__)

    #define FLBridgeTransferFromCFRefCopy(__TYPE_REF__) \
                ((__bridge_transfer id) __TYPE_REF__)

    #define FLBridgeFromCFRef(__TYPE_REF__) \
                ((__bridge id) __TYPE_REF__)
                                
    #define FLBridgeRetainFromCFRef(__TYPE_REF__) \
                ((__bridge_retain id) __TYPE_REF__)
    
    #define FLBridgeTransferToCFRef( __OBJ__) \
                ((__bridge_transfer CFTypeRef) __OBJ__)

    #define FLBridgeToCFRef(__OBJ__) \
                ((__bridge CFTypeRef) __OBJ__)

    #define FLBridgeRetainedToCFRef(__OBJ__) \
                ((__bridge_retained CFTypeRef) __OBJ__)


#else 

    #define FLBridgeTransferFromCFRef(__TYPE_REF__) \
                ((id) __TYPE_REF__)
                
    #define FLBridgeTransferFromCFRefCopy(__TYPE_REF__) \
                [((id) __TYPE_REF__) autorelease]

    #define FLBridgeFromCFRef(__TYPE_REF__) \
                ((id) __TYPE_REF__)
                                
    #define FLBridgeRetainFromCFRef(__TYPE_REF__) \
                [((id) __TYPE_REF__) retain]
    
    #define FLBridgeTransferToCFRef(__OBJ__) \
                ((CFTypeRef) __OBJ__)

    #define FLBridgeToCFRef(__OBJ__) \
                ((CFTypeRef) __OBJ__)

    #define FLBridgeRetainedToCFRef(__OBJ__) \
                ((CFTypeRef) [__OBJ__ retain])

#endif

NS_INLINE 
void _FLReleaseCFRef(CFTypeRef* ref) {
    if(ref && *ref) {
        CFRelease(*ref);
        *ref = nil;
    }
}

#define FLReleaseCFRef(__REF__) _FLReleaseCFRef((CFTypeRef*) &(__REF__))