//
//	FLImageRowView.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/21/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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