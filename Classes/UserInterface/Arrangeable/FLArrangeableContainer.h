//
//  FLArrangeableContainer.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 8/1/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLArrangement;

@protocol FLArrangeableContainer <NSObject>
@property (readwrite, strong, nonatomic) FLArrangement* arrangement;
@property (readonly, nonatomic) NSArray* arrangeables;
@property (readwrite, assign, nonatomic) FLRect bounds;
@end
//
//@interface FLArrangeableContainer : NSObject
//
//@end
