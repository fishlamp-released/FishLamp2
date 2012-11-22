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
#import "FLEdgeInsets.h"

@class FLArrangement;

typedef void (^FLArrangementWillLayoutBlock)(id arrangement, FLRect bounds);
typedef void (^FLArrangementFrameSetter)(id view, FLRect newFrame); 

@interface FLArrangement : NSObject {
@private
	FLEdgeInsets _outerInsets;
	FLEdgeInsets _innerInsets;
    
    FLArrangementWillLayoutBlock _onWillArrange;
    FLArrangementFrameSetter _frameSetter;
}

@property (readwrite, assign, nonatomic) FLEdgeInsets outerInsets;

@property (readwrite, assign, nonatomic) FLEdgeInsets innerInsets;

@property (readwrite, copy, nonatomic) FLArrangementFrameSetter frameSetter;
 
@property (readwrite, copy, nonatomic) FLArrangementWillLayoutBlock onWillArrange;

+ (id) arrangement;

// each item must implement methods in FLArrangeable
- (FLSize) performArrangement:(NSArray*) arrayOfArrangeabeFrames
                     inBounds:(FLRect) bounds;

// utils for subclasses.

- (FLRect) setFrame:(FLRect) frame
          forObject:(id) object;

- (FLRect) frameForObject:(id) object;

// override point. Returns size of new bounds - can be same size as input bounds.
// each item must implement methods in FLArrangeable
- (FLSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(FLRect) bounds;

+ (FLArrangementFrameSetter) defaultFrameSetter;

// these may only make sense on IOS??

+ (FLArrangementFrameSetter) optimizedForSizeFrameSetter;

+ (FLArrangementFrameSetter) optimizedForLocationFrameSetter;

@end






