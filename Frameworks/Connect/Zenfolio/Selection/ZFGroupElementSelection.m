//
//  ZFGroupElementSelection.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFGroupElementSelection.h"
#import "FLOrderedCollection.h"



@interface ZFGroupElementSelection()
@property (readwrite, strong, nonatomic) NSMutableSet* selectedPhotoSets;
@property (readwrite, strong, nonatomic) NSMutableSet* filtered;
@property (readwrite, strong, nonatomic) NSArray* displayList;
@property (readwrite, strong, nonatomic) FLOrderedCollection* elements;
@property (readwrite, strong, nonatomic) NSMutableSet* expanded;
@property (readwrite, strong, nonatomic) NSMutableSet* selected;
@property (readwrite, strong, nonatomic) NSMutableIndexSet* cachedIndexSetForOutlineView;

- (BOOL) elementInFilter:(id) element;


// these are private for now - might promote them if needed
- (void) selectGroupElement:(ZFGroupElement*) groupElement 
                   selected:(BOOL) selected;

- (BOOL) isGroupElementSelected:(ZFGroupElement*) element;

- (void) toggleSelectionForGroupElement:(ZFGroupElement*) element;

@property (readonly, strong, nonatomic) ZFGroup* rootGroup;

@end

@implementation ZFGroupElementSelection 

@synthesize expanded = _expanded;
@synthesize filtered = _filtered;
@synthesize filterString = _filterString;
@synthesize selectedPhotoSets = _selectedPhotoSets;
@synthesize rootGroup = _rootGroup;
@synthesize delegate = _delegate;
@synthesize displayList = _displayList;
@synthesize elements = _elements;
@synthesize selected = _selected;
@synthesize cachedIndexSetForOutlineView = _cachedSelectionIndexesForOutlineView;
@synthesize dataSource = _dataSource;


- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}
+ (id) groupElementSelection {
    return FLAutorelease([[[self class] alloc] init]);
}

// the group holds the layout of galleries - it should not hold
// the latest photoSets - that's what the objectStorage is for 
// (and the _elements collection)
- (ZFGroup*) rootGroup {
    return [_dataSource groupElementSelectionGetRootGroup:self];
}

- (id<FLObjectStorage>) objectStorage {
    return [_dataSource groupElementSelectionGetObjectStorage:self];
}

