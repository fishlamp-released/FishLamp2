//
//	GtTableViewCellSectionWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/15/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"
#import "GtTableView.h"

typedef enum {
	GtTableViewCellSectionWidgetPositionInSectionNone,
	GtTableViewCellSectionWidgetPositionInSectionTop,
	GtTableViewCellSectionWidgetPositionInSectionMiddle,
	GtTableViewCellSectionWidgetPositionInSectionBottom,
	GtTableViewCellSectionWidgetPositionInSectionAll
} GtTableViewCellSectionWidgetPositionInSection;

typedef enum { 
	GtTableViewCellSectionDrawModeNone			= 0,
	GtTableViewCellSectionDrawModeFill			= (1 << 1),
	GtTableViewCellSectionDrawModeBorder		= (1 << 2),
	GtTableViewCellSectionDrawModeSection		= GtTableViewCellSectionDrawModeFill | GtTableViewCellSectionDrawModeBorder,
	GtTableViewCellSectionDrawModeSeperatorLine = (1 << 3),
	GtTableViewCellSectionDrawModeAll			= GtTableViewCellSectionDrawModeFill | GtTableViewCellSectionDrawModeBorder | GtTableViewCellSectionDrawModeSeperatorLine
} GtTableViewCellSectionDrawMode;

@interface GtTableViewCellSectionWidget : GtWidget {
@private
	UIColor* m_fillColor;
	UIColor* m_highlightedFillColor;
	UIColor* m_highlightedBorderColor;
	CGFloat m_fillAlpha;
	
	UIColor* m_borderColor;
	CGFloat m_borderAlpha;
	
	CGFloat m_cornerRadius;
	CGFloat m_borderLineWidth;

	struct {
		GtTableViewCellSectionWidgetPositionInSection positionInSection: 3;
		GtTableViewCellSeparatorLine separatorLine:2;
		GtTableViewCellSectionDrawMode drawMode: 4;
	} m_bgFlags;

}

@property (readwrite, assign, nonatomic) GtTableViewCellSectionWidgetPositionInSection positionInSection;
@property (readwrite, assign, nonatomic) GtTableViewCellSeparatorLine separatorLine;

@property (readwrite, assign, nonatomic) CGFloat cornerRadius; 
@property (readwrite, assign, nonatomic) CGFloat borderLineWidth;

@property (readwrite, retain, nonatomic) UIColor* fillColor;
@property (readwrite, retain, nonatomic) UIColor* highlightedFillColor;
@property (readwrite, assign, nonatomic) CGFloat fillAlpha;

@property (readwrite, retain, nonatomic) UIColor* borderColor;
@property (readwrite, retain, nonatomic) UIColor* highlightedBorderColor;
@property (readwrite, assign, nonatomic) CGFloat borderAlpha;

@property (readwrite, assign, nonatomic) GtTableViewCellSectionDrawMode drawMode;

@end
