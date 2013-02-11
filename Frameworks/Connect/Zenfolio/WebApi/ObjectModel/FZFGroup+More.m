//
//	FLZenfolioZenfolioGroup+More.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZenfolioGroup+More.h"
#import "FLZenfolioUtils.h"
#import "FLCacheBehavior.h"

@implementation FLZenfolioGroup (More)

FLSynthesizeCachedObjectHandlerProperty(FLZenfolioGroup);

- (FLZenfolioGroupElement*) findByIdInternal:(NSUInteger) groupId
{
	if(groupId == self.IdValue)
	{
		return self;
	}
	
	if(self.Elements)
	{
		for(FLZenfolioGroupElement* element in self.Elements)
		{
			FLZenfolioGroupElement* value = nil; 
			
			if( element.IdValue == groupId)
			{
				value = element;
			}
			else if([element isKindOfClass:[FLZenfolioGroup class]])
			{
				value = [((FLZenfolioGroup*) element) findByIdInternal:groupId];
			}
			
			if(value)
			{
				return value;
			}
		}
	}
	
	return nil;
}

- (FLZenfolioGroupElement*) findById:(NSUInteger) groupId
{
	return [self findByIdInternal:groupId];
}

- (FLZenfolioGroupElement*) findByIdNumber:(NSNumber*) groupId
{
	return [self findById:[groupId unsignedIntegerValue]];
}

- (FLZenfolioGroup*) findParentForElement:(FLZenfolioGroupElement*) inElement group:(FLZenfolioGroup*) inGroup
{
	if(inGroup.Elements)
	{
		for(FLZenfolioGroupElement* element in inGroup.Elements)
		{
			if(element.IdValue == inElement.IdValue)
			{
				return inGroup;
			}
			
			if([element isKindOfClass:[FLZenfolioGroup class]])
			{
				FLZenfolioGroup* parentGroup = [self findParentForElement:inElement group:(FLZenfolioGroup*)element];
				if(parentGroup)
				{
					return parentGroup;
				}
			}
		
		}
	}
	
	return nil;
}

- (FLZenfolioGroup*) findParentForElement:(FLZenfolioGroupElement*) element
{
	return [self findParentForElement:element group:self];
}

+ (int) countPhotosRecursively:(FLZenfolioGroupElement*) groupElement value:(int*) value
{
	if([groupElement isKindOfClass:[FLZenfolioPhotoSet class]])
	{
		FLZenfolioPhotoSet* photoSet = (FLZenfolioPhotoSet*) groupElement;
	
		*value += photoSet.PhotoCountValue ? photoSet.PhotoCountValue : 0;
	}
	else
	{
		FLZenfolioGroup* group = (FLZenfolioGroup*) groupElement;
	
		for(FLZenfolioGroupElement* element in group.Elements)
		{
			[FLZenfolioGroup countPhotosRecursively:element value:value];
		}
	}
	
	return *value;
}

- (BOOL) replaceGroupElement:(FLZenfolioGroupElement*) replacingElement
{
	FLAssertIsNotNil_(self.Elements);

	if(self.Elements)
	{
		NSMutableArray* array = self.Elements;
		for(NSUInteger i = 0; i < array.count; i++)
		{
			FLZenfolioGroupElement* element = [array objectAtIndex:i];
		
			if(element.IdValue == replacingElement.IdValue)
			{
				[array replaceObjectAtIndex:i withObject:replacingElement];
				return YES;
			}
		}
	}
	
	return NO;
}

- (BOOL) replaceElement:(FLZenfolioGroupElement*) newElement parentId:(unsigned long) parentId
{
	FLZenfolioGroup* parent = (FLZenfolioGroup*) [self findById:parentId];
	if(parent)
	{
		return [parent replaceGroupElement:newElement];
	}
	
	return NO;
}

- (void) addParentToElement:(FLZenfolioGroupElement*) element newParent:(FLZenfolioGroup*) newParent
{
	if([element isKindOfClass:[FLZenfolioGroup class]])
	{
		FLZenfolioGroup* group = (FLZenfolioGroup*) element;
		
		if(!group.ParentGroups)
		{
			group.ParentGroups = [NSMutableArray array];
		}
		
		[group.ParentGroups addObject:newParent.Id];
	}
	else
	{
		FLZenfolioPhotoSet* photoSet = (FLZenfolioPhotoSet*) element;
		
		if(!photoSet.ParentGroups)
		{
			photoSet.ParentGroups = [NSMutableArray array];
		}
		
		[photoSet.ParentGroups addObject:newParent.Id];
	}
}

- (void) removeParentFromElement:(FLZenfolioGroupElement*) element parent:(FLZenfolioGroup*) parent
{
	NSMutableArray* array = nil;
	if([element isKindOfClass:[FLZenfolioGroup class]])
	{
		FLZenfolioGroup* group = (FLZenfolioGroup*) element;
		if(group.ParentGroups)
		{
			array = group.ParentGroups;
		}
	}
	else
	{
		FLZenfolioPhotoSet* photoSet = (FLZenfolioPhotoSet*) element;
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

- (void) addGroupElement:(FLZenfolioGroupElement*) element
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

- (void) addGroupElement:(FLZenfolioGroupElement*) element parentId:(unsigned long) parentId
{
	FLZenfolioGroup* parent = (FLZenfolioGroup*) [self findById:parentId];

	FLAssertIsNotNil_(parent);
	[parent addGroupElement:element];
}

- (void) removeGroupElement:(FLZenfolioGroupElement*) inElement
{
	BOOL foundIt = NO;
	FLAutoreleaseObject(FLRetain(inElement));
	NSMutableArray* array = self.Elements;
	for(NSUInteger i = 0; i < array.count; i++)
	{
		FLZenfolioGroupElement* subElement = [array objectAtIndex:i];
	
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

- (void) removeGroupElement:(FLZenfolioGroupElement*) removeThisElement parentId:(unsigned long) parentId
{
	FLZenfolioGroup* parent = (FLZenfolioGroup*) [self findById:parentId];

	FLAssertIsNotNil_(parent);

	[parent removeGroupElement:removeThisElement];
}

- (BOOL) isRootGroup
{
	return	!self.ParentGroups || self.ParentGroups.count == 0;
}

- (BOOL) hasDirectDecendent:(FLZenfolioGroupElement*) inElement
{
	for(FLZenfolioGroupElement* element in self.Elements)
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
//		case kZenfolioGroupType:
//			//	for groups return sum from contained entry sizes
//			return elem ? [[elem valueForKeyPath:@"@sum.photoBytes"] longLongValue] : 0;
//		case kZenfolioCollectionType:
//			//	for collections return the size of owned photos
//			return elem ? [[elem valueForKeyPath:@"@sum.size"] longLongValue] : 0;
//		default:
//			//	this is a gallery: return reported size
//			return _photoBytes;
//	}
    unsigned long long size = 0;
    for(FLZenfolioGroupElement* element in self.elements) {
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
        for(FLZenfolioGroupElement* element in self.elements) {
            count += element.photoCount;
        }
        
        self.PhotoCount = [NSNumber numberWithUnsignedInteger:count];
    }
    
    return [super photoCount];
}


@end
