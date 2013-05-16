//
//  GtThumbnailButton.h
//  MyZen
//
//  Created by Mike Fullerton on 12/6/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtImageView.h"
#import "GtSimpleCallback.h"

@interface GtThumbnailButton : GtImageView {
	GtSimpleCallback* m_callback;
	id m_userData;

	UIView* m_centeredView;

// TODO: break these into seperate class
	CGRect m_originalFrame;
	NSArray* m_animationQueue;
	int m_currentAnimation;
	
	struct {
		unsigned int enabled:1;
	} m_buttonFlags;
}

@property (readwrite, assign, nonatomic) GtSimpleCallback* callback;
@property (readwrite, assign, nonatomic) id userData;
@property (readwrite, assign, nonatomic) BOOL enabled;

@property (readwrite, assign, nonatomic) UIView* centeredView;

- (void) addTarget:(id)target action:(SEL)action;

@end
