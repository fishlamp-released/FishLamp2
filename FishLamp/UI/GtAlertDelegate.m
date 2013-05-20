//
//  GtAlert.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/5/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

//#import <UIAlert.h>

#if IPHONE

#import "GtAlertDelegate.h"

@implementation GtAlertDelegate

- (id) initWithSelector:(NSObject*) object selector:(SEL) selector
{
	m_callback = [NSInvocation invocationWithMethodSignature:[[object class] instanceMethodSignatureForSelector:selector]];
	[m_callback setTarget:object];
	[m_callback setSelector:selector];
	[m_callback retain];
	return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
	[m_callback setArgument:&buttonIndex atIndex:2];
	[m_callback retainArguments];
	[m_callback invoke];
	[m_callback release];
	
	[self release];
}

- (void) dealloc
{
	[super dealloc];
}

@end

#endif