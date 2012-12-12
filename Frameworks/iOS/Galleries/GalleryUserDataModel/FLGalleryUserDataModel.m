//
//  FLGalleryUserDataModel.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLGalleryUserDataModel.h"

@implementation FLAction (FLGalleryUserDataModel)
- (id<FLGalleryUser>) userResult {
    return FLAssertConformsToProtocol(self.result, FLGalleryUser);
}
@end