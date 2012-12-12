//
//	FLViewOwner.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLViewOwner.h"


@implementation FLViewOwner

@synthesize view = _view;

- (id) initWithView:(UIView*) view
{	
	if((self = [super init]))
	{
		self.view = view;
	}
	
	return self;
}

+ (FLViewOwner*) viewOwner:(UIView*) view
{
	return FLAutorelease([[FLViewOwner alloc] initWithView:view]);
}

- (void) dealloc
{
	[_view removeFromSuperview];
	FLReleaseWithNil(_view);
	super_dealloc_();
}

@end