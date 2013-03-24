//
//	ZFZenfolioGroup+More.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "ZFGroup+More.h"

#import "FLCacheBehavior.h"

@implementation ZFGroupElement (Index)

- (ZFGroupElement*) recursiveElementAtIndex:(NSInteger) elementIndex counter:(NSInteger*) counter {
    if(elementIndex == (*counter)++) {
        return self;
    }
    
    for(ZFGroupElement* element in self.Elements) {
        ZFGroupElement* found = [element recursiveElementAtIndex:elementIndex counter:counter];
        if(found) {
            return found;
        }
    }
    
    return nil;
}


@end

@implementation ZFGroupElement (FLVisitor)
- (BOOL) visitAllElements:(FLGroupElementVisitor) visitor {
    BOOL stop = NO;
    visitor(self, &stop);
    if(stop) {
        return YES;
    }

    return NO;
}
@end

@implementation ZFGroup (More)

FLSynthesizeCachedObjectHandlerProperty(ZFGroup);


- (ZFGroupElementType) groupElementType {
    return ZFGroupElementTypeGroup; 
}

- (ZFGroupElement*) findByIdInternal:(NSUInteger) groupId 
                                        path:(NSMutableArray*) path {
	if(groupId == self.IdValue) {
		return self;
	}
	
	if(self.Elements) {
		for(ZFGroupElement* element in self.Elements) {
			ZFGroupElement* value = nil; 
			
			if( element.IdValue == groupId) {
				value = element;
                [path addObject:element];
			}
			else if([element isGroupElement]){
				value = [((ZFGroup*) element) findByIdInternal:groupId path:path];
                
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

- (NSArray*) pathComponentsToGroupElement:(ZFGroupElement*) element {
    NSMutableArray* path = [NSMutableArray array];
    [self findByIdInternal:element.IdValue path:path];
    if(path.count) {
        [path insertObject:self atIndex:0];
    }
    return path;
}

- (NSString*) pathToGroupElement:(ZFGroupElement*) element withDelimiter:(NSString*) delimiter {
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

- (ZFGroupElement*) findById:(NSUInteger) groupId {
	return [self findByIdInternal:groupId path:nil];
}

- (ZFGroupElement*) findByIdNumber:(NSNumber*) groupId {
	return [self findById:[groupId unsignedIntegerValue]];
}

- (ZFGroup*) findParentForElement:(ZFGroupElement*) inElement 
                                    group:(ZFGroup*) inGroup {

	if(inGroup.Elements) {
		for(ZFGroupElement* element in inGroup.Elements) {
			if(element.IdValue == inElement.IdValue) {
				return inGroup;
			}
			
			if([element isGroupElement]) {
				ZFGroup* parentGroup = [self findParentForElement:inElement group:(ZFGroup*)element];
				if(parentGroup) {
					return parentGroup;
				}
			}
		}
	}
	
	return nil;
}

- (ZFGroup*) findParentForElement:(ZFGroupElement*) element {
	return [self findParentForElement:element group:self];
}

+ (int) countPhotosRecursively:(ZFGroupElement*) groupElement value:(int*) value {
	if([groupElement isKindOfClass:[ZFPhotoSet class]]) {
		ZFPhotoSet* photoSet = (ZFPhotoSet*) groupElement;
		*value += photoSet.PhotoCountValue ? photoSet.PhotoCountValue : 0;
	}
	else {
		ZFGroup* group = (ZFGroup*) groupElement;
	
		for(ZFGroupElement* element in group.Elements) {
			[ZFGroup countPhotosRecursively:element value:value];
		}
	}
	
	return *value;
}

- (BOOL) replaceGroupElement:(ZFGroupElement*) replacingElement {
	FLAssertIsNotNil(self.Elements);

    ZFGroup* parent = [self findParentForElement:replacingElement];

	NSMutableArray* array = parent.Elements;
    if(array) {
        for(NSUInteger i = 0; i < array.count; i++) {
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

- (BOOL) replaceElement:(ZFGroupElement*) newElement parentId:(unsigned long) parentId {
	ZFGroup* parent = (ZFGroup*) [self findById:parentId];
	if(parent) {
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

- (void) addGroupElement:(ZFGroupElement*) element parentId:(unsigned long) parentId {
	ZFGroup* parent = (ZFGroup*) [self findById:parentId];

	FLAssertIsNotNil(parent);
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

- (void) removeGroupElement:(ZFGroupElement*) removeThisElement parentId:(unsigned long) parentId {
	ZFGroup* parent = (ZFGroup*) [self findById:parentId];
    FLAssertIsNotNil(parent);
    [parent removeGroupElement:removeThisElement];
}

- (BOOL) isRootGroup {
	return	!self.ParentGroups || self.ParentGroups.count == 0;
}

- (BOOL) hasDirectDecendent:(ZFGroupElement*) inElement {
	for(ZFGroupElement* element in self.Elements){
		if(element.IdValue == inElement.IdValue){
			return YES;
		}
	}

	return NO;
}

//
//- (ZFGroupElement*) recursiveElementAtIndex:(NSInteger) index {
//    NSInteger counter = 0;
//    return [self recursiveElementAtIndex:index counter:&counter];
//}

//- (NSUInteger) GalleryCount {
//    __block int count = 0;
//    [self visitAllElements:^(ZFGroupElement* element, NSUInteger idx, BOOL* stop) {
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
//    for(ZFGroupElement* element in self.Elements) {
//        if([filter objectForKey:element.Id]) {
//            ++count;
//        }
//    }
//    
//    return count;
//}

//- (ZFGroupElement*) elementAtIndex:(NSInteger) index withFilter:(NSDictionary*) filter {
//    if(filter == nil) {
//        return [self.Elements objectAtIndex:index];
//    }
//    
//    NSInteger idx = -1;
//    for(ZFGroupElement* element in self.Elements) {
//        if([filter objectForKey:element.Id]) {
//            idx++;
//        }
//        if(idx == index) {
//            return element;
//        }
//    }
//    return nil;
//}


- (BOOL) visitParentsForElement:(ZFGroupElement*) childElement visitor:(void (^)(ZFGroup* parent)) visitor {
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
//- (ZFGroupElement*) elementAtIndex:(NSInteger) index withFilter:(NSDictionary*) filter;
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
