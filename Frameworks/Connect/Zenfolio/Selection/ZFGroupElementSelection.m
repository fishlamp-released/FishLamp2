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
@property (readwrite, copy, nonatomic) NSSet* selectedPhotoSetIDs; 

- (BOOL) elementInFilter:(id) element;

// these are private for now - might promote them if needed
- (void) selectGroupElement:(ZFGroupElement*) groupElement 
                   selected:(BOOL) selected;

- (BOOL) isGroupElementSelected:(ZFGroupElement*) element;

- (void) toggleSelectionForGroupElement:(ZFGroupElement*) element;
@end

@implementation ZFGroupElementSelection 

@synthesize expanded = _expanded;
@synthesize filtered = _filtered;
@synthesize filterString = _filterString;
@synthesize selectedPhotoSets = _selectedPhotoSets;
@synthesize rootGroup = _rootGroup;
@synthesize displayList = _displayList;
@synthesize elements = _elements;
@synthesize selected = _selected;
@synthesize cachedIndexSetForOutlineView = _cachedSelectionIndexesForOutlineView;
@synthesize objectStorage = _objectStorage;
 
- (id) init {
    return [self initWithPhotoSets:nil];
}

- (id) initWithPhotoSets:(NSSet*) set {
    self = [super init];
    if(self) {
        self.selectedPhotoSetIDs = set;
    }
    return self;
}

+ (id) groupElementSelection:(NSSet*) selectedPhotoSets {
    return FLAutorelease([[[self class] alloc] initWithPhotoSets:selectedPhotoSets]);
}

- (void) setRootGroup:(ZFGroup*) group {
    if(_rootGroup != group) {
        self.displayList = nil;
        FLSetObjectWithRetain(_rootGroup, group);
        
        if(_sortDescriptor) {
            [_rootGroup sort:_sortDescriptor];
        }
    }
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
    [_objectStorage release];
    [_displayList release];
    [_sortDescriptor release];
    [super dealloc];
}
#endif

- (void) resetDisplayList {
#if DEBUG
    if(_displayList) {
        FLLog(@"reset display list");
    }
#endif
    
    self.displayList = nil;
    self.cachedIndexSetForOutlineView = nil;
    
}

- (void) clearSelection {
#if DEBUG
    if(_selected) {
        FLLog(@"cleared selection");
    }
#endif

    self.cachedIndexSetForOutlineView = nil;
    self.selected = nil;
    self.selectedPhotoSets = nil;
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

- (void) didReplaceElement:(id) object atIndex:(NSUInteger) index withElement:(id) element {

}

- (void) replaceGroupElement:(id) element { 

    [self.objectStorage writeObject:element];
    
    NSUInteger idx = [self.elements indexForKey:[element Id]];
    FLAssert(idx != NSNotFound);
    
    if(idx != NSNotFound) {
        id previousObject = FLRetainWithAutorelease([self.elements objectAtIndex:idx]);
        [self.elements replaceObjectAtIndex:idx withObject:element forKey:[element Id]];
        [self didReplaceElement:previousObject atIndex:idx withElement:element];
    }
    
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
    
        if([self.selected containsObject:[group Id]]) {
            [self.cachedIndexSetForOutlineView addIndex:list.count - 1];
        }    
    
        if( [self elementIsExpanded:group]) {
            for(id subElement in [group Elements]) {
                if([subElement isGroupElement]) {
                    [self updateDisplayList:list withGroup:(ZFGroup *)subElement];
                }
                else if([self elementInFilter:subElement]) {
                    [list addObject:[subElement Id]];
                    if([self.selected containsObject:[subElement Id]]) {
                        [self.cachedIndexSetForOutlineView addIndex:list.count - 1];
                    }    
                }
            }
        }
    }
}

- (NSArray*) displayList {
    if(!_displayList && self.rootGroup) {
        self.cachedIndexSetForOutlineView = [NSMutableIndexSet indexSet];
        self.displayList = [NSMutableArray array];
        [self updateDisplayList:_displayList withGroup:self.rootGroup];
        
        FLLog(@"rebuilt display list (and selected index set)");
    }
    
    return _displayList;
}

#pragma mark - selection

- (NSSet*) selectedPhotoSetIDs {
    return _selectedPhotoSets;
}

-(void) setSelectedPhotoSetIDs:(NSSet*) set {
    self.selectedPhotoSets = FLAutorelease([set mutableCopy]);
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

    if(!_displayList) {
        [self displayList]; // this rebuilds both display list and index set
    }

    if(!_cachedSelectionIndexesForOutlineView) {
        _cachedSelectionIndexesForOutlineView = [[NSMutableIndexSet alloc] init];
        NSUInteger idx = 0;
        for(NSNumber* elementID in self.displayList) {
            if([self.selected containsObject:elementID]) {
                [_cachedSelectionIndexesForOutlineView addIndex:idx];
            }
            idx++;
        }
        
        FLLog(@"rebuilt selected index set");
    }
    
    return _cachedSelectionIndexesForOutlineView;
}

- (void) setSelectedIndexSet:(NSIndexSet *)selectedIndexSet {
    [self clearSelection];
    [selectedIndexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        id object = [self.displayList objectAtIndex:idx];
        FLAssertNotNil(object);
    
        id element = [self elementForID:object];
        FLAssertNotNil(element);
    
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

- (BOOL) expandElementWithID:(NSNumber*) elementID expanded:(BOOL) expanded {
    return [self expandElement:[self elementForID:elementID] expanded:expanded];
}

- (void) didExpandGroup:(ZFGroup*) group 
             isExpanded:(BOOL) isExpanded {
             
}

- (BOOL) expandElement:(id) element expanded:(BOOL) expanded {
    if([element isGroupElement]) {  
        if(expanded) {
            [self.expanded addObject:[element Id]];
        }
        else {
            [self.expanded removeObject:[element Id]];
        }
        
        [self resetDisplayList];
        [self didExpandGroup:element isExpanded:expanded];
        return expanded;
    }

    return NO;
}

- (void) updateExpansions {
    
    for(NSNumber* elementID in self.displayList) {
        id element = [self elementForID:elementID];
        if([element isGroupElement]) {
            [self didExpandGroup:element isExpanded:[self elementIsExpanded:element]];
        }
    }
}

- (void) setAllExpanded:(BOOL) expanded {
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

- (void) didChangeFilter {
    self.filtered = nil;
    self.displayList = nil;
    self.cachedIndexSetForOutlineView = nil;

    if(FLStringIsNotEmpty(_filterString)) {
        self.filtered = [NSMutableSet set];
        [self clearSelection];
        
        [self resetDisplayList];
        
        [self findMatchesForFilterWithGroup:[self rootGroup] filter:_filterString results:_filtered];
        
        for(NSNumber* elementID in _filtered) {
        
            id element = [self elementForID:elementID];
            if(TestElement(element, _filterString)) {
                [self selectGroupElement:element selected:YES];
            }
        }
    }
    
    [self updateExpansions];
}

- (void) setFilterString:(NSString*) filter {
    if(FLStringsAreNotEqual(filter, _filterString)) {
        FLSetObjectWithRetain(_filterString, filter);
        [self didChangeFilter];
    }
}



#pragma mark - misc

- (NSString*) description {
    return [NSString stringWithFormat:@"Group Element Selection: %@", [self.selected description]];
}

#pragma mark - sorting

- (void) sortWithDescriptor:(NSSortDescriptor*) descriptor {
    [self resetDisplayList];
    [self.rootGroup sort:descriptor];
    FLSetObjectWithRetain(_sortDescriptor, descriptor);
}

@end



