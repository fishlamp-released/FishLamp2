//
//	ZFZfGroup+More.m
//	MyZen
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "ZFGroup+More.h"
#import "ZFUtils.h"
#import "FLCacheBehavior.h"

@implementation ZFGroup (More)

FLSynthesizeCachedObjectHandlerProperty(ZFGroup);

- (ZFGroupElement*) findByIdInternal:(NSUInteger) groupId
{
	if(groupId == self.IdValue)
	{
		return self;
	}
	
	if(self.Elements)
	{
		for(ZFGroupElement* element in self.Elements)
		{
			ZFGroupElement* value = nil; 
			
			if( element.IdValue == groupId)
			{
				value = element;
			}
			else if([element isKindOfClass:[ZFGroup class]])
			{
				value = [((ZFGroup*) element) findByIdInternal:groupId];
			}
			
			if(value)
			{
				return value;
			}
		}
	}
	
	return nil;
}

- (ZFGroupElement*) findById:(NSUInteger) groupId
{
	return [self findByIdInternal:groupId];
}

- (ZFGroupElement*) findByIdNumber:(NSNumber*) groupId
{
	return [self findById:[groupId unsignedIntegerValue]];
}

- (ZFGroup*) findParentForElement:(ZFGroupElement*) inElement group:(ZFGroup*) inGroup
{
	if(inGroup.Elements)
	{
		for(ZFGroupElement* element in inGroup.Elements)
		{
			if(element.IdValue == inElement.IdValue)
			{
				return inGroup;
			}
			
			if([element isKindOfClass:[ZFGroup class]])
			{
				ZFGroup* parentGroup = [self findParentForElement:inElement group:(ZFGroup*)element];
				if(parentGroup)
				{
					return parentGroup;
				}
			}
		
		}
	}
	
	return nil;
}

- (ZFGroup*) findParentForElement:(ZFGroupElement*) element
{
	return [self findParentForElement:element group:self];
}

+ (int) countPhotosRecursively:(ZFGroupElement*) groupElement value:(int*) value
{
	if([groupElement isKindOfClass:[ZFPhotoSet class]])
	{
		ZFPhotoSet* photoSet = (ZFPhotoSet*) groupElement;
	
		*value += photoSet.PhotoCountValue ? photoSet.PhotoCountValue : 0;
	}
	else
	{
		ZFGroup* group = (ZFGroup*) groupElement;
	
		for(ZFGroupElement* element in group.Elements)
		{
			[ZFGroup countPhotosRecursively:element value:value];
		}
	}
	
	return *value;
}

- (BOOL) replaceGroupElement:(ZFGroupElement*) replacingElement
{
	FLAssertIsNotNil_(self.Elements);

	if(self.Elements)
	{
		NSMutableArray* array = self.Elements;
		for(NSUInteger i = 0; i < array.count; i++)
		{
			ZFGroupElement* element = [array objectAtIndex:i];
		
			if(element.IdValue == replacingElement.IdValue)
			{
				[array replaceObjectAtIndex:i withObject:replacingElement];
				return YES;
			}
		}
	}
	
	return NO;
}

- (BOOL) replaceElement:(ZFGroupElement*) newElement parentId:(unsigned long) parentId
{
	ZFGroup* parent = (ZFGroup*) [self findById:parentId];
	if(parent)
	{
		return [parent replaceGroupElement:newElement];
	}
	
	return NO;
}

- (void) addParentToElement:(ZFGroupElement*) element newParent:(ZFGroup*) newParent
{
	if([element isKindOfClass:[ZFGroup class]])
	{
		ZFGroup* group = (ZFGroup*) element;
		
		if(!group.ParentGroups)
		{
			group.ParentGroups = [NSMutableArray array];
		}
		
		[group.ParentGroups addObject:newParent.Id];
	}
	else
	{
		ZFPhotoSet* photoSet = (ZFPhotoSet*) element;
		
		if(!photoSet.ParentGroups)
		{
			photoSet.ParentGroups = [NSMutableArray array];
		}
		
		[photoSet.ParentGroups addObject:newParent.Id];
	}
}

- (void) removeParentFromElement:(ZFGroupElement*) element parent:(ZFGroup*) parent
{
	NSMutableArray* array = nil;
	if([element isKindOfClass:[ZFGroup class]])
	{
		ZFGroup* group = (ZFGroup*) element;
		if(group.ParentGroups)
		{
			array = group.ParentGroups;
		}
	}
	else
	{
		ZFPhotoSet* photoSet = (ZFPhotoSet*) element;
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

- (void) addGroupElement:(ZFGroupElement*) element
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

- (void) addGroupElement:(ZFGroupElement*) element parentId:(unsigned long) parentId
{
	ZFGroup* parent = (ZFGroup*) [self findById:parentId];

	FLAssertIsNotNil_(parent);
	[parent addGroupElement:element];
}

- (void) removeGroupElement:(ZFGroupElement*) inElement
{
	BOOL foundIt = NO;
	FLAutoreleaseObject(FLRetain(inElement));
	NSMutableArray* array = self.Elements;
	for(NSUInteger i = 0; i < array.count; i++)
	{
		ZFGroupElement* subElement = [array objectAtIndex:i];
	
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

- (void) removeGroupElement:(ZFGroupElement*) removeThisElement parentId:(unsigned long) parentId
{
	ZFGroup* parent = (ZFGroup*) [self findById:parentId];

	FLAssertIsNotNil_(parent);

	[parent removeGroupElement:removeThisElement];
}

- (BOOL) isRootGroup
{
	return	!self.ParentGroups || self.ParentGroups.count == 0;
}

- (BOOL) hasDirectDecendent:(ZFGroupElement*) inElement
{
	for(ZFGroupElement* element in self.Elements)
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
    for(ZFGroupElement* element in self.elements) {
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
        for(ZFGroupElement* element in self.elements) {
            count += element.photoCount;
        }
        
        self.PhotoCount = [NSNumber numberWithUnsignedInteger:count];
    }
    
    return [super photoCount];
}


@end