#if FL_MRC
- (void) dealloc {
    [_cachedSelectionIndexesForOutlineView release];
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

- (void) clearSelection {
    self.displayList = nil;
    self.cachedIndexSetForOutlineView = nil;
    self.selected = nil;
    self.selectedPhotoSets = nil;
}

- (void) setRootGroup:(ZFGroup*) rootGroup {

    if(rootGroup != _rootGroup) {
        self.displayList = nil;

        if(!rootGroup || (_rootGroup && _rootGroup.IdValue != rootGroup.IdValue)) {
            [self clearSelection];
            self.filtered = nil;
            self.expanded = nil;
        }
        
        FLSetObjectWithRetain(_rootGroup, rootGroup);
    }
}

#pragma mark - Element list

- (void) updateElementDictionary:(FLOrderedCollection*) dictionary 
                       withGroup:(ZFGroup*) group {

    [dictionary setObject:group forKey:[group Id]];
    for(id subElement in [group Elements]) {
        if([subElement isGroupElement]) {
            [self updateElementDictionary:dictionary withGroup:(ZFGroup *)subElement];
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
}

- (id) childElementForGroup:(ZFGroup*) parent atIndex:(NSUInteger) index {

    if(self.filtered == nil) {
        return [self elementForID:[[[parent Elements] objectAtIndex:index] Id]];
    }
    
    NSInteger idx = -1;
    for(ZFGroupElement* element in parent.Elements) {
        if([self.filtered containsObject:[element Id]]) {
            idx++;
        }
        if(idx == index) {
            return [self elementForID:[element Id]];
        }
    }
    return nil;
}

- (NSUInteger) childCountForGroup:(ZFGroup*) group {

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

- (void) updateDisplayList:(NSMutableArray*) list 
                 withGroup:(ZFGroup*) group {
    
    if( [self elementInFilter:group] ) {
        [list addObject:[group Id]];
    
        if( [self elementIsExpanded:group]) {
            for(id subElement in [group Elements]) {
                if([subElement isGroupElement]) {
                    [self updateDisplayList:list withGroup:(ZFGroup *)subElement];
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

- (NSMutableSet*) selectedPhotoSetIDs {
    return _selectedPhotoSets;
}

- (NSMutableSet*) selectedPhotoSets {
    if(!_selectedPhotoSets) {
        _selectedPhotoSets = [[NSMutableSet alloc] init];
    }
    return _selectedPhotoSets;
}

- (NSUInteger) selectedPhotoSetCount {
    return _selectedPhotoSets ? _selectedPhotoSets.count : 0;
}

- (NSMutableSet*) selected {
    if(!_selected) {
        _selected = [[NSMutableSet alloc] init];
    }
    return _selected;
}

- (NSUInteger) selectionCount {
    return _selected ? _selected.count : 0;
}

- (void) selectGroupElement:(ZFGroupElement*) groupElement 
                   selected:(BOOL) selected {

    NSNumber* theId = groupElement.Id;

    BOOL isGroup = [groupElement isGroupElement];

    if(selected) {
        [self.selected addObject:theId];
        if(!isGroup) {
            [self.selectedPhotoSets addObject:theId];
        }
    }
    else {
        [self.selected removeObject:theId];
        if(!isGroup) {
            [self.selectedPhotoSets removeObject:theId];
        }
    }

    if(isGroup) {
        for(id element in [groupElement Elements]) {
            [self selectGroupElement:element selected:selected];
        }
    }
}                   

- (NSIndexSet*) selectedIndexSet {
    if(!_cachedSelectionIndexesForOutlineView) {
        _cachedSelectionIndexesForOutlineView = [[NSMutableIndexSet alloc] init];
        NSUInteger idx = 0;
        for(NSNumber* elementID in self.displayList) {
            if([self.selected containsObject:elementID]) {
                [_cachedSelectionIndexesForOutlineView addIndex:idx];
            }
            idx++;
        }
    }
    
    return _cachedSelectionIndexesForOutlineView;
}

- (void) setSelectedIndexSet:(NSIndexSet *)selectedIndexSet {
    [self clearSelection];
    [selectedIndexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        id element = [self elementForID:[self.displayList objectAtIndex:idx]];
        [self selectGroupElement:element selected:YES];
    }];
}

- (BOOL) isGroupElementSelected:(ZFGroupElement*) element {
    return [self.selected containsObject:[element Id]];
}

- (void) toggleSelectionForGroupElement:(ZFGroupElement*) element {
    [self selectGroupElement:element selected:![self isGroupElementSelected:element]];
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
        
        [self clearSelection];
    
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
                              setElementExpanded:(ZFGroup*)element 
                                      isExpanded:[self elementIsExpanded:element]];
        }
    }
}

//- (void) expandAll:(ZFGroup*) group expand:(BOOL) expand {
//
//    for(id element in [self.elements forwardObjectEnumerator]) {
//        if([element isGroupElement]) {
//            [self expandAll:element expanded:expand];
//        }
//    }
//    [self expandElement:group expanded:expanded];
//}

- (void) setAllExpanded:(BOOL) expanded {
    [self clearSelection];
    
    for(id element in [self.elements forwardObjectEnumerator]) {
        [self expandElement:element expanded:expanded];
    }
}

#pragma mark - filtering

- (void) addToResult:(ZFGroup*) group
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

- (BOOL) findMatchesForFilterWithGroup:(ZFGroup*) group
                                filter:(NSString*) filter 
                               results:(NSMutableSet*) results {
                               
    BOOL foundMatch = NO;
    if(FLStringIsEmpty(filter) || TestElement(group, filter)) {
        [results addObject:[group Id]];
        [group visitAllSubElements:^(ZFGroupElement *element, BOOL *stop) {
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

- (void) handleFilterChange {
    self.filtered = nil;
    self.displayList = nil;
    self.cachedIndexSetForOutlineView = nil;

    if(FLStringIsNotEmpty(_filterString)) {
        self.filtered = [NSMutableSet set];
        
//        NSSet* previousSelection = FLRetainWithAutorelease(_selected);
//        NSSet* previousPhotoSetSelection = FLRetainWithAutorelease(_selectedPhotoSets);
        [self clearSelection];
        
        [self findMatchesForFilterWithGroup:[self rootGroup] filter:_filterString results:_filtered];
        
//        self.selected = [NSMutableSet set];
//        self.selectedPhotoSets = [NSMutableSet set];
//        
        for(NSNumber* elementID in _filtered) {
        
            id element = [self elementForID:elementID];
            if(TestElement(element, _filterString)) {
                [self selectGroupElement:element selected:YES];
            }
        }


        
//        for(NSNumber* elementID in previousSelection) {
//            if([_filtered containsObject:elementID]) {
//                [_selected addObject:elementID];
//                
//                if([previousPhotoSetSelection containsObject:elementID]) {
//                    [_selectedPhotoSets addObject:elementID];
//                }
//            }
//        }
    }
}

- (void) setFilterString:(NSString*) filter {
    if(FLStringsAreNotEqual(filter, _filterString)) {
        FLSetObjectWithRetain(_filterString, filter);
        [self handleFilterChange];
    }
}


#pragma mark - misc

- (NSString*) description {
    return [NSString stringWithFormat:@"Group Element Selection: %@", [self.selected description]];
}

#pragma mark - sorting

- (void) sortWithDescriptor:(NSSortDescriptor*) descriptor {
    [self clearSelection];
    [self.rootGroup sort:descriptor];
}

@end
