//
//  GtLabelAndValueBaseCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtLabelAndValueBaseCell.h"
#import "GtColors.h"
#import "GtGeometry.h"

@implementation GtLabelAndValueBaseCell

@synthesize label = m_label;
@synthesize value = m_value;

GtSynthesizeStructProperty(updateTextWithRowData, setUpdateTextWithRowData, BOOL, m_baseFlags);

- (void) createLabel
{
	m_label = [GtAlloc(UILabel) initWithFrame:CGRectZero];
	[self.contentView addSubview:m_label];
	
	m_label.font = [UIFont standardLabelFont];
	m_label.textColor = [UIColor standardLabelColor];
	m_label.backgroundColor = [UIColor clearColor];

}

- (void) createValue
{
	m_value = [GtAlloc(UILabel) initWithFrame:CGRectZero];
	[self.contentView addSubview:m_value];
	
	m_value.backgroundColor = [UIColor clearColor];
	m_value.font = [UIFont standardTextFieldFont];
	m_value.textColor = [UIColor standardTextFieldColor];
	m_value.lineBreakMode = UILineBreakModeTailTruncation; 
	m_value.textAlignment = UITextAlignmentLeft; 
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 	
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
        self.updateTextWithRowData = YES;
		[self createLabel];
		[self createValue];
	}
	
	return self;
}

- (NSString*) text
{
    return [m_value.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void) setText:(NSString*) text
{
    m_value.text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void) setRowData:(GtDisplayDataRow*) rowData isLoaded:(BOOL) isLoaded
{
    [super setRowData:rowData isLoaded:isLoaded];

	if(self.rowData)
	{
		if(self.rowData.label.length > 0)
        {
            m_label.text = self.rowData.label;
        }
        if(self.updateTextWithRowData)
        {
            self.text = [self.rowData displayStringFromValue];
        }
	}

	m_value.textColor = self.isLoaded ? 
		[UIColor standardTextFieldColor] : 
		[UIColor disabledControlColor];
}


- (void) dealloc
{
	GtRelease(m_label);
	GtRelease(m_value);
	[super dealloc];
}

@end



