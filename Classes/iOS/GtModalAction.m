//
//	GtModalAction.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtModalAction.h"
#import "GtOldProgressView.h"

@implementation GtModalAction 

@synthesize operation = m_operation;

- (id) initWithProgressText:(NSString*) title
{
	if((self = [super init]))
	{
		m_operation = [[GtPerformSelectorOperation alloc] init];
		[self queueOperation:m_operation];
		self.progressView = [GtProgressViewController progressViewController:[GtOldProgressView defaultModalProgressView]];
		[self.progressView setTitle:title];
	}
	
	return self;
}

- (void) dealloc
{
	GtReleaseWithNil(m_operation);
	GtSuperDealloc();
}

@end