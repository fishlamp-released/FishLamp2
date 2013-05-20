//
//	GtOnOffSwitchCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/26/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOnOffSwitchCell.h"
#import "GtGeometry.h"


@implementation GtOnOffSwitchCell

@synthesize switchControl = m_switch;
@synthesize switchChangedCallback = m_callback;

- (void) updateDataSourceFromControl:(id) sender
{
	if(m_doUpdateDataSource)
	{
		self.dataSourceObject = [NSNumber numberWithBool:m_switch.isOn];

		GtInvokeCallback(m_callback, self);
	}
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		m_doUpdateDataSource = YES;
		
		m_switch = [[UISwitch alloc] initWithFrame:CGRectZero];
		[self addSubview:m_switch];
		[m_switch addTarget:self action:@selector(updateDataSourceFromControl:) forControlEvents:UIControlEventValueChanged];
		
	}
	return self;
}

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
	self.cellHeight = DeviceIsPad() ? 60.0 : 50.0; // TODO: set this with theme.
}

+ (GtOnOffSwitchCell*) onOffSwitchTableViewCell:(NSString*) titleOrNil
{
	GtOnOffSwitchCell* cell = GtReturnAutoreleased([[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])]);
	if(GtStringIsNotEmpty(titleOrNil))
	{
		cell.textLabelText = titleOrNil;
	}
	return cell;
}

+ (GtOnOffSwitchCell*) onOffSwitchTableViewCell:(NSString*) title setOn:(BOOL) setOn target:(id) target action:(SEL) action
{
	GtOnOffSwitchCell* cell = [GtOnOffSwitchCell onOffSwitchTableViewCell:title];
	[cell.switchControl setOn:setOn];
	[cell setSwitchChangedCallback:GtCallbackMake(target,action)];
	
	return cell;
}

- (void)dealloc 
{
	GtRelease(m_switch); 
	GtSuperDealloc();
}

- (void) updateControlFromDataSource:(BOOL) animated
{
	if(self.dataSource)
	{
		NSNumber* number = self.dataSourceObject;
		if(number)
		{
			BOOL isOn = [number boolValue];
			m_doUpdateDataSource = YES;
			[m_switch setOn:isOn animated:animated];
			m_doUpdateDataSource = YES;
		}
	}
}

- (void) enabledStateDidChange
{
	m_switch.enabled = self.canEditData;
	
	[super enabledStateDidChange];
}

- (void) updateCellState
{
	[super updateCellState];
	[self updateControlFromDataSource:NO];
}

- (void) _layoutSubviews
{
	CGRect layoutRect = self.layoutRect;
	CGRect frame = GtRectJustifyRectInRectRight(layoutRect, m_switch.frame);	
	frame = GtRectCenterRectInRectVertically(layoutRect, frame);
//	frame.origin.x -= 10;
	m_switch.frameOptimizedForSize = frame;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
    [self _layoutSubviews];
}

- (BOOL) isOn
{
	return m_switch.isOn;
}

- (void) setOn:(BOOL) isChecked
{
	[m_switch setOn:isChecked animated:YES];
}

@end

@implementation GtLeftAlignedOnOffSwitchCell

- (void) _layoutSubviews
{
	CGRect layoutRect = self.layoutRect;
	self.switchControl.frameOptimizedForSize = GtRectCenterRectInRectVertically(layoutRect, GtRectSetLeft(self.switchControl.frame, layoutRect.origin.x));
    self.label.frameOptimizedForSize = GtRectCenterRectInRectVertically(layoutRect, GtRectSetLeft(self.label.frame, GtRectGetRight(self.switchControl.frame) + 10.0f));
}

@end
