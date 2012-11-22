//
//	FLThumbnailWithLoadingSpinnerView.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/9/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ThumbnailHeight 60

@interface FLThumbnailWithLoadingSpinnerView : UIImageView {
	UIActivityIndicatorView* _spinner;
}

- (void) clearThumbnail:(BOOL) startSpinner;

- (void) startSpinner;
- (void) stopSpinner;
- (BOOL) spinnerIsAnimating;

@end
