//
//  GtCheckMarkedTableCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/15/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtCheckMarkedTableCell.h"
#import "GtGeometry.h"
#import "GtColors.h"

@implementation GtCheckMarkedTableCell

@synthesize checked = m_checked;

- (void) dealloc
{
	GtRelease(m_subLabel);
	[super dealloc];
}

- (void) initSubLabel
{
	m_subLabel = [GtAlloc(UILabel) initWithFrame:CGRectZero];
	m_subLabel.font  = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
	m_subLabel.textColor = [UIColor grayColor];
	m_subLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:m_subLabel];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	RunOnlyOnSdkVersion3
	{
		if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
		{
			self.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
			self.textLabel.backgroundColor = [UIColor clearColor];
			[self initSubLabel];
		}
	}
#if FISHLAMP_IPHONE_2_SDK			
	RunOnlyOnSdkVersion2
	{
		if(self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier])
		{
			[self initSubLabel];
		}
	}
#endif
	
	return self;
}

- (void) setColor:(BOOL) toBlue
{
	RunOnlyOnSdkVersion3
	{
		self.textLabel.textColor = toBlue ? [UIColor blueLabelColor] : [UIColor blackColor];
	}
#if FISHLAMP_IPHONE_2_SDK			
	RunOnlyOnSdkVersion2
	{
	}
#endif
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

	if(selected && self.rowData)
	{
		self.rowData.data = self.rowData.cellData;
		self.checked = [self.rowData.data isEqualToValue:self.rowData.cellData];
	}
}


- (void) setRowData:(GtDisplayDataRow*) rowData isLoaded:(BOOL) isLoaded
{
	[super setRowData:rowData isLoaded:isLoaded];

	if(self.rowData)
	{
		self.checked = [self.rowData.data isEqualToValue:self.rowData.cellData];
	}
}

#define SUBLABEL_INDENT 40

- (void) layoutSubviews
{
	[super layoutSubviews];

	if(m_subLabel.text.length > 0)
	{
		CGRect subLabelFrame = self.frame;
		subLabelFrame.origin.x += SUBLABEL_INDENT;
		subLabelFrame.size.width -= SUBLABEL_INDENT;
		subLabelFrame.size.height = 18;
		subLabelFrame.origin.y = self.frame.size.height - subLabelFrame.size.height;
		
		m_subLabel.frame = subLabelFrame;
	
		CGRect textFrame = self.textLabel.frame;
		textFrame.origin.y -= 4;
		self.textLabel.frame = textFrame;
	}
	
	if(self.rowData)
	{
		if(self.rowData.label.length > 0)
		{
			self.displayText = self.rowData.label;
		}
	}
}

#define RIGHT_MARGIN_OFFSET_IN_GROUP 26

- (void) setChecked:(BOOL) checked
{
	m_checked = checked;
	if(checked)
	{
		self.accessoryType = UITableViewCellAccessoryCheckmark;
		[self setColor:YES];
	}
	else
	{
		self.accessoryType = UITableViewCellAccessoryNone;
		[self setColor:NO];
	}
}

- (NSString*) subText
{
	return m_subLabel.text;
}

- (void) setSubText:(NSString*) subText
{
	m_subLabel.text = subText;
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

@end

