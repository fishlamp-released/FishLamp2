//
//  FLGridViewObject.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridViewObject.h"

@implementation NSObject (FLGridViewObject)

- (id) gridViewObjectId {
    FLRequiredOverride();
    return nil;
}

- (NSString*) gridViewDisplayName {
    FLRequiredOverride();
    return nil;
}

- (id) createGridViewCell {
    FLRequiredOverride();
    return nil;
}


@end
