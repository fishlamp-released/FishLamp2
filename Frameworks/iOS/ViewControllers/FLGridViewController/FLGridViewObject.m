//
//  FLGridViewObject.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGridViewObject.h"

@implementation NSObject (FLGridViewObject)

- (id) dataRefKey {
    FLAssertIsOverriddenWithComment(nil);
    return nil;
}

- (NSString*) gridViewDisplayName {
    FLAssertIsOverriddenWithComment(nil);
    return nil;
}

- (id) createGridViewCell {
    FLAssertIsOverriddenWithComment(nil);
    return nil;
}


@end
