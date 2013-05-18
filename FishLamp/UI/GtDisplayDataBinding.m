//
//  GtDisplayDataBinding.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/19/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtDisplayDataBinding.h"

@implementation GtDisplayDataBinding

//@synthesize newValue = m_newValue;
@synthesize isCommitting = m_committing;
@synthesize dataId = m_dataId;
@synthesize isEditable = m_editable;
@synthesize dataContainer = m_dataContainer;

GtAssertDefaultInitNotCalled();

- (id) initWithDataContainer:(id<GtDataContainerProtocol>) container
{
	GtAssertNotNil(container);

	if(self = [super init])
	{
		m_dataContainer = [container retain];
		
		if([m_dataContainer respondsToSelector:@selector(key)])
		{
			self.dataId = [m_dataContainer performSelector:@selector(key)];
		}
		
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_previousValue);
	GtRelease(m_newValue);
	GtRelease(m_dataContainer);
	GtRelease(m_dataId);

	[super dealloc];
}

- (void) setObject:(id) data
{
	if(m_newValue != data)
	{
		[m_newValue release];
		m_newValue = [data retain];
	}
}

- (id) object
{
	GtAssertNotNil(m_dataContainer);

	if(m_newValue)
	{
		return [[m_newValue retain] autorelease];
	}

	return m_dataContainer.object; // already retaining/autoreleasing
}

- (void) revert
{
	GtAssert(!m_committing, @"can't revert in mid commit!");
	
	[m_newValue release];
	m_newValue = nil;
}

- (BOOL) isDirty
{
	return m_newValue != nil;
}

- (void) commit
{
	[self beginCommit];
	[self endCommit];
}

- (void) beginCommit
{
	GtAssert(!m_committing, @"already committing");

	m_committing = YES;

	if(m_newValue)
	{
		m_previousValue = [m_dataContainer.object retain];
		m_dataContainer.object = m_newValue;
	}
}

- (void) endCommit
{
	GtAssert(m_committing, @"not committing");

	if(m_newValue)
	{
		[m_previousValue release];
		m_previousValue = nil;
	
		[m_newValue release];
		m_newValue = nil;
	}
	
	m_committing = NO;
}

- (void) rollbackCommit
{
	GtAssert(m_committing, @"not committing");

	if(m_previousValue)
	{
		m_dataContainer.object = m_previousValue;
		[m_previousValue release];
		m_previousValue = nil;
	}
	else
	{
//		[m_object removeObjectForKey:m_key];
	}
	m_committing = false;
}



- (NSString*) description
{
	return [NSString stringWithFormat:@"GtDisplayDataBinding:\n id: %@\n newValue: %@\n dataContainer:\n%@", 
		m_dataId,
		m_newValue,
		[m_dataContainer description]];
}
@end
