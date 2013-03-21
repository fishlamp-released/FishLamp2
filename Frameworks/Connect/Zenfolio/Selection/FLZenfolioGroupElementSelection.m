//
//  FLZenfolioGroupElementSelection.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioGroupElementSelection.h"
#import "FLOrderedCollection.h"

//@protocol FLZenfolioGroupElementSelection <NSObject> 
//- (void) addElementToSelection:(FLZenfolioGroupElement*) element forIndex:(NSUInteger) index;
//@end
//
//
//@implementation FLZenfolioPhoto (Selection)
//- (void) addSelectionsToIndexedSet:(NSMutableIndexSet*) set 
//                     fromSelection:(FLZenfolioGroupElementSelection*) selection 
//                     currentIndex:(NSUInteger*) currentIndex {
//}
//@end
//
//
//@implementation FLZenfolioGroupElement (Selection)
//
//- (void) addSelectionsToIndexedSet:(NSMutableIndexSet*) set 
//                     fromSelection:(FLZenfolioGroupElementSelection*) selection
//             withCollapsedElements:(NSDictionary*) collapsedGroups 
//                     currentIndex:(NSUInteger*) currentIndex {
//    
//    if([selection isGroupElementSelected:self]) {
//        [set addIndex:*currentIndex];
//    }
//    
//    ++(*currentIndex);
//    
//    for(FLZenfolioGroupElement* element in self.Elements) {
//        [element addSelectionsToIndexedSet:set fromSelection:selection currentIndex:currentIndex];
//    }
//}     
//
//@end
//
//@implementation FLZenfolioGroup (Selection) 
//
//- (NSIndexSet*) indexSetForSelection:(FLZenfolioGroupElementSelection*) selection withCollapsedElements:(NSDictionary*) collapsedGroups{
//    NSMutableIndexSet* set = [NSMutableIndexSet indexSet];
//    NSUInteger index = 0;
//    [self addSelectionsToIndexedSet:set fromSelection:selection currentIndex:&index];
//    return set;
//}
//
//- (void) addGroup:(FLZenfolioGroup*) group 
//       toIndexSet:(NSMutableIndexSet*) indexSet 
//       withIndex:(NSUInteger*) index {
//    
//}
//
//@end

@interface FLZenfolioGroupElementSelection()
@property (readwrite, strong, nonatomic) NSArray* selectedPhotoSets;
@property (readwrite, strong, nonatomic) NSString* filterString;
@property (readwrite, strong, nonatomic) NSMutableSet* filtered;
@property (readwrite, strong, nonatomic) NSArray* displayList;
@property (readwrite, strong, nonatomic) FLOrderedCollection* elements;
//@property (readwrite, strong, nonatomic) FLZenfolioGroup* rootGroup;

@property (readwrite, strong, nonatomic) NSMutableSet* expanded;
@property (readwrite, strong, nonatomic) NSMutableSet* selected;
@property (readwrite, strong, nonatomic) NSMutableIndexSet* cachedIndexSet;

@property (readwrite, strong, nonatomic) id<FLObjectStorage> objectStorage;

- (BOOL) elementInFilter:(id) element;
@end

@implementation FLZenfolioGroupElementSelection 

@synthesize expanded = _expanded;
@synthesize filtered = _filtered;
@synthesize filterString = _filterString;
@synthesize selectedPhotoSets = _selectedPhotoSets;
@synthesize rootGroup = _rootGroup;
@synthesize delegate = _delegate;
@synthesize displayList = _displayList;
@synthesize elements = _elements;
@synthesize selected = _selected;
@synthesize cachedIndexSet = _cachedSelectionSet;
@synthesize objectStorage = _objectStorage;

- (id) initWithObjectStorage:(id<FLObjectStorage>) objectStorage {
    self = [super init];
    if(self) {
        self.objectStorage = objectStorage;
    }
    return self;
}
+ (id) groupElementSelection:(id<FLObjectStorage>) objectStorage {
    return FLAutorelease([[[self class] alloc] initWithObjectStorage:objectStorage]);
}

#if FL_MRC
- (void) dealloc {
    [_cachedSelectionSet release];
    [_elements release];
    [_filtered release];
    [_filterString release];
    [_expanded release];
    [_rootGroup release];
    [_selected release];
    [_selectedPhotoSets release];
    [super dealloc];
}
#endif

+ (id) groupElementSelection {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) clearCachedSearchData {
    self.selectedPhotoSets = nil;
    self.displayList = nil;
    self.cachedIndexSet = nil;
}

#pragma mark - Element list

- (void) updateElementDictionary:(FLOrderedCollection*) dictionary 
                       withGroup:(FLZenfolioGroup*) group {

    [dictionary setObject:group forKey:[group Id]];
    for(id subElement in [group Elements]) {
        if([subElement isGroupElement]) {
            [self updateElementDictionary:dictionary withGroup:(FLZenfolioGroup *)subElement];
        }
        else  {
            [dictionary setObject:subElement forKey:[subElement Id]];
        }
    }
}

