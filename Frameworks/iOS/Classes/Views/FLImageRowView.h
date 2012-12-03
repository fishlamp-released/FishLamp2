//
//	FLImageRowView.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/21/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FLImageRowViewMaxImageCount 5

@interface FLImageRowView : UIView {
@private
	UIImage* _images[FLImageRowViewMaxImageCount];
}

- (void) setImage:(UIImage*) image atIndex:(NSUInteger) index;
- (void) addImage:(UIImage*) image;

- (void) clearImages;

@end