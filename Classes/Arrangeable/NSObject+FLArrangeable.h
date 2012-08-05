//
//  NSObject+FLArrangeable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLArrangeable.h"

@interface NSObject (FLArrangeable)

// We don't want all objects to have this api tacked onto them.
// So we should only use this for categories on existing objects like NSView/UIView that
// we want to arrange but can't add the member data directly (e.g. our own subclass).
//
// The declared methods are in this .m file so you can safely expect them to be
// here.

/*
    @property (readwrite, assign, nonatomic) FLEdgeInsets arrangeableInsets;
    @property (readwrite, assign, nonatomic) FLArrangeableFillMode arrangeableFillMode;
    @property (readwrite, assign, nonatomic) FLArrangeableWeight arrangeableWeight;
    @property (readwrite, assign, nonatomic) FLArrangeableState arrangeableState
*/

@end


#define FLDeclareArrangebleObjectProperties() \
    @property (readwrite, assign, nonatomic) FLEdgeInsets arrangeableInsets; \
    @property (readwrite, assign, nonatomic) FLArrangeableFillMode arrangeableFillMode; \
    @property (readwrite, assign, nonatomic) FLArrangeableWeight arrangeableWeight; \
    @property (readwrite, assign, nonatomic) FLArrangeableState arrangeableState

// paste these into your .m file
/*
    @dynamic arrangeableInsets;
    @dynamic arrangeableFillMode;
    @dynamic arrangeableWeight;
    @dynamic arrangeableState;
*/

#define FLSynthesizeArrangeableObjectProperties() \
    @dynamic arrangeableInsets; \
    @dynamic arrangeableFillMode; \
    @dynamic arrangeableWeight; \
    @dynamic arrangeableState
