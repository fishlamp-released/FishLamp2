//
//	FLZenfolioZenfolioGroup+More.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZenfolioGroup+More.h"

#import "FLCacheBehavior.h"

@implementation FLZenfolioGroupElement (Index)

- (FLZenfolioGroupElement*) recursiveElementAtIndex:(NSInteger) elementIndex counter:(NSInteger*) counter {
    if(elementIndex == (*counter)++) {
        return self;
    }
    
    for(FLZenfolioGroupElement* element in self.elements) {
        FLZenfolioGroupElement* found = [element recursiveElementAtIndex:elementIndex counter:counter];
        if(found) {
            return found;
        }
    }
    
    return nil;
}


@end


@implementation FLZenfolioGroup (More)

FLSynthesizeCachedObjectHandlerProperty(FLZenfolioGroup);

- (FLZenfolioGroupElement*) findByIdInternal:(NSUInteger) groupId 
                                        path:(NSMutableArray*) path {
	if(groupId == self.IdValue) {
		return self;
	}
	
	if(self.Elements) {
		for(FLZenfolioGroupElement* element in self.Elements) {
			FLZenfolioGroupElement* value = nil; 
			
			if( element.IdValue == groupId) {
				value = element;
                [path addObject:element];
			}
			else if([element isGroupElement]){
				value = [((FLZenfolioGroup*) element) findByIdInternal:groupId path:path];
                
                if(path.count) {
                    [path insertObject:element atIndex:0];
                }
			}
			
			if(value) {
				return value;
			}
		}
	}
	
	return nil;
}

- (NSArray*) pathComponentsToGroupElement:(FLZenfolioGroupElement*) element {
    NSMutableArray* path = [NSMutableArray array];
    [self findByIdInternal:element.IdValue path:path];
    if(path.count) {
        [path insertObject:self atIndex:0];
    }
    return path;
}

- (FLZenfolioGroupElement*) findById:(NSUInteger) groupId {
	return [self findByIdInternal:groupId path:nil];
}

- (FLZenfolioGroupElement*) findByIdNumber:(NSNumber*) groupId {
	return [self findById:[groupId unsignedIntegerValue]];
}

- (FLZenfolioGroup*) findParentForElement:(FLZenfolioGroupElement*) inElement 
                                    group:(FLZenfolioGroup*) inGroup {

	if(inGroup.Elements) {
		for(FLZenfolioGroupElement* element in inGroup.Elements) {
			if(element.IdValue == inElement.IdValue) {
				return inGroup;
			}
			
			if([element isGroupElement]) {
				FLZenfolioGroup* parentGroup = [self findParentForElement:inElement group:(FLZenfolioGroup*)element];
				if(parentGroup) {
					return parentGroup;
				}
			}
		}
	}
	
	return nil;
}

- (FLZenfolioGroup*) findParentForElement:(FLZenfolioGroupElement*) element {
	return [self findParentForElement:element group:self];
}

+ (int) countPhotosRecursively:(FLZenfolioGroupElement*) groupElement value:(int*) value {
	if([groupElement isKindOfClass:[FLZenfolioPhotoSet class]]) {
		FLZenfolioPhotoSet* photoSet = (FLZenfolioPhotoSet*) groupElement;
		*value += photoSet.PhotoCountValue ? photoSet.PhotoCountValue : 0;
	}
	else {
		FLZenfolioGroup* group = (FLZenfolioGroup*) groupElement;
	
		for(FLZenfolioGroupElement* element in group.Elements) {
			[FLZenfolioGroup countPhotosRecursively:element value:value];
		}
	}
	
	return *value;
}

