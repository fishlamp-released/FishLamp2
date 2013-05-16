//
//  ThumbnailCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GtDisplayDataRow.h"
#import "GtActionAwareTableCell.h"

#define ThumbnailHeight 60

#define GtThumbnailBindingID @"THUMB"

@interface GtThumbnailCell : GtActionAwareTableCell {
@private;
	UIImageView* m_imageView;
	UIActivityIndicatorView* m_spinner;
}

@property (readonly, nonatomic, assign) UIImageView* thumbnailView;

- (void) clearThumbnail:(BOOL) startSpinner;
- (void) setThumbnail:(UIImage*) image;

- (void) startSpinner;
- (void) stopSpinner;
- (BOOL) spinnerIsAnimating;

- (CGRect) thumbFrame;

@end

