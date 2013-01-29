//
//  ZFGroupElementSelection.h
//  ZenLib
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFGroupElementSelection : NSObject {
@private
    NSMutableSet* _selected;
}

- (void) setGroupElementSelected:(ZFGroupElement*) element 
                        selected:(BOOL) selected;
                        
- (BOOL) isGroupElementSelected:(ZFGroupElement*) element;

- (void) toggleSelectionForGroupElement:(ZFGroupElement*) element;

- (NSIndexSet*) indexSetForSelectionsInGroup:(ZFGroup*) group;

@end

@interface ZFGroupElement (Selection)
- (NSArray *)selectedPhotoSets:(ZFGroupElementSelection*) selection;
- (long long) selectedPhotoBytes:(ZFGroupElementSelection*) selection;
- (int) selectedPhotoCount:(ZFGroupElementSelection*) selection;
- (ZFGroupElement*) elementAtIndex:(NSInteger) index;
@end