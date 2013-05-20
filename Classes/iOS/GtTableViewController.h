//
//	GtTableViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/1/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtScrollViewController.h"
#import "GtTableView.h"

@interface GtTableViewController : GtScrollViewController<
    UITableViewDataSource, 
	UITableViewDelegate, 
    GtTableViewDelegate> {
@private
	id<GtTableViewRowHeightCalculator> m_rowHeightCalculator;
    GtTableView* m_tableView;
}

@property (readwrite, retain, nonatomic) GtTableView* tableView;

@property (readwrite, retain, nonatomic) id<GtTableViewRowHeightCalculator> rowHeightCalculator;

- (BOOL) isLastRow:(NSUInteger) row inSection:(NSInteger) inSection;
- (BOOL) isLastRow:(NSIndexPath *)indexPath;

- (id) dataForRowHeightCalculationAtIndexPath:(NSIndexPath*) path;

@end

