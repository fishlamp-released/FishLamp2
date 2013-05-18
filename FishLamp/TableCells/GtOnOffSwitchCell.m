//
//  GtOnOffSwitchCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/26/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtOnOffSwitchCell.h"
#import "GtDisplayDataRow.h"
#import "GtGeometry.h"
#import "GtColors.h"

@implementation GtOnOffSwitchCell

- (void) updateControl:(id) sender
{
	self.rowData.data = [NSNumber numberWithBool:m_switch.isOn];
}

#if FISHLAMP_IPHONE_2_SDK
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
	{
		// calls initWithStyle
	}
	
    return self;
}
#endif

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		RunOnlyOnSdkVersion3
		{
			self.textLabel.font = [UIFont standardLabelFont];
			self.textLabel.textColor = [UIColor standardLabelColor];
			self.textLabel.backgroundColor = [UIColor clearColor];
		}
	
#if FISHLAMP_IPHONE_2_SDK			
		RunOnlyOnSdkVersion2
		{
		
		}
#endif

		m_switch = [GtAlloc(UISwitch) initWithFrame:CGRectZero];
		[self.contentView addSubview:m_switch];
		[m_switch addTarget:self action:@selector(updateControl:) forControlEvents:UIControlEventValueChanged];
	
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	GtRelease(m_switch);	
	[super dealloc];
}

- (void) updateValue:(BOOL) animated
{
	NSNumber* number = self.rowData.data;
	if(number)
	{
		[m_switch setOn:[number boolValue] animated:animated];
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	CGRect frame = GtRightJustifyRectInRect(self.contentView.bounds, m_switch.frame);	
	frame = GtCenterRectVerticallyInRect(self.contentView.bounds, frame);
	frame.origin.x -= 10;
	m_switch.frame = frame;
	
	if(self.rowData)
	{
		self.displayText = self.rowData.label;
		[self updateValue:NO];
	}
}

- (CGFloat) cellHeight
{
	return 50.0;
}

- (void) setLoading:(BOOL) loading
{
	m_switch.enabled = !loading;
}

- (NSString*) displayText
{
	RunOnlyOnSdkVersion3
	{
		return self.textLabel.text;
	}
#if FISHLAMP_IPHONE_2_SDK			
	RunOnlyOnSdkVersion2
	{
		return self.text;
	}
#endif
	return nil;
}

- (void) setDisplayText:(NSString *) text
{
	RunOnlyOnSdkVersion3
	{
		self.textLabel.text = text;
	}
#if FISHLAMP_IPHONE_2_SDK			
	RunOnlyOnSdkVersion2
	{
		self.text = text;
	}
#endif
}

- (BOOL) checked
{
	return m_switch.isOn;
}

- (void) setChecked:(BOOL) isChecked
{
	[m_switch setOn:isChecked animated:YES];
}




@end
