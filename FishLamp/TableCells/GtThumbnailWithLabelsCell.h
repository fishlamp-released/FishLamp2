//
//  PhotoDetailsThumbnailCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/11/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GtThumbnailCell.h"
#import "GtLabelAndValueView.h"

#define GtRowOneBindingID @"R1"
#define GtRowTwoBindingID @"R2"

@interface GtThumbnailWithLabelsCell : GtThumbnailCell {
	GtLabelAndValueView* m_row1;
	GtLabelAndValueView* m_row2;
}

- (void) updateTextRow1:(NSString*) label
	value:(NSString*) value;
	
- (void) updateTextRow2:(NSString*) label
	value:(NSString*) value;

- (CGFloat) cellHeight;

@end


