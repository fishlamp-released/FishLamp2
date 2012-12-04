//
//	UIImageView+FLViewGeometry.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/17/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageView (FLViewGeometry)
// return YES is frame was changed.
- (BOOL) resizeToImageSize;
- (void) resizeProportionally:(FLSize) maxSize;
@end

