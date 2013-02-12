//
//  FLZenfolioGroupElementSelection.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioGroupElement.h"

@interface FLZenfolioGroupElementSelection : NSObject {
@private
    NSMutableDictionary* _selection;
    NSArray* _selectedPhotoSets;
}

@property (readonly, strong, nonatomic) NSDictionary* selectedGroupElements;

@property (readonly, strong, nonatomic) NSArray* selectedPhotoSets;

- (NSIndexSet*) indexSetForSelectionsInGroup:(FLZenfolioGroup*) group;

- (void) selectGroupElement:(FLZenfolioGroupElement*) groupElement 
                   selected:(BOOL) selected;

- (BOOL) isGroupElementSelected:(FLZenfolioGroupElement*) element;

- (void) toggleSelectionForGroupElement:(FLZenfolioGroupElement*) element;

- (long long) selectedPhotoBytes;

- (int) selectedPhotoCount;

@end
