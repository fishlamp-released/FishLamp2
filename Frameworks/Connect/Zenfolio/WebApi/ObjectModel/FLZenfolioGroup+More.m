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
    
    for(FLZenfolioGroupElement* element in self.Elements) {
        FLZenfolioGroupElement* found = [element recursiveElementAtIndex:elementIndex counter:counter];
        if(found) {
            return found;
        }
    }
    
    return nil;
}


@end

@implementation FLZenfolioGroupElement (FLVisitor)
- (BOOL) visitAllElements:(FLGroupElementVisitor) visitor {
    BOOL stop = NO;
    visitor(self, &stop);
    if(stop) {
        return YES;
    }

    return NO;
}
@end

@implementation FLZenfolioGroup (More)

FLSynthesizeCachedObjectHandlerProperty(FLZenfolioGroup);


- (FLZenfolioGroupElementType) groupElementType {
    return FLZenfolioGroupElementTypeGroup; 
}

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

- (NSString*) pathToGroupElement:(FLZenfolioGroupElement*) element withDelimiter:(NSString*) delimiter {
    NSArray* components = [self pathComponentsToGroupElement:element];
    if(components && components.count) {
        NSMutableString* path = [NSMutableString stringWithString:[[components objectAtIndex:0] Title]];
        for(int i = 1; i < components.count; i++) {
            [path appendFormat:@"%@%@", delimiter, [[components objectAtIndex:i] Title]];
        }
        return path;
    }
    
    return nil;
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
	FLAssertIsNotNil(self.Elements);

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

	FLAssertIsNotNil(parent);
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
    FLAssertIsNotNil(parent);
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

//
//- (FLZenfolioGroupElement*) recursiveElementAtIndex:(NSInteger) index {
//    NSInteger counter = 0;
//    return [self recursiveElementAtIndex:index counter:&counter];
//}

//- (NSUInteger) GalleryCount {
//    __block int count = 0;
//    [self visitAllElements:^(FLZenfolioGroupElement* element, NSUInteger idx, BOOL* stop) {
//        if(!element.isGroupElement) {
//            ++count;
//        }
//    }];
//    
//    return count;
//}

- (BOOL) isGroupElement {
	return YES;
}

//- (BOOL) groupContainsFilter:(NSString*) filter {
//    if( TestElement(self, filter)) {
//        return YES;
//    }
//    
//    for(id element in self.Elements) {
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
//// this is a bit wierd, since we're dealign with a tree here.
//// this is a straighforward search through the heirarchy and obviously depends on sorts 
//// orders of the subElements
//- (id) recursiveElementAtIndex:(NSInteger) index;

//- (NSUInteger) elementCountWithFilter:(NSDictionary*) filter {
//    if(filter == nil) {
//        return [self.Elements count];
//    }
//
//    NSUInteger count = 0;
//    for(FLZenfolioGroupElement* element in self.Elements) {
//        if([filter objectForKey:element.Id]) {
//            ++count;
//        }
//    }
//    
//    return count;
//}

//- (FLZenfolioGroupElement*) elementAtIndex:(NSInteger) index withFilter:(NSDictionary*) filter {
//    if(filter == nil) {
//        return [self.Elements objectAtIndex:index];
//    }
//    
//    NSInteger idx = -1;
//    for(FLZenfolioGroupElement* element in self.Elements) {
//        if([filter objectForKey:element.Id]) {
//            idx++;
//        }
//        if(idx == index) {
//            return element;
//        }
//    }
//    return nil;
//}


- (BOOL) visitParentsForElement:(FLZenfolioGroupElement*) childElement visitor:(void (^)(FLZenfolioGroup* parent)) visitor {
    for(id element in self.Elements) {
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


//- (NSUInteger) elementCountWithFilter:(NSDictionary*) filter;
//- (FLZenfolioGroupElement*) elementAtIndex:(NSInteger) index withFilter:(NSDictionary*) filter;
//- (BOOL) findMatchesForFilter:(NSString*) filter results:(NSMutableDictionary*) results;
//
//
//- (void) addToResult:(NSMutableDictionary*) results {
//    [results setObject:self forKey:self.Id];
//    for(id element in self.Elements) {
//        if([element isGroupElement]) {
//            [element addToResult:results];
//        }
//        else {
//           [results setObject:element forKey:[element Id]];
//        }
//    }
//}
//
//#define TestElement(element,filter) ([[element Title] rangeOfString:filter options:NSCaseInsensitiveSearch].length > 0)
//
//- (BOOL) findMatchesForFilter:(NSString*) filter results:(NSMutableDictionary*) results {
//    BOOL foundMatch = NO;
//    if(FLStringIsEmpty(filter) || TestElement(self, filter)) {
//        [self addToResult:results];
//        foundMatch = YES;
//    }
//    else {
//        for(id element in self.Elements) {
//            if([element isGroupElement]) {
//                if([element findMatchesForFilter:filter results:results]) {
//                    foundMatch = YES;
//                }
//            }
//            else if(TestElement(element, filter)) {
//                [results setObject:element forKey:[element Id]];
//                foundMatch = YES;
//            }
//        }
//        if(foundMatch) {
//            [results setObject:self forKey:[self Id]];
//        }
//    }
//
//    return foundMatch;
//}

#if OSX
- (void) sort:(NSSortDescriptor*) descriptor {
    NSMutableArray* elements = self.Elements;
    
    id sortKey = descriptor.key;
    
    [elements sortUsingComparator:^NSComparisonResult (id lhs, id rhs) {
        [lhs sort:descriptor];
        [rhs sort:descriptor];
        id lhsValue = [lhs valueForKey:sortKey];
        id rhsValue = [rhs valueForKey:sortKey];

        if([lhsValue respondsToSelector:@selector(localizedCaseInsensitiveCompare:)]) {
        
            return descriptor.ascending ?   [lhsValue localizedCaseInsensitiveCompare:rhsValue]: 
                                            [rhsValue localizedCaseInsensitiveCompare:lhsValue];
        }
        return descriptor.ascending ? [lhsValue compare:rhsValue] : [rhsValue compare:lhsValue];
    }];
}
#endif

- (BOOL) visitAllElements:(FLGroupElementVisitor) visitor {
    BOOL stop = [super visitAllElements:visitor];
    if(stop) {
        return YES;
    }
    return [self visitAllSubElements:visitor];
}

- (BOOL) visitAllSubElements:(FLGroupElementVisitor) visitor {
    
    for(id element in self.Elements) {
        if([element visitAllElements:visitor] ) {
            return YES;
        }
    }
    
    return NO;
}


@end