- (BOOL) replaceGroupElement:(FLZenfolioGroupElement*) replacingElement {
	FLAssertIsNotNil_(self.Elements);

    FLZenfolioGroup* parent = [self findParentForElement:replacingElement];

	NSMutableArray* array = parent.Elements;
    if(array) {
        for(NSUInteger i = 0; i < array.count; i++) {
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

- (BOOL) replaceElement:(FLZenfolioGroupElement*) newElement parentId:(unsigned long) parentId {
	FLZenfolioGroup* parent = (FLZenfolioGroup*) [self findById:parentId];
	if(parent) {
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

- (void) addGroupElement:(FLZenfolioGroupElement*) element parentId:(unsigned long) parentId {
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

- (void) removeGroupElement:(FLZenfolioGroupElement*) removeThisElement parentId:(unsigned long) parentId {
	FLZenfolioGroup* parent = (FLZenfolioGroup*) [self findById:parentId];
    FLAssertIsNotNil_(parent);
    [parent removeGroupElement:removeThisElement];
}

- (BOOL) isRootGroup {
	return	!self.ParentGroups || self.ParentGroups.count == 0;
}

- (BOOL) hasDirectDecendent:(FLZenfolioGroupElement*) inElement {
	for(FLZenfolioGroupElement* element in self.Elements){
		if(element.IdValue == inElement.IdValue){
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

- (NSUInteger) videoCount {

//    NSInteger videoCount = 0;
//    for(FLZenfolioGroupElement* element in self.elements) {
//        videoCount  += [element videoCount];
//    }
//	return videoCount;

    return [self VideoCountValue];
}

- (NSArray*) elements {
    return self.Elements;
}

- (NSUInteger) photoCount {
//    if(self.PhotoCount == nil) {
//        NSUInteger count = 0;
//        for(FLZenfolioGroupElement* element in self.elements) {
//            count += element.photoCount;
//        }
//        
//        self.PhotoCount = [NSNumber numberWithUnsignedInteger:count];
//    }
//    
//    return [super photoCount];
    
    return [self PhotoCountValue];
}


- (FLZenfolioGroupElement*) recursiveElementAtIndex:(NSInteger) index {
    NSInteger counter = 0;
    return [self recursiveElementAtIndex:index counter:&counter];
}

- (NSUInteger) galleryCount {
    __block int count = 0;
    [self visitAllElements:^(FLZenfolioGroupElement* element, NSUInteger idx, BOOL* stop) {
        if(!element.isGroupElement) {
            ++count;
        }
    }];
    
    return count;
}

- (BOOL) isGroupElement {
	return YES;
}

//- (BOOL) groupContainsFilter:(NSString*) filter {
//    if( TestElement(self, filter)) {
//        return YES;
//    }
//    
//    for(id element in self.elements) {
//        if([element isGroupElement]) {
//            if([element groupContainsFilter:filter]) {
//                return YES;
//            }
//        }
//        else 
//        if([element titleMatchesFilter:filter]) {
//            return YES;
//        }
//    }
//    return NO;
//}

- (NSUInteger) elementCountWithFilter:(NSDictionary*) filter {
    if(filter == nil) {
        return [self.elements count];
    }

    NSUInteger count = 0;
    for(FLZenfolioGroupElement* element in self.elements) {
        if([filter objectForKey:element.Id]) {
            ++count;
        }
    }
    
    return count;
}

- (FLZenfolioGroupElement*) elementAtIndex:(NSInteger) index withFilter:(NSDictionary*) filter {
    if(filter == nil) {
        return [self.elements objectAtIndex:index];
    }
    
    NSInteger idx = -1;
    for(FLZenfolioGroupElement* element in self.elements) {
        if([filter objectForKey:element.Id]) {
            idx++;
        }
        if(idx == index) {
            return element;
        }
    }
    return nil;
}


- (BOOL) visitParentsForElement:(FLZenfolioGroupElement*) childElement visitor:(void (^)(FLZenfolioGroup* parent)) visitor {
    for(id element in self.elements) {
        if([element IdValue] == childElement.IdValue) {
            visitor(self);
            return YES;
        }
        if([element isGroupElement] && [element visitParentsForElement:childElement visitor:visitor]) {
            return YES;
        }
    }
    
    return NO;
}

//- (BOOL) visitParentsForElement:(FLZenfolioGroupElement*) element visitor:(void (^)(FLZenfolioGroup* parent)) visitor {
//    BOOL foundChild = NO;
//    [element visitParentsForElement:childElement visitor:visitor foundChild:foundChild];
//
//}

- (void) addToResult:(NSMutableDictionary*) results {
    [results setObject:self forKey:self.Id];
    for(id element in self.elements) {
        if([element isGroupElement]) {
            [element addToResult:results];
        }
        else {
           [results setObject:element forKey:[element Id]];
        }
    }
}

#define TestElement(element,filter) ([[element Title] rangeOfString:filter options:NSCaseInsensitiveSearch].length > 0)

- (BOOL) findMatchesForFilter:(NSString*) filter results:(NSMutableDictionary*) results {
    BOOL foundMatch = NO;
    if(FLStringIsEmpty(filter) || TestElement(self, filter)) {
        [self addToResult:results];
        foundMatch = YES;
    }
    else {
        for(id element in self.elements) {
            if([element isGroupElement]) {
                if([element findMatchesForFilter:filter results:results]) {
                    foundMatch = YES;
                }
            }
            else if(TestElement(element, filter)) {
                [results setObject:element forKey:[element Id]];
                foundMatch = YES;
            }
        }
        if(foundMatch) {
            [results setObject:self forKey:[self Id]];
        }
    }

    return foundMatch;
}


@end
