//
//  GtTableViewCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/29/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtTableViewCell.h"

@implementation GtTableViewCell

@synthesize isLoaded = m_isLoaded;

GtSynthesize(rowData, setRowData, GtDisplayDataRow, m_rowData);


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		m_isLoaded = YES;
	}
	
	return self;
}

- (void) dealloc
{
    GtRelease(m_rowData);
    [super dealloc];
}

- (void) setRowData:(GtDisplayDataRow*) rowData isLoaded:(BOOL) isLoaded
{
    self.rowData = rowData;
	m_isLoaded = isLoaded;
}

- (CGFloat) cellHeight
{
	return GT_DEFAULT_CELL_HEIGHT;
}


@end
