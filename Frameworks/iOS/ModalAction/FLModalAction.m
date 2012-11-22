//
//	FLModalAction.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLModalAction.h"
#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"

@implementation FLModalAction 

@synthesize operation = _operation;

- (id) initWithProgressText:(NSString*) title
{
	if((self = [super init]))
	{
		_operation = [[FLPerformSelectorOperation alloc] init];
		[self addOperation:_operation];
        self.progressController = [FLProgressViewController progressViewController:[FLSimpleProgressView class] presentationBehavior:[FLModalPresentationBehavior instance]];
        self.progressController.title = title;
	}
	
	return self;
}

- (void) dealloc
{
	FLReleaseWithNil_(_operation);
	super_dealloc_();
}

@end