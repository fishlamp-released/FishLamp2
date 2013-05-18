//
//  GtOnOffSwitchCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/26/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtSliderValueCell.h"
#import "GtDisplayDataRow.h"
#import "GtGeometry.h"
#import "GtColors.h"

@implementation GtSliderValueCell

@synthesize slider = m_slider;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		RunOnlyOnSdkVersion3
		{
		}
		
#if FISHLAMP_IPHONE_2_SDK			
		RunOnlyOnSdkVersion2
		{
		}
#endif
        self.updateTextWithRowData = NO;

		m_slider = [GtAlloc(UISlider) initWithFrame:CGRectZero];
		[m_slider addTarget:self action:@selector(updateControl:) forControlEvents:UIControlEventValueChanged];
        
        [self.contentView addSubview:m_slider];
		
	}
	
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc 
{
	GtRelease(m_slider);
	[super dealloc];
}

- (void) updateValue:(BOOL) animated
{
	NSNumber* number = self.rowData.data;
	if(number)
	{
		[m_slider setValue:[number floatValue]];
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	CGRect superBounds = m_slider.superview.bounds;
	
	CGRect frame = superBounds;
	
	frame.size.height = 30;
	frame = CGRectInset(frame, 10, 0);
//	frame = GtCenterRectHorizontallyInRect(superBounds, frame);	
	frame.origin.y = superBounds.size.height - frame.size.height - 6;
	m_slider.frame = frame;
	
	[m_slider.superview bringSubviewToFront:m_slider];
	
	if(self.rowData)
	{
		[self updateValue:NO];
	}
}

- (void) setValueText
{
	self.text = [NSString stringWithFormat:@"%.0f seconds", m_slider.value]; // TODO: USE THE FORMATTER
}

- (CGFloat) cellHeight
{
	return 60.0;
}

- (void) setRowData:(GtDisplayDataRow*) rowData isLoaded:(BOOL) isLoaded
{
	[super setRowData:rowData isLoaded:isLoaded];

    [self setValueText];

	m_slider.enabled = isLoaded;
	
	if(isLoaded)
	{
		[self updateValue:YES];
	}
}

- (void) updateControl:(id) sender
{
    [self setValueText];
	
	self.rowData.data = [NSNumber numberWithFloat:m_slider.value];
}

- (void) prepareForReuse
{	
// anything to do here?		
	[super prepareForReuse];
}




@end
