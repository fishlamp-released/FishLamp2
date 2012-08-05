//
//  FLActionContextWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLActionWidget.h"


@implementation FLActionWidget

@synthesize actionContext = _actionContext; 

- (FLAction*) action
{
	return _action.object;
}

- (void) setAction:(FLAction*) action
{
	_action.object = action;
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		_action = [[FLActionReference alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_action);
	FLRelease(_actionContext);
	FLSuperDealloc();
}
@end
