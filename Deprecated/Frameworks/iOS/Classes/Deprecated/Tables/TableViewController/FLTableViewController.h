//
//	FLTableViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/1/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

