//
//  FLZenfolioGroupElement+Selection.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 1/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioGroupElement.h"

@interface FLZenfolioGroup (Selection)

- (long long) selectedPhotoBytesInSelection:(NSSet*) selection;

- (int) selectedPhotoCountInSelection:(NSSet*) selection;

- (NSArray*) photoSetsInSelection:(NSSet*) selection;

- (FLZenfolioGroupElement*) elementAtIndex:(NSInteger) index;
- (NSIndexSet*) indexSetForSelection:(NSSet*) selection;
@end