//
//  FLZenfolioGroupElementSelection.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioGroupElementSelection.h"


@implementation FLZenfolioPhoto (Selection)
- (void) addSelectionsToIndexedSet:(NSMutableIndexSet*) set 
                     fromSelection:(FLZenfolioGroupElementSelection*) selection 
                     currentIndex:(NSUInteger*) currentIndex {
}
@end


@implementation FLZenfolioGroupElement (Selection)

- (void) addSelectionsToIndexedSet:(NSMutableIndexSet*) set 
                     fromSelection:(FLZenfolioGroupElementSelection*) selection 
                     currentIndex:(NSUInteger*) currentIndex {
    
    if([selection isGroupElementSelected:self]) {
        [set addIndex:*currentIndex];
    }
    
    ++(*currentIndex);
    
    for(FLZenfolioGroupElement* element in self.Elements) {
        [element addSelectionsToIndexedSet:set fromSelection:selection currentIndex:currentIndex];
    }
}     

@end

@implementation FLZenfolioGroup (Selection) 

- (NSIndexSet*) indexSetForSelection:(FLZenfolioGroupElementSelection*) selection {
    NSMutableIndexSet* set = [NSMutableIndexSet indexSet];
    NSUInteger index = 0;
    [self addSelectionsToIndexedSet:set fromSelection:selection currentIndex:&index];
    return set;
}

@end

@interface FLZenfolioGroupElementSelection()
@property (readwrite, strong, nonatomic) NSArray* selectedPhotoSets;
@property (readwrite, strong, nonatomic) NSIndexSet* cachedSet;
@end

@implementation FLZenfolioGroupElementSelection {
@private
    NSMutableDictionary* _selection;
    NSArray* _selectedPhotoSets;
    NSIndexSet* _cachedSet;
}
@synthesize cachedSet = _cachedSet;
@synthesize selectedGroupElements = _selectedGroupElements;
@synthesize selectedPhotoSets = _selectedPhotoSets;

- (id) init {
    self = [super init];
    if(self) {
        _selection = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_selection release];
    [_cachedSet release];
    [_selectedPhotoSets release];
    [super dealloc];
}
#endif

+ (id) groupElementSelection {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSIndexSet*) indexSetForSelectionsInGroup:(FLZenfolioGroup*) group {
    if(!self.cachedSet) {
        self.cachedSet = [group indexSetForSelection:self];
    }
    return self.cachedSet;
}

- (void) setSelectionInGroup:(FLZenfolioGroup*) group withIndexSet:(NSIndexSet*) set {
    self.cachedSet = nil;
    self.selectedPhotoSets = nil;
    
    [_selection removeAllObjects];
    
    [group visitAllElements:^(FLZenfolioGroupElement* element, NSUInteger idx, BOOL* stop) {
        if([set containsIndex:idx]) {
            [self selectGroupElement:element selected:YES];
        }
    }];
}

- (NSUInteger) selectionCount {
    return _selection.count;
}

- (void) selectGroupElement:(FLZenfolioGroupElement*) groupElement 
                   selected:(BOOL) selected {
                        
    if(selected) {
        [_selection setObject:groupElement forKey:groupElement.Id];
    }
    else {
        [_selection removeObjectForKey:groupElement.Id];
    }

    if([groupElement isGroupElement]) {
        for(id element in [groupElement Elements]) {
            [self selectGroupElement:element selected:selected];
        }
    }

// reset cache of selected photo sets.    
    self.selectedPhotoSets = nil;
    self.cachedSet = nil;
}

- (BOOL) isGroupElementSelected:(FLZenfolioGroupElement*) element {
    return [_selection objectForKey:element.Id] != nil;
}

- (void) toggleSelectionForGroupElement:(FLZenfolioGroupElement*) element {
    [self selectGroupElement:element selected:![self isGroupElementSelected:element]];
}

- (long long) selectedPhotoBytes {
	return [[[self selectedPhotoSets] valueForKeyPath:@"@sum.photoBytes"] longLongValue];
}

- (int) selectedPhotoCount {
	return [[[self selectedPhotoSets] valueForKeyPath:@"@sum.photoCount"] intValue];
}

- (void) clearCachedSearchData {
    self.selectedPhotoSets = nil;
    self.cachedSet = nil;
}

- (NSArray *) selectedPhotoSets {
    if(!_selectedPhotoSets) {
        NSMutableArray *selectedSets = [NSMutableArray array];
        
        for(id element in [_selection objectEnumerator]) {
            if([element isGroupElement]) {
                [element visitAllElements:^(FLZenfolioGroupElement* subElement, NSUInteger idx, BOOL* stop) {
                    if(!subElement.isGroupElement) {
                        [selectedSets addObject:subElement];
                    }
                }];
            }
            else {
                [selectedSets addObject:element];
            }
        }
        self.selectedPhotoSets = selectedSets;
    }
	return _selectedPhotoSets;
}

- (id) initWithSelection:(NSDictionary*) selection {
    self = [super init];
    if(self) {
        _selection = [selection mutableCopy];
    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone {
    return [[FLZenfolioGroupElementSelection alloc] initWithSelection:_selection];
}

- (NSString*) description {
    return [NSString stringWithFormat:@"Group Element Selection: %@", [_selection description]];
}

@end
