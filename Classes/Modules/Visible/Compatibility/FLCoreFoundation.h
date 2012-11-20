//
//  FLCoreFoundationUtils.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

   

NS_INLINE 
void _release_CFRef(CFTypeRef* ref) {
    if(ref && *ref) {
        CFRelease(*ref);
        *ref = nil;
    }
}

#define FLReleaseCRef_(__REF__) _release_CFRef((CFTypeRef*) &(__REF__))

//#define FLBridgeTransferToCFString( __OBJ__) \
//            bridge_transfer_(CFStringRef, __OBJ__)
//
//#define FLBridgeToCFString(__OBJ__) \
//            bridge_(CFStringRef, __OBJ__)
//
//#define FLBridgeRetainToCFString(__OBJ__) \
//            bridge_retain_(CFStringRef, __OBJ__)
            
            