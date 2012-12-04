//
//	FLTableViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/1/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLScrollViewController.h"
#import "FLTableView.h"

@interface FLTableViewController : FLScrollViewController<
    UITableViewDataSource, 
	UITableViewDelegate, 
    FLTableViewDelegate> {
@private
	id<FLTableViewRowHeightCalculator> _rowHeightCalculator;
}

@property (readwrite, retain, nonatomic) IBOutlet FLTableView* tableView;

@property (readwrite, retain, nonatomic) id<FLTableViewRowHeightCalculator> rowHeightCalculator;

- (BOOL) isLastRow:(NSUInteger) row inSection:(NSInteger) inSection;
- (BOOL) isLastRow:(NSIndexPath *)indexPath;

- (id) dataForRowHeightCalculationAtIndexPath:(NSIndexPath*) path;

@end

