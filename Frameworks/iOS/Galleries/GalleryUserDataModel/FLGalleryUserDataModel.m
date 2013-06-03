//
//  FLGalleryUserDataModel.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGalleryUserDataModel.h"

@implementation FLAction (FLGalleryUserDataModel)
- (id<FLGalleryUser>) userResult {
    return FLAssertConformsToProtocol(self.result, FLGalleryUser);
}
@end