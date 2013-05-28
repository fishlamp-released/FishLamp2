//
//	FLTableViewCellBackgroundView.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/25/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLRoundRectView.h"

typedef enum {
	FLTableViewCellBackgroundViewDrawModeTop,
	FLTableViewCellBackgroundViewDrawModeMiddle,
	FLTableViewCellBackgroundViewDrawModeBottom,
	FLTableViewCellBackgroundViewDrawModeAll
} FLTableViewCellBackgroundViewDrawMode;

typedef enum {
	FLTableViewCellBackgroundViewSeparatorLineNone,
	FLTableViewCellBackgroundViewSeparatorLineSingleLine
} FLTableViewCellBackgroundViewSeparatorLine;


@interface FLTableViewCellBackgroundView : FLRoundRectView {
@private
	struct {
		FLTableViewCellBackgroundViewDrawMode drawMode: 2;
		FLTableViewCellBackgroundViewSeparatorLine separatorLine:1;
		unsigned int drawDisclosureArrow: 1;
	} _bgFlags;
}

@property (readwrite, assign, nonatomic) BOOL drawDisclosureArrow;
@property (readwrite, assign, nonatomic) FLTableViewCellBackgroundViewDrawMode drawMode;
@property (readwrite, assign, nonatomic) FLTableViewCellBackgroundViewSeparatorLine separatorLine;

@end
