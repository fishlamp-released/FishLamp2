//
//  FLGridViewObject.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLDataRef.h"

@protocol FLGridViewObject <FLMutableDataRef>
@property (readonly, retain, nonatomic) NSString* gridViewDisplayName;
- (id) createGridViewCell;
@end

@interface NSObject (FLGridViewObject)

// all return nil by default.
@property (readonly, retain, nonatomic) NSString* gridViewDisplayName;
- (id) createGridViewCell;
@end

