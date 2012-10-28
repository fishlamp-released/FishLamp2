//
//	FLTableViewCellSectionWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/15/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"
#import "FLTableView.h"

typedef enum {
	FLTableViewCellSectionWidgetPositionInSectionNone,
	FLTableViewCellSectionWidgetPositionInSectionTop,
	FLTableViewCellSectionWidgetPositionInSectionMiddle,
	FLTableViewCellSectionWidgetPositionInSectionBottom,
	FLTableViewCellSectionWidgetPositionInSectionAll
} FLTableViewCellSectionWidgetPositionInSection;

typedef enum { 
	FLTableViewCellSectionDrawModeNone			= 0,
	FLTableViewCellSectionDrawModeFill			= (1 << 1),
	FLTableViewCellSectionDrawModeBorder		= (1 << 2),
	FLTableViewCellSectionDrawModeSection		= FLTableViewCellSectionDrawModeFill | FLTableViewCellSectionDrawModeBorder,
	FLTableViewCellSectionDrawModeSeperatorLine = (1 << 3),
	FLTableViewCellSectionDrawModeAll			= FLTableViewCellSectionDrawModeFill | FLTableViewCellSectionDrawModeBorder | FLTableViewCellSectionDrawModeSeperatorLine
} FLTableViewCellSectionDrawMode;

@interface FLTableViewCellSectionWidget : FLWidget {
@private
	UIColor* _fillColor;
	UIColor* _highlightedFillColor;
	UIColor* _highlightedBorderColor;
	CGFloat _fillAlpha;
	
	UIColor* _borderColor;
	CGFloat _borderAlpha;
	
	CGFloat _cornerRadius;
	CGFloat _borderLineWidth;

	struct {
		FLTableViewCellSectionWidgetPositionInSection positionInSection: 3;
		FLTableViewCellSeparatorLine separatorLine:2;
		FLTableViewCellSectionDrawMode drawMode: 4;
	} _bgFlags;

}

@property (readwrite, assign, nonatomic) FLTableViewCellSectionWidgetPositionInSection positionInSection;
@property (readwrite, assign, nonatomic) FLTableViewCellSeparatorLine separatorLine;

@property (readwrite, assign, nonatomic) CGFloat cornerRadius; 
@property (readwrite, assign, nonatomic) CGFloat borderLineWidth;

@property (readwrite, retain, nonatomic) UIColor* fillColor;
@property (readwrite, retain, nonatomic) UIColor* highlightedFillColor;
@property (readwrite, assign, nonatomic) CGFloat fillAlpha;

@property (readwrite, retain, nonatomic) UIColor* borderColor;
@property (readwrite, retain, nonatomic) UIColor* highlightedBorderColor;
@property (readwrite, assign, nonatomic) CGFloat borderAlpha;

@property (readwrite, assign, nonatomic) FLTableViewCellSectionDrawMode drawMode;

@end
