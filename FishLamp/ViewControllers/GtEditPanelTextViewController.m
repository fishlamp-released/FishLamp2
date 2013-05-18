//
//  GtEditPanelTextViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

#import "GtEditPanelTextViewController.h"
#import "GtEditableObjectView.h"
#import "GtDisplayFormatter.h"
#import "GtColors.h"


#define kRowHeight 20.0

#define kLeft 20.0
#define kTop 10.0
#define kWidthBuffer 40.0

@implementation GtEditPanelTextViewController

@synthesize editView = m_editView;
@synthesize textField = m_textField;

- (id) initWithDisplayDataRow:(GtDisplayDataRow*) row
{
	if(self = [self initWithDisplayDataRowAndRowCount:row rowCount:kDefaultRowCount])
	{
	}
	
	return self;
}

- (id) initWithDisplayDataRowAndRowCount:(GtDisplayDataRow*) row rowCount:(NSInteger) rowCount
{
	if(self = [super initWithDisplayDataRow:row])
	{
		m_rowCount = rowCount;
		
		if(rowCount > 1)
		{
			m_editView = [GtAlloc(UITextView) initWithFrame:CGRectZero];
			m_view = m_editView;
		}
		else
		{	
			m_textField = [GtAlloc(UITextField) initWithFrame:CGRectZero];
			m_view = m_textField;
		}
		
			
		UIFont* font = [UIFont systemFontOfSize:[UIFont systemFontSize] + 2.0];
		[m_view setFont:font];
		[m_view setText:[self.displayDataRow displayStringFromValue]];
		
		
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_editView);
	GtRelease(m_textField);
	GtRelease(m_headerView);
	[super dealloc];
}

- (CGFloat) height
{
	return kRowHeight * m_rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

	CGRect parentRect = self.view.frame;
	CGRect ourRect = CGRectMake(kLeft, kTop, parentRect.size.width - kWidthBuffer, [self height]);
	
	[m_view setFrame: ourRect];
	[cell addSubview:m_view];
	[m_view becomeFirstResponder];
		
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self height] + (kTop*2);
}

- (void) onSetNewValue
{
}

#define kHeaderHeight 20.0
#define kHeaderPadding 20.0

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if(self.displayDataRow.helpText)
	{
		CGRect frame = CGRectMake(kHeaderPadding,0, self.view.frame.size.width - (kHeaderPadding*2), kHeaderHeight);
		
		UILabel *label = [GtAlloc(UILabel) initWithFrame:frame];
		label.text = self.displayDataRow.helpText;
		//define other properties for the label - font, shadow, highlight, etc...
		
		label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		label.textColor = [UIColor blueLabelColor];
		label.backgroundColor = [UIColor clearColor];

		m_headerView = [GtAlloc(UIView) initWithFrame:CGRectMake(0,0,self.view.frame.size.width, kHeaderHeight)];
		m_headerView.backgroundColor = [UIColor clearColor];
		[m_headerView addSubview:label];
		GtRelease(label);
		
		return m_headerView;
	}

	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return self.displayDataRow.helpText != nil ? kHeaderHeight : 0;
}

- (id) onGetNewValue
{
	return [self.displayDataRow getDataFromStringDisplay:[m_view text]];
}

@end

@implementation GtSingleLineEditPanelTextViewController

- (id) initWithDisplayDataRow:(GtDisplayDataRow*) data
{
	return [super initWithDisplayDataRowAndRowCount:data rowCount:1];
}
@end

#endif