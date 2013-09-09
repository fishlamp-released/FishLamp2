//
//  FLEnterItemsContentView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/12/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "FLEditableItemView.h"

@interface FLEditableItemsContainerView : UIView {
@private
    NSMutableDictionary* _items;
}

- (void) setEditableItemView:(FLEditableItemView*) item forKey:(id) key;

- (FLEditableItemView*) editableItemViewForKey:(id) key;

- (BOOL) validateAllItems;

- (void) visitEditableItemViews:(void (^)(FLEditableItemsContainerView* containerView, FLEditableItemView* itemView, BOOL* stop)) visitor;

@end
