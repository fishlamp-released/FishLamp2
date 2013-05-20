//
//	FLThumbnailWithLoadingSpinnerView.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/9/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
