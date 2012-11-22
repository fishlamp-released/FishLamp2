//
//	ThumbnailCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/10/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLActionAwareTableCell.h"

#define ThumbnailHeight 60

#define FLThumbnailBindingID @"THUMB"

@interface FLThumbnailCell : FLActionAwareTableCell {
@private;
	UIImageView* _thumbnailImageView;
	UIActivityIndicatorView* _spinner;
}

@property (readonly, retain, nonatomic) UIImageView* thumbnailView;

- (void) clearThumbnail:(BOOL) startSpinner;
- (void) setThumbnail:(UIImage*) image;

- (void) startSpinner;
- (void) stopSpinner;
- (BOOL) spinnerIsAnimating;

- (FLRect) thumbFrame;

- (UIImage*) image;

@end

