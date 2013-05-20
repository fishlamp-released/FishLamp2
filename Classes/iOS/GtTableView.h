//
//	GtTableView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol GtTableViewDelegate;

typedef enum {
	GtTableViewCellSeparatorLineNone,
	GtTableViewCellSeparatorLineSingleLine,
	GtTableViewCellSeparatorLineSingleLineEtched
} GtTableViewCellSeparatorLine;

@protocol GtTableViewRowHeightCalculator <NSObject>
- (CGFloat) calculateRowHeightInTableView:(UITableView*) tableView withData:(id) data;
@end

@interface GtTableView : UITableView {
@private
	UIEdgeInsets m_sectionMargins;
	UIEdgeInsets m_sectionPadding;
	struct { 
		unsigned int drawSectionBorders: 1;
		GtTableViewCellSeparatorLine cellSeparatorLine: 2;
	} m_tableViewState;
}

@property (readwrite, assign, nonatomic) UIEdgeInsets sectionMargins;
@property (readwrite, assign, nonatomic) UIEdgeInsets sectionPadding;
@property (readwrite, assign, nonatomic) BOOL drawSectionBorders;
@property (readwrite, assign, nonatomic) GtTableViewCellSeparatorLine cellSeparatorLine;

@end

@protocol GtTableViewDelegate<NSObject, UIScrollViewDelegate>
@optional
- (void) tableViewWillReloadData:(UITableView*) tableView;
- (void) tableViewDidLayoutSubviews:(UITableView*) tableView;

- (void) tableView:(UITableView*) tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) tableView:(UITableView*) tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) tableView:(UITableView*) tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) tableView:(UITableView*) tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UITableViewCell (GtTableView)
- (BOOL) tableViewDragSelectStartValueForPoint:(CGPoint) point;	
- (void) tableViewDragSelectSaveSelectedState;
- (void) tableViewDragSelectRectChanged:(CGRect) dragRect startValue:(BOOL) startValue;
@end