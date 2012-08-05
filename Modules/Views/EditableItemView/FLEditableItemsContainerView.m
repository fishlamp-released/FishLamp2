//
//  FLEnterItemsContentView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/12/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLEditableItemsContainerView.h"
#import "FLVerticalGridArrangement.h"
#import "FLArrangement.h"

@implementation FLEditableItemsContainerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _items = [[NSMutableDictionary alloc] init];

        self.backgroundColor = [UIColor clearColor];
        self.autoresizesSubviews = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    
        self.subviewArrangement = [FLVerticalGridArrangement verticalGridArrangement:44 columnCount:1];
    }
    return self;
}

- (void) setEditableItemView:(FLEditableItemView*) newItem  forKey:(id) key {
   
    FLEditableItemView* view = [_items objectForKey:key];
    if(view) {
        [view removeFromSuperview];
    }
     
    [_items setObject:newItem forKey:key];

    CGFloat width = 0;
    for(FLEditableItemView* item in _items.objectEnumerator) {
        width = MAX([item calculateLabelWidth], width);
    }
    for(FLEditableItemView* item in _items.objectEnumerator) {
        item.label.frame = FLRectSetWidth(item.frame, width);
    }
    
    [self addSubview:newItem];
    [self setNeedsLayout];
}

- (FLEditableItemView*) editableItemViewForKey:(NSString*) key {
    return [_items objectForKey:key];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self.subviewArrangement performArrangement:self.subviews inBounds:self.bounds];
}

- (CGSize) sizeThatFits:(CGSize)size {

    CGRect bounds = self.bounds; 
    bounds.size.width = size.width;

    return [self.subviewArrangement performArrangement:self.subviews inBounds:bounds];
}

- (BOOL) validateAllItems {
    
    __block BOOL valid = YES;
    [self visitEditableItemViews:^(FLEditableItemsContainerView* containerView, FLEditableItemView* itemView, BOOL* stop) {
        
        [itemView validateSelf];
        
        if(!itemView.isValidated) {
            valid = NO;
        }
    }];
    
    return valid;
}

- (void) visitEditableItemViews:(void (^)(FLEditableItemsContainerView* containerView, FLEditableItemView* itemView, BOOL* stop)) visitor {

    for(FLEditableItemView* item in _items.objectEnumerator) {
        BOOL stop = NO;
        visitor(self, item, &stop);
        if(stop) {
            break;
        }
    }
} 


@end
