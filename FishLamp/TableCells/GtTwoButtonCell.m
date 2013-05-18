//
//  GtTwoButtonCell.m
//  MyZen
//
//  Created by Mike Fullerton on 12/19/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtTwoButtonCell.h"
#import "GtSimpleCallback.h"
#import "GtCustomButton.h"
#import "GtGeometry.h"

@implementation GtTwoButtonCell

@synthesize leftButton = m_leftButton;
@synthesize rightButton = m_rightButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
        self.hidden = YES;
        
		m_leftButton = [GtAlloc(GtCustomButton) initWithCustomColor:GtCustomButtonColorGray];
		m_rightButton = [GtAlloc(GtCustomButton) initWithCustomColor:GtCustomButtonColorGray];
    }
	return self;
}

- (void) setRowData:(GtDisplayDataRow*) rowData isLoaded:(BOOL) isLoaded
{
	[super setRowData:rowData isLoaded:isLoaded];
	m_leftButton.enabled = isLoaded;
	m_rightButton.enabled = isLoaded;
    
    [self setNeedsLayout];
}

#define BUFFER 0

- (void) layoutSubviews
{
	[super layoutSubviews];
	
    if(!m_leftButton.superview)
    {
        [self.superview addSubview:m_leftButton];
		[self.superview addSubview:m_rightButton];
	}
    
	CGRect originalFrame = CGRectInset(self.frame, 8, 0);
	// 10 px border
//    frame.origin.x = 10;
//    frame.size.width -= 20;

    CGRect buttonFrame = originalFrame;
    
    buttonFrame.size.width /= 2 ;
    buttonFrame.size.width -= BUFFER;
    
	m_leftButton.frame =  buttonFrame;
    buttonFrame.origin.x = buttonFrame.origin.x + buttonFrame.size.width + BUFFER*2 + 1;
    
    m_rightButton.frame = buttonFrame;
}

- (void)dealloc 
{
    [m_leftButton removeFromSuperview];
    [m_rightButton removeFromSuperview];

	GtRelease(m_leftButton);	
	GtRelease(m_rightButton);	
	[super dealloc];
}


@end
