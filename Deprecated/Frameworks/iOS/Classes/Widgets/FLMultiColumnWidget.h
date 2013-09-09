//
//	FLMultiColumnWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"

typedef enum {
	FLMultiColumnWidgetStyleDynamic, // evenly set the column width by size of self.frame / numVisibleColumns
	FLMultiColumnWidgetStyleLeftJustified,
	FLMultiColumnWidgetStyleRightJustified,
} FLMultiColumnWidgetStyle;

// this automatically lays out in columns
@interface FLMultiColumnWidget : FLWidget {
	NSUInteger _visibleColumnCount;
	CGFloat _columnWidth;
	FLMultiColumnWidgetStyle _style;
	BOOL _resizeColumns;
}

@property (readwrite, assign, nonatomic) BOOL resizeColumnsToFit;
@property (readwrite, assign, nonatomic) FLMultiColumnWidgetStyle style; // default is FLMultiColumnWidgetStyleDynamic
@property (readwrite, assign, nonatomic) CGFloat columnWidth; //ignored for dynamic style
@property (readwrite, assign, nonatomic) NSUInteger visibleColumnCount;
@end