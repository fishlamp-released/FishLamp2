//
//  GtPhotoViewControllerViewArrangement.h
//  MyZen
//
//  Created by Mike Fullerton on 11/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtPhotoView.h"

#define _GT_ARRANGEMENT_SIZE 3

typedef enum
{	
	kPrevPhoto,
	kCurrentPhoto,
	kNextPhoto,
} WhichPhoto;

@interface GtPhotoViewControllerViewArrangement : NSObject {
	GtPhotoView* m_arrangement[_GT_ARRANGEMENT_SIZE]; // array. Use WhichPhoto as index
}

- (void) shiftArrangementToLeft;
- (void) shiftArrangementToRight;
- (void) clearPhotos;

- (NSUInteger) viewCount;

- (GtPhotoView*) previousView;
- (GtPhotoView*) nextView;
- (GtPhotoView*) centerView;

- (void) setView:(WhichPhoto) which view:(GtPhotoView*) view;
- (void) removeView:(WhichPhoto) which;

- (GtPhotoView*) viewAtIndex:(WhichPhoto) which;

@end