//
//  GtAutoLayoutViewController.m
//  FishLamp2
//
//  Created by Mike Fullerton on 5/17/13.
//
//

#import "GtAutoLayoutViewController.h"

@implementation GtAutoLayoutViewController
@synthesize superviewContentsDescriptor = _superviewContentsDescriptor;

- (id) initWithView:(UIView*) view {
	self = [super initWithNibName:nil bundle:nil];
	if(self) {
		self.autoLayoutMode = GtRectLayoutMake(GtRectLayoutHorizontalCentered, GtRectLayoutVerticalCentered);
		_autoLayoutView = [view retain];
        self.autoLayout = YES;
        
        _autoLayoutView.viewDelegate = self;
	}
	return self;
}

+ (id) autoLayoutViewController:(UIView*) view {
    return [[[[self class] alloc] initWithView:view] autorelease];
}

- (void) loadView {
    self.view = _autoLayoutView;
}

#if FL_MRC
- (void) dealloc {
	[_autoLayoutView release];
	[super dealloc];
}
#endif

- (id) autoLayoutView {
    return self.view;
}

- (GtViewContentsDescriptor) viewGetSuperviewContentsDescriptor:(UIView*) view {
    return self.superviewContentsDescriptor;
}

@end

void GtViewDidLayoutSubviews(UIView* view)
{
//	if(!CGSizeEqualToSize(view.bounds.size, view.lastSuperviewSize))
//	{
//		view.lastSuperviewSize = view.bounds.size;
//		[view setSubviewPositions];
//	}	 
}

void GtViewDidMoveToSuperview(UIView* view)
{
//	if(view.superview)
//	{
//		GtViewSetPositionInSuperview(view);
//		[view setSubviewPositions];
//	}
}

void GtViewSetPositionInSuperview(UIView* view)
{
//	if(view.superview)
//	{
//		if(view.viewDelegate && !GtViewContentsDescriptorIsValid(view.superviewContentsDescriptor))
//		{
//		   view.superviewContentsDescriptor = [view.viewDelegate viewGetSuperviewContentsDescriptor:view];
//		}
//		if(GtViewContentsDescriptorIsValid(view.superviewContentsDescriptor))
//		{
//			[view setPositionInSuperviewWithRectLayout:view.autoLayoutMode superviewContents:view.superviewContentsDescriptor];
//		}
//		else
//		{
//			[view setPositionInSuperviewWithRectLayout:view.autoLayoutMode];
//		}
//	}
}