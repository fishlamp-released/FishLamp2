//
//  GtEditPanelTextViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtEditPanelTableController.h"
#import "GtDisplayDataBinding.h"

#define kDefaultRowCount 6

@interface GtEditPanelTextViewController : GtEditPanelTableController {
@private
	UITextView* m_editView;
	UITextField* m_textField;
	id m_view;
	UIView* m_headerView;
	
	NSInteger m_rowCount;
}

@property (readonly, assign, nonatomic) UITextView* editView;
@property (readonly, assign, nonatomic) UITextField* textField;

- (id) initWithDisplayDataRowAndRowCount:(GtDisplayDataRow*) data rowCount:(NSInteger) rowCount;

@end

@interface GtSingleLineEditPanelTextViewController : GtEditPanelTextViewController
{

}

@end