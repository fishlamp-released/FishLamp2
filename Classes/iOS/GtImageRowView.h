//
//	GtImageRowView.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/21/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define GtImageRowViewMaxImageCount 5

@interface GtImageRowView : UIView {
@private
	UIImage* m_images[GtImageRowViewMaxImageCount];
}

- (void) setImage:(UIImage*) image atIndex:(NSUInteger) index;
- (void) addImage:(UIImage*) image;

- (void) clearImages;

@end