- (FLOrderedCollection*) elements {
    if(!_elements) {
        _elements = [[FLOrderedCollection alloc] init];
        [self updateElementDictionary:_elements withGroup:self.rootGroup];
    }
    return _elements;
}

- (NSUInteger) indexOfElement:(id) element {
    return [self.elements indexForKey:[element Id]];
}

- (id) elementForID:(NSNumber*) idObject {
    return idObject != nil ? [self.elements objectForKey:idObject] : nil;
}

- (void) replaceGroupElement:(id) element { 
    [self.objectStorage writeObject:element];
    [self.elements replaceObjectAtIndex:[self.elements indexForKey:[element Id]] withObject:element forKey:[element Id]];

//    if(row < _displayList.count) {
//        FLAssert([[_displayList objectAtIndex:row] IdValue] == [element IdValue]);
//        [_displayList replaceObjectAtIndex:row withObject:element];
//    }
}

- (id) childElementForGroup:(FLZenfolioGroup*) parent atIndex:(NSUInteger) index {

    if(self.filtered == nil) {
        return [self elementForID:[[[parent Elements] objectAtIndex:index] Id]];
    }
    
    NSInteger idx = -1;
    for(FLZenfolioGroupElement* element in parent.Elements) {
        if([self.filtered containsObject:[element Id]]) {
            idx++;
        }
        if(idx == index) {
            return [self elementForID:[element Id]];
        }
    }
    return nil;
}

- (NSUInteger) childCountForGroup:(FLZenfolioGroup*) group {

    if(self.filtered == nil) {
        return [group.Elements count];
    }

    NSUInteger count = 0;
    for(id element in group.Elements) {
        if([self.filtered containsObject:[element Id]]) {
            ++count;
        }
    }
    
    return count;    
}

#pragma mark - Display List
//
//- (BOOL) showInDisplayList:(id) element {
//    return [self isGroupElementSelected:element] && ; 
//}

- (void) updateDisplayList:(NSMutableArray*) list 
                 withGroup:(FLZenfolioGroup*) group {
    
    if( [self elementInFilter:group] ) {
        [list addObject:[group Id]];
    
        if( [self elementIsExpanded:group]) {
            for(id subElement in [group Elements]) {
                if([subElement isGroupElement]) {
                    [self updateDisplayList:list withGroup:(FLZenfolioGroup *)subElement];
                }
                else if([self elementInFilter:subElement]) {
                    [list addObject:[subElement Id]];
                }
            }
        }
    }
}

- (NSArray*) displayList {
    if(!_displayList && self.rootGroup) {
        _displayList = [[NSMutableArray alloc] init];
        [self updateDisplayList:_displayList withGroup:self.rootGroup];
    }
    
    return _displayList;
}

#pragma mark - selection

- (NSMutableSet*) selected {
    if(!_selected) {
        _selected = [[NSMutableSet alloc] init];
    }
    return _selected;
}

- (NSUInteger) selectionCount {
    return _selected ? _selected.count : 0;
}
- (void) selectGroupElement:(FLZenfolioGroupElement*) groupElement 
                   selected:(BOOL) selected {

    if(selected) {
        [self.selected addObject:[groupElement Id]];
    }
    else {
        [self.selected removeObject:[groupElement Id]];
    }

    if([groupElement isGroupElement]) {
        for(id element in [groupElement Elements]) {
            [self selectGroupElement:element selected:selected];
        }
    }
}                   

- (NSIndexSet*) selectedIndexSet {
    if(!_cachedSelectionSet) {
        _cachedSelectionSet = [[NSMutableIndexSet alloc] init];
        NSUInteger idx = 0;
        for(NSNumber* elementID in self.displayList) {
            if([self.selected containsObject:elementID]) {
                [_cachedSelectionSet addIndex:idx];
            }
            idx++;
        }
    }
    
    return _cachedSelectionSet;
}

- (void) setSelectedIndexSet:(NSIndexSet *)selectedIndexSet {
    [self clearCachedSearchData];
    self.selected = nil;

    [selectedIndexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        id element = [self elementForID:[self.displayList objectAtIndex:idx]];
        [self selectGroupElement:element selected:YES];
    }];
}

- (BOOL) isGroupElementSelected:(FLZenfolioGroupElement*) element {
    return [self.selected containsObject:[element Id]];
}

- (void) toggleSelectionForGroupElement:(FLZenfolioGroupElement*) element {
    [self selectGroupElement:element selected:![self isGroupElementSelected:element]];
}

//- (long long) selectedPhotoBytes {
//	return [[[self selectedPhotoSets] valueForKeyPath:@"@sum.photoBytes"] longLongValue];
//}
//
//- (int) selectedPhotoCount {
//	return [[[self selectedPhotoSets] valueForKeyPath:@"@sum.photoCount"] intValue];
//}

