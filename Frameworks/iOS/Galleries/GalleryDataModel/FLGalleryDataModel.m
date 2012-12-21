//
//  FLGalleryDataSource.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGalleryDataModel.h"

@implementation FLAction (FLGalleryDataModel)
- (id<FLGalleryObject>) loadGalleryResult {
    return FLAssertConformsToProtocol(self.result, FLGalleryObject);
}

- (NSArray*) loadChildrenResult {
    return FLAssertObjectIsType(self.result, NSArray);
}

- (UIImage*) loadImageResult {
    return FLAssertObjectIsType(self.result, UIImage);
}
@end
