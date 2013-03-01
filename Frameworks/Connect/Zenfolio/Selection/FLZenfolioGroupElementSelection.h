//
//  FLZenfolioGroupElementSelection.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioGroupElement.h"

@interface FLZenfolioGroupElementSelection : NSObject<NSCopying> {
@private
    NSMutableDictionary* _selection;
    NSArray* _selectedPhotoSets;
}
+ (id) groupElementSelection;

@property (readonly, assign, nonatomic) NSUInteger selectionCount;

@property (readonly, strong, nonatomic) NSDictionary* selectedGroupElements;

@property (readonly, strong, nonatomic) NSArray* selectedPhotoSets;

- (NSIndexSet*) indexSetForSelectionsInGroup:(FLZenfolioGroup*) group;
- (void) setSelectionInGroup:(FLZenfolioGroup*) group withIndexSet:(NSIndexSet*) set;

- (void) selectGroupElement:(FLZenfolioGroupElement*) groupElement 
                   selected:(BOOL) selected;

- (BOOL) isGroupElementSelected:(FLZenfolioGroupElement*) element;

- (void) toggleSelectionForGroupElement:(FLZenfolioGroupElement*) element;

// misc utils
- (long long) selectedPhotoBytes;

- (int) selectedPhotoCount;

@end
