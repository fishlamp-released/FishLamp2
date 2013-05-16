//
//  GtBannerTableCell.m
//  MyZen
//
//  Created by Mike Fullerton on 1/10/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtBannerTableCell.h"

@implementation GtBannerTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
        m_label = [GtAlloc(UILabel) initWithFrame:CGRectZero];
        m_label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        m_label.backgroundColor = [UIColor clearColor];
        m_label.lineBreakMode = UILineBreakModeWordWrap;
        m_label.numberOfLines = 0;
        m_label.textColor = [UIColor blackColor];
        [self.contentView addSubview:m_label];
    
	}
	return self;
}

- (void) setRowData:(GtDisplayDataRow*) rowData isLoaded:(BOOL) isLoaded
{
	[super setRowData:rowData isLoaded:isLoaded];
	
    self.banner = rowData.label;
        
    [self setNeedsLayout];
}

- (NSString*) banner
{
    return m_label.text;
}

- (void) setBanner:(NSString*) banner
{
    m_label.text = banner;
}


- (CGRect) setFrame
{
    CGRect frame = self.contentView.bounds;
   
    frame = CGRectInset(frame, 10,10);
   
    frame.size = [m_label.text sizeWithFont:m_label.font
				constrainedToSize:CGSizeMake(frame.size.width, 1000)
				lineBreakMode:UILineBreakModeWordWrap];

	m_label.frame = frame;
    
    return frame;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
    [self setFrame];
}


- (void) dealloc
{   
    GtRelease(m_banner);
    GtRelease(m_label);
    
    [super dealloc];
}

- (CGFloat)  cellHeight
{
    return [self setFrame].size.height + 20;
}

@end
