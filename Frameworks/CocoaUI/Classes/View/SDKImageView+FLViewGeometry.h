//
//	SDKImageView+FLViewGeometry.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/17/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "SDKView+FLViewGeometry.h"

@interface SDKImageView (FLViewGeometryUtils)
// return YES is frame was changed.
- (BOOL) resizeToImageSize;
- (void) resizeProportionally:(CGSize) maxSize;
@end

