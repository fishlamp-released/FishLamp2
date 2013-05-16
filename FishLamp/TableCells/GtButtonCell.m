//
//  GtButtonCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/28/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtButtonCell.h"
#import "GtSimpleCallback.h"

@implementation GtButtonCell

@synthesize button = m_button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
        self.hidden = YES;

		m_button = [GtAlloc(GtCustomButton) initWithCustomColor:GtCustomButtonColorGray];
//        [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		[m_button retain];
	
//		[m_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  //      [m_button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
	
	}
	return self;
}

- (void) setRowData:(GtDisplayDataRow*) rowData isLoaded:(BOOL) isLoaded
{
	[super setRowData:rowData isLoaded:isLoaded];
	m_button.enabled = isLoaded;
    
    if(self.rowData)
	{
		[m_button setTitle:self.rowData.label forState:UIControlStateNormal];
		
		GtSimpleCallback* cb = self.rowData.cellData;
		
		[m_button addTarget:cb.target action:cb.action forControlEvents:UIControlEventTouchUpInside];
	}
    
    [self setNeedsLayout];
    
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
    if(!m_button.superview)
    {
        [self.superview addSubview:m_button];
	}
    
	m_button.frame = CGRectInset(self.frame, 8, 0);
}

- (void)dealloc 
{
    [m_button removeFromSuperview];

	GtRelease(m_button);	
	[super dealloc];
}

@end
