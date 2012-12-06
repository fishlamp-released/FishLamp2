//
//  FLArrangement.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FishLampCore.h"
#import "FLArrangeable.h"
#import "FLArrangeableContainer.h"
#import "SDKEdgeInsets.h"

@class FLArrangement;

typedef void (^FLArrangementWillLayoutBlock)(id arrangement, SDKRect bounds);
typedef void (^FLArrangementFrameSetter)(id view, SDKRect newFrame); 

@interface FLArrangement : NSObject {
@private
	SDKEdgeInsets _outerInsets;
	SDKEdgeInsets _innerInsets;
    
    FLArrangementWillLayoutBlock _onWillArrange;
    FLArrangementFrameSetter _frameSetter;
}

@property (readwrite, assign, nonatomic) SDKEdgeInsets outerInsets;

@property (readwrite, assign, nonatomic) SDKEdgeInsets innerInsets;

@property (readwrite, copy, nonatomic) FLArrangementFrameSetter frameSetter;
 
@property (readwrite, copy, nonatomic) FLArrangementWillLayoutBlock onWillArrange;

+ (id) arrangement;

// each item must implement methods in FLArrangeable
- (SDKSize) performArrangement:(NSArray*) arrayOfArrangeabeFrames
                     inBounds:(SDKRect) bounds;

// utils for subclasses.

- (SDKRect) setFrame:(SDKRect) frame
          forObject:(id) object;

- (SDKRect) frameForObject:(id) object;

// override point. Returns size of new bounds - can be same size as input bounds.
// each item must implement methods in FLArrangeable
- (SDKSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(SDKRect) bounds;

+ (FLArrangementFrameSetter) defaultFrameSetter;

// these may only make sense on IOS??

+ (FLArrangementFrameSetter) optimizedForSizeFrameSetter;

+ (FLArrangementFrameSetter) optimizedForLocationFrameSetter;

@end






