//
//	GtTableViewCellBackgroundView.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/25/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtRoundRectView.h"

typedef enum {
	GtTableViewCellBackgroundViewDrawModeTop,
	GtTableViewCellBackgroundViewDrawModeMiddle,
	GtTableViewCellBackgroundViewDrawModeBottom,
	GtTableViewCellBackgroundViewDrawModeAll
} GtTableViewCellBackgroundViewDrawMode;

typedef enum {
	GtTableViewCellBackgroundViewSeparatorLineNone,
	GtTableViewCellBackgroundViewSeparatorLineSingleLine
} GtTableViewCellBackgroundViewSeparatorLine;


@interface GtTableViewCellBackgroundView : GtRoundRectView {
@private
	struct {
		GtTableViewCellBackgroundViewDrawMode drawMode: 2;
		GtTableViewCellBackgroundViewSeparatorLine separatorLine:1;
		unsigned int drawDisclosureArrow: 1;
	} m_bgFlags;
}

@property (readwrite, assign, nonatomic) BOOL drawDisclosureArrow;
@property (readwrite, assign, nonatomic) GtTableViewCellBackgroundViewDrawMode drawMode;
@property (readwrite, assign, nonatomic) GtTableViewCellBackgroundViewSeparatorLine separatorLine;

@end
