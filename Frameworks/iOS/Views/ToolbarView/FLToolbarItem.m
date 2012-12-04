//
//  FLToolbarItem.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLToolbarItem.h"
#import "FLToolbarView.h"

@implementation FLToolbarItem 

@synthesize parentToolbar = _toolbar;
@synthesize minSize = _minSize;
@synthesize onChosen = _onChosen;
@synthesize view = _view;
@synthesize horizontalPadding = _horizontalPadding;
@synthesize viewAlignment = _viewAlignment;

- (id) init {
    if((self = [super init])) {
        self.horizontalPadding = kDefaultHorizontalPadding;
    }
    return self;
}

- (id) initWithView:(id) aView onChosenBlock:(FLToolbarViewBlock) onChosenBlock {
    if((self = [super init])) {
        self.view = aView;
        self.onChosen = onChosenBlock;
    }
    
    return self;
}

- (void) setSubviewSize:(FLSize) size {
}

- (FLSize) subviewSizeThatFitsInBounds:(FLRect) bounds {
    return CGSizeZero;
}

- (FLSize) sizeThatFitsInBounds:(FLRect) bounds {
    FLSize size = [self subviewSizeThatFitsInBounds:bounds];
    size.width += self.horizontalPadding;
    size.height = bounds.size.height;
    return size;
}

- (void) updateSizeInBounds:(FLRect) bounds {

    FLSize subviewSize = [self subviewSizeThatFitsInBounds:bounds];
    
    FLRect frame = self.frame;
    frame.size = subviewSize;
    frame.size.width += self.horizontalPadding;
    frame.size.height = bounds.size.height;
    self.frame = frame;

    [self setSubviewSize:subviewSize];
}

- (void) updateLayout {

    if(self.view) {

        FLRect viewFrame = FLRectCenterRectInRectVertically(self.frame, [self.view frame]);
            
        switch(self.viewAlignment) {
            case FLToolbarItemAlignmentNone:
                break;
        
            case FLToolbarItemAlignmentCenter:
                    viewFrame = FLRectCenterRectInRect(self.frame, viewFrame);
                break;
            case FLToolbarItemAlignmentRight:
                    viewFrame = FLRectJustifyRectInRectRight(self.frame, viewFrame);
                break;
            case FLToolbarItemAlignmentLeft:
                    viewFrame = FLRectJustifyRectInRectLeft(self.frame, viewFrame);
                break;
        }
            
        [self.view setFrame:FLRectOptimizedForViewLocation(viewFrame)];
    }
}

- (void) wasAddedToToolbarView:(FLToolbarView*) view {
    _toolbar = view;
}

- (void) wasRemovedFromToolbarView:(FLToolbarView*) view {
    _toolbar = nil;
}

- (void) drawRect:(FLRect) rect {
}

- (void) toolbarTitleDidChange:(NSString*) title {
}

@end

