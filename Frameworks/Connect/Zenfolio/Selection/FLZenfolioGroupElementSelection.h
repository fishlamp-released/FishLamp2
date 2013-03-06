//
//  FLZenfolioGroupElementSelection.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioGroupElement.h"

@interface FLZenfolioGroupElementSelection : NSObject<NSCopying> 
+ (id) groupElementSelection;

@property (readonly, assign, nonatomic) NSUInteger selectionCount;

@property (readonly, strong, nonatomic) NSDictionary* selectedGroupElements;

@property (readonly, strong, nonatomic) NSArray* selectedPhotoSets;

/// get/set selection with dictionary of indexes.
/// this is weird, since we're essentially a tree, but we need it to work
/// with the NSOutlineView
- (NSIndexSet*) indexSetForSelectionsInGroup:(FLZenfolioGroup*) group;
- (void) setSelectionInGroup:(FLZenfolioGroup*) group withIndexSet:(NSIndexSet*) set;

/// select/unselect a groupElement
- (void) selectGroupElement:(FLZenfolioGroupElement*) groupElement 
                   selected:(BOOL) selected;

- (BOOL) isGroupElementSelected:(FLZenfolioGroupElement*) element;

- (void) toggleSelectionForGroupElement:(FLZenfolioGroupElement*) element;

// misc utils
- (void) removeSelectedElementsNotInFilter:(NSDictionary*) filter;

//- (long long) selectedPhotoBytes;

- (int) selectedPhotoCount;

- (void) clearCachedSearchData;

@end
