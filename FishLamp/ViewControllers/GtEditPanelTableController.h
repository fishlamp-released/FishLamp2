//
//  GtEditPanelTableController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GtEditPanel.h"
#import "GtTextEditCellManager.h"

@interface GtEditPanelTableController : GtEditPanel<
	UITableViewDataSource, 
	UITableViewDelegate,
	GtTextEditCellManagerDelegate> {
@private
	IBOutlet UITableView* m_tableView;
	GtTextEditCellManager* m_textEditCellManager;
}

- (id) initWithDisplayDataRowAndNibName:(GtDisplayDataRow*) row nibName:(NSString*) nibName;

@property (readonly, assign, nonatomic) UITableView* tableView;
@property (readonly, assign, nonatomic) GtTextEditCellManager* textEditCellManager;

@end
