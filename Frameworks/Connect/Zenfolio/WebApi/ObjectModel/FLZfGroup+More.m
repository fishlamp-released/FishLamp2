//
//	FLZfZfGroup+More.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZfGroup+More.h"
#import "FLZfUtils.h"
#import "FLCacheBehavior.h"

@implementation FLZfGroup (More)

FLSynthesizeCachedObjectHandlerProperty(FLZfGroup);

- (FLZfGroupElement*) findByIdInternal:(NSUInteger) groupId
{
	if(groupId == self.IdValue)
	{
		return self;
	}
	
	if(self.Elements)
	{
		for(FLZfGroupElement* element in self.Elements)
		{
			FLZfGroupElement* value = nil; 
			
			if( element.IdValue == groupId)
			{
				value = element;
			}
			else if([element isKindOfClass:[FLZfGroup class]])
			{
				value = [((FLZfGroup*) element) findByIdInternal:groupId];
			}
			
			if(value)
			{
				return value;
			}
		}
	}
	
	return nil;
}

- (FLZfGroupElement*) findById:(NSUInteger) groupId
{
	return [self findByIdInternal:groupId];
}

- (FLZfGroupElement*) findByIdNumber:(NSNumber*) groupId
{
	return [self findById:[groupId unsignedIntegerValue]];
}

- (FLZfGroup*) findParentForElement:(FLZfGroupElement*) inElement group:(FLZfGroup*) inGroup
{
	if(inGroup.Elements)
	{
		for(FLZfGroupElement* element in inGroup.Elements)
		{
			if(element.IdValue == inElement.IdValue)
			{
				return inGroup;
			}
			
			if([element isKindOfClass:[FLZfGroup class]])
			{
				FLZfGroup* parentGroup = [self findParentForElement:inElement group:(FLZfGroup*)element];
				if(parentGroup)
				{
					return parentGroup;
				}
			}
		
		}
	}
	
	return nil;
}

- (FLZfGroup*) findParentForElement:(FLZfGroupElement*) element
{
	return [self findParentForElement:element group:self];
}

+ (int) countPhotosRecursively:(FLZfGroupElement*) groupElement value:(int*) value
{
	if([groupElement isKindOfClass:[FLZfPhotoSet class]])
	{
		FLZfPhotoSet* photoSet = (FLZfPhotoSet*) groupElement;
	
		*value += photoSet.PhotoCountValue ? photoSet.PhotoCountValue : 0;
	}
	else
	{
		FLZfGroup* group = (FLZfGroup*) groupElement;
	
		for(FLZfGroupElement* element in group.Elements)
		{
			[FLZfGroup countPhotosRecursively:element value:value];
		}
	}
	
	return *value;
}

- (BOOL) replaceGroupElement:(FLZfGroupElement*) replacingElement
{
	FLAssertIsNotNil_(self.Elements);

	if(self.Elements)
	{
		NSMutableArray* array = self.Elements;
		for(NSUInteger i = 0; i < array.count; i++)
		{
			FLZfGroupElement* element = [array objectAtIndex:i];
		
			if(element.IdValue == replacingElement.IdValue)
			{
				[array replaceObjectAtIndex:i withObject:replacingElement];
				return YES;
			}
		}
	}
	
	return NO;
}

- (BOOL) replaceElement:(FLZfGroupElement*) newElement parentId:(unsigned long) parentId
{
	FLZfGroup* parent = (FLZfGroup*) [self findById:parentId];
	if(parent)
	{
		return [parent replaceGroupElement:newElement];
	}
	
	return NO;
}

- (void) addParentToElement:(FLZfGroupElement*) element newParent:(FLZfGroup*) newParent
{
	if([element isKindOfClass:[FLZfGroup class]])
	{
		FLZfGroup* group = (FLZfGroup*) element;
		
		if(!group.ParentGroups)
		{
			group.ParentGroups = [NSMutableArray array];
		}
		
		[group.ParentGroups addObject:newParent.Id];
	}
	else
	{
		FLZfPhotoSet* photoSet = (FLZfPhotoSet*) element;
		
		if(!photoSet.ParentGroups)
		{
			photoSet.ParentGroups = [NSMutableArray array];
		}
		
		[photoSet.ParentGroups addObject:newParent.Id];
	}
}

