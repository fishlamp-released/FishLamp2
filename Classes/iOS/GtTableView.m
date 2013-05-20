//
//	GtTableView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableView.h"
#import "UIColor+GtMoreColors.h"

#import "GtMultiColumnTableViewCell.h"

@implementation GtTableView

@synthesize sectionMargins = m_sectionMargins;
@synthesize sectionPadding = m_sectionPadding;
GtSynthesizeStructProperty(drawSectionBorders, setDrawSectionBorders, BOOL, m_tableViewState);
GtSynthesizeStructProperty(cellSeparatorLine, setCellSeparatorLine, GtTableViewCellSeparatorLine, m_tableViewState);

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
	if((self = [super initWithFrame:frame style:UITableViewStylePlain]))
	{
		self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
	
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self.separatorStyle = UITableViewCellSeparatorStyleNone;
	if((self = [super initWithCoder:aDecoder]))
	{
	}
	
	return self;
}

- (void) reloadData
{
	if(self.delegate && [self.delegate respondsToSelector:@selector(tableViewWillReloadData:)])
	{
		[self.delegate performSelector:@selector(tableViewWillReloadData:) withObject:self];
	}
	
	[super reloadData];
}


- (void) layoutSubviews
{
	[super layoutSubviews];

	if(self.delegate && [self.delegate respondsToSelector:@selector(tableViewDidLayoutSubviews:)])
	{
		[self.delegate performSelector:@selector(tableViewDidLayoutSubviews:) withObject:self];
	}
}

@end

@implementation UITableViewCell (GtTableView)

- (BOOL) tableViewDragSelectStartValueForPoint:(CGPoint) point
{
	return NO;
}

- (void) tableViewDragSelectSaveSelectedState
{
}

- (void) tableViewDragSelectRectChanged:(CGRect) dragRect startValue:(BOOL) startValue
{
}

@end
