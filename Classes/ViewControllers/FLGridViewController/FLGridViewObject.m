//
//  FLGridViewObject.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridViewObject.h"

@implementation NSObject (FLGridViewObject)

- (id) dataRefKey {
    FLAssertIsOverridden_v(nil);
    return nil;
}

- (NSString*) gridViewDisplayName {
    FLAssertIsOverridden_v(nil);
    return nil;
}

- (id) createGridViewCell {
    FLAssertIsOverridden_v(nil);
    return nil;
}


@end
