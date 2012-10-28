//
//	FLTableView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLTableViewDelegate;

typedef enum {
	FLTableViewCellSeparatorLineNone,
	FLTableViewCellSeparatorLineSingleLine,
	FLTableViewCellSeparatorLineSingleLineEtched
} FLTableViewCellSeparatorLine;

@protocol FLTableViewRowHeightCalculator <NSObject>
- (CGFloat) calculateRowHeightInTableView:(UITableView*) tableView withData:(id) data;
@end

@interface FLTableView : UITableView {
@private
	UIEdgeInsets _sectionMargins;
	UIEdgeInsets _sectionPadding;
	struct { 
		unsigned int drawSectionBorders: 1;
		FLTableViewCellSeparatorLine cellSeparatorLine: 2;
	} _tableViewState;
}

@property (readwrite, assign, nonatomic) UIEdgeInsets sectionMargins;
@property (readwrite, assign, nonatomic) UIEdgeInsets sectionPadding;
@property (readwrite, assign, nonatomic) BOOL drawSectionBorders;
@property (readwrite, assign, nonatomic) FLTableViewCellSeparatorLine cellSeparatorLine;

@end

@protocol FLTableViewDelegate<NSObject, UIScrollViewDelegate>
@optional
- (void) tableViewWillReloadData:(UITableView*) tableView;
- (void) tableViewDidLayoutSubviews:(UITableView*) tableView;

- (void) tableView:(UITableView*) tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) tableView:(UITableView*) tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) tableView:(UITableView*) tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) tableView:(UITableView*) tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UITableViewCell (FLTableView)
- (BOOL) tableViewDragSelectStartValueForPoint:(FLPoint) point;	
- (void) tableViewDragSelectSaveSelectedState;
- (void) tableViewDragSelectRectChanged:(FLRect) dragRect startValue:(BOOL) startValue;
@end