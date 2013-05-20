//
//	GtMultiColumnWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"

typedef enum {
	GtMultiColumnWidgetStyleDynamic, // evenly set the column width by size of self.frame / numVisibleColumns
	GtMultiColumnWidgetStyleLeftJustified,
	GtMultiColumnWidgetStyleRightJustified,
} GtMultiColumnWidgetStyle;

// this automatically lays out in columns
@interface GtMultiColumnWidget : GtWidget {
	NSUInteger m_visibleColumnCount;
	CGFloat m_columnWidth;
	GtMultiColumnWidgetStyle m_style;
	BOOL m_resizeColumns;
}

@property (readwrite, assign, nonatomic) BOOL resizeColumnsToFit;
@property (readwrite, assign, nonatomic) GtMultiColumnWidgetStyle style; // default is GtMultiColumnWidgetStyleDynamic
@property (readwrite, assign, nonatomic) CGFloat columnWidth; //ignored for dynamic style
@property (readwrite, assign, nonatomic) NSUInteger visibleColumnCount;
@end