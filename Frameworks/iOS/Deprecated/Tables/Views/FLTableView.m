//
//	FLTableView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLTableView.h"
#import "UIColor+FLMoreColors.h"

#import "FLMultiColumnTableViewCell.h"

@implementation FLTableView

@synthesize sectionMargins = _sectionMargins;
@synthesize sectionPadding = _sectionPadding;
FLSynthesizeStructProperty(drawSectionBorders, setDrawSectionBorders, BOOL, _tableViewState);
FLSynthesizeStructProperty(cellSeparatorLine, setCellSeparatorLine, FLTableViewCellSeparatorLine, _tableViewState);

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

@implementation UITableViewCell (FLTableView)

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
