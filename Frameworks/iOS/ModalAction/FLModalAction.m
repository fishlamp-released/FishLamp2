//
//	FLModalAction.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
	FLReleaseWithNil(_operation);
	FLSuperDealloc();
}

@end