- (void) removeParentFromElement:(FLZfGroupElement*) element parent:(FLZfGroup*) parent
{
	NSMutableArray* array = nil;
	if([element isKindOfClass:[FLZfGroup class]])
	{
		FLZfGroup* group = (FLZfGroup*) element;
		if(group.ParentGroups)
		{
			array = group.ParentGroups;
		}
	}
	else
	{
		FLZfPhotoSet* photoSet = (FLZfPhotoSet*) element;
		if(photoSet.ParentGroups)
		{
			array = photoSet.ParentGroups;
		}
	}
	
	for(NSUInteger i = 0; i < array.count; i++)
	{
		if([[array objectAtIndex:i] isEqualToValue:parent.Id])
		{
			[array removeObjectAtIndex:i];
			break;
		}
	}
}

- (void) addGroupElement:(FLZfGroupElement*) element
{
	if(!self.Elements)
	{
		self.Elements = [NSMutableArray array];
	}

	[self.Elements addObject:element];

	if([element isGroupElement])
	{
		self.SubGroupCountValue = self.SubGroupCountValue + 1;
	}
	else if([element isGalleryElement])
	{
		self.GalleryCountValue = self.GalleryCountValue + 1;
	}
	else
	{
		self.CollectionCountValue = self.CollectionCountValue + 1;
	}
	
	[self addParentToElement:element newParent:self];
}

- (void) addGroupElement:(FLZfGroupElement*) element parentId:(unsigned long) parentId
{
	FLZfGroup* parent = (FLZfGroup*) [self findById:parentId];

	FLAssertIsNotNil_(parent);
	[parent addGroupElement:element];
}

- (void) removeGroupElement:(FLZfGroupElement*) inElement
{
	BOOL foundIt = NO;
	FLAutoreleaseObject(FLRetain(inElement));
	NSMutableArray* array = self.Elements;
	for(NSUInteger i = 0; i < array.count; i++)
	{
		FLZfGroupElement* subElement = [array objectAtIndex:i];
	
		if(inElement.IdValue == subElement.IdValue)
		{
			[array removeObjectAtIndex:i];
			foundIt = YES;
			break;
		}
	}
	
	if(foundIt)
	{
		if([inElement isGroupElement])
		{
			self.SubGroupCountValue = self.SubGroupCountValue - 1;
		}
		else if([inElement isGalleryElement])
		{
			self.GalleryCountValue = self.GalleryCountValue -1;
		}
		else
		{
			self.CollectionCountValue = self.CollectionCountValue - 1;
		}
	
		[self removeParentFromElement:inElement parent:self];

	}
}

- (void) removeGroupElement:(FLZfGroupElement*) removeThisElement parentId:(unsigned long) parentId
{
	FLZfGroup* parent = (FLZfGroup*) [self findById:parentId];

	FLAssertIsNotNil_(parent);

	[parent removeGroupElement:removeThisElement];
}

- (BOOL) isRootGroup
{
	return	!self.ParentGroups || self.ParentGroups.count == 0;
}

- (BOOL) hasDirectDecendent:(FLZfGroupElement*) inElement
{
	for(FLZfGroupElement* element in self.Elements)
	{
		if(element.IdValue == inElement.IdValue)
		{
			return YES;
		}
	
	}

	return NO;
}

- (unsigned long long) photoBytes {

//	//	NOTE: we can't expect 0 for [nil longLongValue] on ppc
//	NSArray *elem = [self elements];
//	switch ( _type ) {
//		case kZFGroupType:
//			//	for groups return sum from contained entry sizes
//			return elem ? [[elem valueForKeyPath:@"@sum.photoBytes"] longLongValue] : 0;
//		case kZFCollectionType:
//			//	for collections return the size of owned photos
//			return elem ? [[elem valueForKeyPath:@"@sum.size"] longLongValue] : 0;
//		default:
//			//	this is a gallery: return reported size
//			return _photoBytes;
//	}
    unsigned long long size = 0;
    for(FLZfGroupElement* element in self.elements) {
        size += element.photoBytes;
    }
	return size;
}

- (int) videoCount {
	NSArray *elem = [self elements];
	return elem ? [[elem valueForKeyPath:@"@sum.videoCount"] longLongValue] : 0;
}

- (NSArray*) elements {
    return self.Elements;
}

- (int) photoCount {
    if(self.PhotoCount == nil) {
        NSUInteger count = 0;
        for(FLZfGroupElement* element in self.elements) {
            count += element.photoCount;
        }
        
        self.PhotoCount = [NSNumber numberWithUnsignedInteger:count];
    }
    
    return [super photoCount];
}


@end
