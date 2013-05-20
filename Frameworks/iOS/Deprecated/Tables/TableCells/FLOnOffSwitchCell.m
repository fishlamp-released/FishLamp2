//
//	FLOnOffSwitchCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/26/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLOnOffSwitchCell.h"
#import "FLGeometry.h"


@implementation FLOnOffSwitchCell

@synthesize switchControl = _switch;
@synthesize switchChangedCallback = _callback;

- (void) updateDataSourceFromControl:(id) sender
{
	if(_doUpdateDataSource)
	{
		self.dataSourceObject = [NSNumber numberWithBool:_switch.isOn];

		FLInvokeCallback(_callback, self);
	}
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		_doUpdateDataSource = YES;
		
		_switch = [[UISwitch alloc] initWithFrame:CGRectZero];
		[self addSubview:_switch];
		[_switch addTarget:self action:@selector(updateDataSourceFromControl:) forControlEvents:UIControlEventValueChanged];
		
	}
	return self;
}

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
	self.cellHeight = DeviceIsPad() ? 60.0 : 50.0; // TODO: set this with theme.
}

+ (FLOnOffSwitchCell*) onOffSwitchTableViewCell:(NSString*) titleOrNil
{
	FLOnOffSwitchCell* cell = FLAutorelease([[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])]);
	if(FLStringIsNotEmpty(titleOrNil))
	{
		cell.textLabelText = titleOrNil;
	}
	return cell;
}

+ (FLOnOffSwitchCell*) onOffSwitchTableViewCell:(NSString*) title setOn:(BOOL) setOn target:(id) target action:(SEL) action
{
	FLOnOffSwitchCell* cell = [FLOnOffSwitchCell onOffSwitchTableViewCell:title];
	[cell.switchControl setOn:setOn];
	[cell setSwitchChangedCallback:FLCallbackMake(target,action)];
	
	return cell;
}

- (void)dealloc 
{
	FLRelease(_switch); 
	FLSuperDealloc();
}

- (void) updateControlFromDataSource:(BOOL) animated
{
	if(self.dataSource)
	{
		NSNumber* number = self.dataSourceObject;
		if(number)
		{
			BOOL isOn = [number boolValue];
			_doUpdateDataSource = YES;
			[_switch setOn:isOn animated:animated];
			_doUpdateDataSource = YES;
		}
	}
}

- (void) enabledStateDidChange
{
	_switch.enabled = self.canEditData;
	
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
	CGRect frame = FLRectJustifyRectInRectRight(layoutRect, _switch.frame);	
	frame = FLRectCenterRectInRectVertically(layoutRect, frame);
//	frame.origin.x -= 10;
	_switch.frameOptimizedForSize = frame;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
    [self _layoutSubviews];
}

- (BOOL) isOn
{
	return _switch.isOn;
}

- (void) setOn:(BOOL) isChecked
{
	[_switch setOn:isChecked animated:YES];
}

@end

@implementation FLLeftAlignedOnOffSwitchCell

- (void) _layoutSubviews
{
	CGRect layoutRect = self.layoutRect;
	self.switchControl.frameOptimizedForSize = FLRectCenterRectInRectVertically(layoutRect, FLRectSetLeft(self.switchControl.frame, layoutRect.origin.x));
    self.label.frameOptimizedForSize = FLRectCenterRectInRectVertically(layoutRect, FLRectSetLeft(self.label.frame, FLRectGetRight(self.switchControl.frame) + 10.0f));
}

@end