- (NSArray *) selectedPhotoSets {
    NSMutableArray* selectedSets = [[NSMutableArray alloc] init];
//    FLOrderedCollection* elements = self.elements;
//    for(id element in [elements forwardObjectEnumerator]) {
//        if([element isGalleryElement] && [self.selected containsObject:[element Id]]) {
//            [_selectedPhotoSets addObject:element];
//        }
//    }

    for(NSNumber* anId in self.selected) {
        id element = [self elementForID:anId];
        if(![element isGroupElement]) {
            [selectedSets addObject:element];
        }
    }
    
    return selectedSets;
}


#pragma mark - expansion

- (NSMutableSet*) expanded {
    if(!_expanded) {
        _expanded = [[NSMutableSet alloc] init];
    }
    return _expanded;
}

- (void) setElementWasExpanded:(id)element wasExpanded:(BOOL)wasExpanded {
    if(wasExpanded) {
        [self.expanded addObject:[element Id]];
    }
    else {
        [self.expanded removeObject:[element Id]];
    }
}

- (BOOL) elementIsExpanded:(id) element {
    return [element isGroupElement] && [self.expanded containsObject:[element Id]];
}

- (BOOL) expandElement:(id) element expanded:(BOOL) expanded {
    if([element isGroupElement]) {  
        if(expanded) {
            [self.expanded addObject:[element Id]];
        }
        else {
            [self.expanded removeObject:[element Id]];
        }
        
        [self clearCachedSearchData];
    
        [self.delegate groupElementSelection:self setElementExpanded:element isExpanded:expanded];
        
        return expanded;
    }

    return NO;
}

- (void) updateExpansions {
    
    for(NSNumber* elementID in self.displayList) {
        id element = [self elementForID:elementID];
        if([element isGroupElement]) {
            [self.delegate groupElementSelection:self 
                              setElementExpanded:(FLZenfolioGroup*)element 
                                      isExpanded:[self elementIsExpanded:element]];
        }
    }
}

- (void) setAllExpanded:(BOOL) expanded {
    [self clearCachedSearchData];
    
    for(id element in [self.elements forwardObjectEnumerator]) {
        [self expandElement:element expanded:expanded];
    }
}

#pragma mark - filtering

- (void) addToResult:(FLZenfolioGroup*) group
              result:(NSMutableSet*) results {
              
    [results addObject:[group Id]];
    
    for(id element in group.Elements) {
        if([element isGroupElement]) {
            [element addToResult:element result:results];
        }
        else {
           [results addObject:[element Id]];
        }
    }
}

#define TestElement(element,filter) ([[element Title] rangeOfString:filter options:NSCaseInsensitiveSearch].length > 0)

- (BOOL) findMatchesForFilterWithGroup:(FLZenfolioGroup*) group
                                filter:(NSString*) filter 
                               results:(NSMutableSet*) results {
                               
    BOOL foundMatch = NO;
    if(FLStringIsEmpty(filter) || TestElement(group, filter)) {
        [results addObject:[group Id]];
        [group visitAllSubElements:^(FLZenfolioGroupElement *element, BOOL *stop) {
            [results addObject:[element Id]];
        }];
        foundMatch = YES;
    }
    else {
        for(id element in group.Elements) {
            if([element isGroupElement]) {
                if([self findMatchesForFilterWithGroup:element filter:filter results:results]) {
                    foundMatch = YES;
                }
            }
            else if(TestElement(element, filter)) {
                [results addObject:[element Id]];
                foundMatch = YES;
            }
        }
        if(foundMatch) {
            [results addObject:[group Id]];
        }
    }

    return foundMatch;
}


- (BOOL) elementInFilter:(id) element {
    return (!self.filtered || [self.filtered containsObject:[element Id]]);
}

- (void) updateFilterWithString:(NSString *)string {
    [self clearCachedSearchData];
    self.filterString = string;
    
    if(FLStringIsNotEmpty(string)) {
        NSMutableSet* result = [NSMutableSet set];
        
        if(FLStringIsNotEmpty(string)) {
            [self findMatchesForFilterWithGroup:self.rootGroup filter:self.filterString results:result];
        }
        
        NSMutableSet* newSelection = [NSMutableSet set];
        for(NSNumber* elementID in self.selected) {
            if([result containsObject:elementID]) {
                [newSelection addObject:elementID];
            }
        }
        self.selected = newSelection;
        
        self.filtered = result;
    }
    else {
        self.filtered = nil;
    }
}

#pragma mark - misc

- (NSString*) description {
    return [NSString stringWithFormat:@"Group Element Selection: %@", [self.selected description]];
}

#pragma mark - sorting

- (void) sortWithDescriptor:(NSSortDescriptor*) descriptor {
    [self clearCachedSearchData];
    [self.rootGroup sort:descriptor];
}

@end
