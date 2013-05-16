//
//  GtEditableData.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/8/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtEditableData.h"

@implementation GtEditableData

@synthesize originalData = m_originalData;
@synthesize editedData = m_editedData;

GtSynthesizeStructProperty(editState, setEditState,GtEditableDataState, m_flags);
GtSynthesizeStructProperty(editCopy, setEditCopy,BOOL, m_flags);

- (id) initWithOriginalData:(id) data
{
	if(self = [super init])
	{
		self.originalData = data;
	}
	
	return self;
}

- (id) initWithOriginalAndEditedData:(id) data  editedData:(id)editedData
{
	if(self = [super init])
	{
		self.originalData = data;
		self.editedData = editedData;
	}
	
	return self;}


+ (GtEditableData*) editableData:(id) data
{
	return [[GtAlloc(GtEditableData) initWithOriginalData:data] autorelease];
}

+ (GtEditableData*) editableData:(id) data withEditedData:(id)editedData
{
	return [[GtAlloc(GtEditableData) initWithOriginalAndEditedData:data editedData:editedData] autorelease];
}

- (void)dealloc 
{
	GtRelease(m_originalData);
	GtRelease(m_editedData);
	
    [super dealloc];
}

- (void) copyOriginalDataToEditedData
{
	self.editedData = nil;

	if([m_originalData conformsToProtocol:@protocol(NSMutableCopying)])
	{
		m_editedData = [m_originalData mutableCopy];
	}
	else if([m_originalData conformsToProtocol:@protocol(NSCopying)])
	{
		m_editedData = [m_originalData copy];
	}
	else
	{
		GtFail(@"Unable to copy data to be edited");
	}
}

- (void) beginEditing
{
	m_flags.editState = gtEditableDataCommitting;
}

- (BOOL) isEditing
{
	return m_flags.editState == gtEditableDataEditing;
}

- (void) setEditing
{
	m_flags.editState = gtEditableDataEditing;
}

- (void) beginCommitting
{
	m_flags.editState = gtEditableDataCommitting;
}

- (BOOL) isCommitting
{
	return m_flags.editState == gtEditableDataCommitting;
}

- (void) setCommitted
{
	m_flags.editState = gtEditableDataCommitted;
}

- (BOOL) committed
{
	return m_flags.editState == gtEditableDataCommitted;
}

- (void) setCommitFailed
{
	m_flags.editState = gtEditableDataCommitFailed;
}

- (BOOL) committFailed
{
	return m_flags.editState == gtEditableDataCommitFailed;
}

- (void) setEditingCancelled
{
	m_flags.editState = gtEditableDataEditCancelled;
}
- (BOOL) editingCancelled
{
	return m_flags.editState == gtEditableDataEditCancelled;
}



@end
