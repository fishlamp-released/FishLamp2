//
//	ThumbnailCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>
#import "GtActionAwareTableCell.h"

#define ThumbnailHeight 60

#define GtThumbnailBindingID @"THUMB"

@interface GtThumbnailCell : GtActionAwareTableCell {
@private;
	UIImageView* m_imageView;
	UIActivityIndicatorView* m_spinner;
}

@property (readonly, retain, nonatomic) UIImageView* thumbnailView;

- (void) clearThumbnail:(BOOL) startSpinner;
- (void) setThumbnail:(UIImage*) image;

- (void) startSpinner;
- (void) stopSpinner;
- (BOOL) spinnerIsAnimating;

- (CGRect) thumbFrame;

- (UIImage*) image;

@end

