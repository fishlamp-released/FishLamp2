//
//  GtTableViewController.m
//  seemeBaseball
//
//  Created by Mike Fullerton on 2/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GtTableViewController.h"

#import "GtAction.h"
#import "GtWindow.h"
#import "GtActionContextManager.h"

@implementation GtTableViewController

@synthesize actionContext = m_context;

- (void) handleShake:(id) sender
{
	if(m_context.isActive)
	{
		[self onDeviceWasShaken];
	}
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		m_context = [GtAlloc(GtManagedActionContext) initAndActivate:YES];
        m_context.delegate = self; 
		
		[[NSNotificationCenter defaultCenter] addObserver:self
						selector:@selector(handleShake:)
						name:GtDeviceWasShakenNotification 
						object:[UIApplication sharedApplication]];
	}
	
	return self;
}

- (void) dealloc
{
#if DEBUG
	GtTrace(GtTraceActionContextChanges, @"dealloc: %@", NSStringFromClass([self class]));
#endif
	[[NSNotificationCenter defaultCenter] removeObserver:self];
		
	GtRelease(m_context);
	[super dealloc];
}

- (void) onDeviceWasShaken
{
	GtLog(@"Got shake event: %@", NSStringFromClass([self class]));
}

- (void) actionContextActivated:(GtActionContext*) context
{
#if DEBUG
	GtTrace(GtTraceActionContextChanges, @"actionContextActivated: %@", NSStringFromClass([self class]));
#endif
	[self didBecomeActiveContext];
}

- (void) actionContextDeactivated:(GtActionContext*) context
{
	[self didBecomeInactiveContext];
}

- (void) actionContextWasCancelled:(GtActionContext*) context 
	actionsCancelled:(NSArray*) actionsCancelled
	       wasTerminated:(BOOL) wasTerminated
{
#if DEBUG
	GtTrace(GtTraceActionContextChanges, @"actionContextWasCancelled: %@", NSStringFromClass([self class]));
#endif
	[self onActionsCancelled:actionsCancelled  
                   wasTerminated:wasTerminated];
}

- (void) didBecomeActiveContext
{
}

- (void) didBecomeInactiveContext
{
}

- (void) onActionsCancelled:(NSArray*) actions 
                  wasTerminated:(BOOL) wasTerminated
{
}

@end
