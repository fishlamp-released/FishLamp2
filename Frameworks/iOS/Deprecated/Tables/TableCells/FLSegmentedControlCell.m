//
//	FLSegmentedControlCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLSegmentedControlCell.h"


@implementation FLSegmentedControlCell

@synthesize segmentedControl = _control;

- (id) initWithSegmentedControlStyle:(UISegmentedControlStyle) style items:(NSArray*) items
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLSegmentedControlCell"]))
	{
		self.cellHeight = 40.0f;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.backgroundColor = [UIColor clearColor];
		self.sectionWidget.drawMode = FLTableViewCellSectionDrawModeNone;

		_control.backgroundColor = [UIColor clearColor];
		_control = [[UISegmentedControl alloc] initWithItems:items];
		_control.segmentedControlStyle = style;
		_control.tintColor = [UIColor darkGrayColor];
		
		[self addSubview:_control];
		
		if(_control.numberOfSegments)
		{
			_control.selectedSegmentIndex = 0;
		}
	}
	
	return self;
}

+ (FLSegmentedControlCell*) segmentedControlCell:(UISegmentedControlStyle) style items:(NSArray*) items
{
	return FLAutorelease([[FLSegmentedControlCell alloc] initWithSegmentedControlStyle:style items:items]);
}

- (void) dealloc
{
	FLRelease(_control);
	FLSuperDealloc();
}

- (void) enabledStateDidChange
{
	_control.enabled = self.canEditData;
	[super enabledStateDidChange];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	_control.frameOptimizedForSize = FLRectCenterRectInRect(self.bounds, FLRectSetSize(_control.frame, _control.numberOfSegments * 80, 40.0f));
}


@end
