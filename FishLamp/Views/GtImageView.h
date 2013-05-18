//
//  GtImageView.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/5/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GtImageView : UIImageView<NSCoding> {
@private
	struct {
		unsigned int isLandscapeImage:1;
		unsigned int orientation:3;
		unsigned int autoRotateImage:1;
        unsigned int imageOrientation:3;
		unsigned int hasImage:1;
	} m_flags;
}

- (void) rotateToOrientation:(UIDeviceOrientation) orientation 
	animate:(BOOL) animate;

@property (readwrite, assign, nonatomic) BOOL autoRotateImage;

@property (readwrite, assign, nonatomic) UIDeviceOrientation orientation;
@property (readwrite, assign, nonatomic) UIImageOrientation imageOrientation;

@property (readonly, assign, nonatomic) BOOL hasImage;

- (void) rotateImageToOrientation:(UIImageOrientation) orientation;
- (void) rotateImage:(BOOL) clockwise;
- (void) flipImage;

+ (UIDeviceOrientation) lastLandscapeOrientation;
+ (void) setLastLandscapeOrientation:(UIDeviceOrientation) last;

@end
