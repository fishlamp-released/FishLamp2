//
//	FLImageRowWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"

#define FLImageRowViewMaxImageCount 5

// Images are right justified and drawn right to left
// missing images in array are skipped and images to the missing images left
// are shift over to the right

@interface FLImageRowWidget : FLWidget {
@private
	UIImage* _images[FLImageRowViewMaxImageCount];

}

- (void) setImage:(UIImage*) image atIndex:(NSUInteger) index;
- (void) removeImageAtIndex:(NSUInteger) index;

- (void) clearImages;

@end
