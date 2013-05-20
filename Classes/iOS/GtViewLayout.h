//
//  GtViewLayout.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define UIEdgeInsets10 UIEdgeInsetsMake(10,10,10,10)
#define UIEdgeInsets1 UIEdgeInsetsMake(1,1,1,1)

@class GtViewLayout;

typedef void (^GtViewVisitor)(id view);

typedef enum {
	GtViewLayoutResizeMaskNone			 = 0,
	GtViewLayoutResizeMaskFlexibleWidth	 = (1 << 1),
    GtViewLayoutResizeMaskFlexibleHeight = (1 << 2) 
//	, GtViewLayoutBehaviorAdjustToSubviewHeightAfterLayout = (1 << 3)
} GtViewLayoutResizeMask;

@interface GtViewLayoutBehavior : NSObject {
@private
    GtViewLayoutResizeMask m_resizeMask;
    UIEdgeInsets m_margins;
}
+ (GtViewLayoutBehavior*) viewLayoutBehavior;

@property (readwrite, assign, nonatomic) UIEdgeInsets margins; // deltas
@property (readwrite, assign, nonatomic) GtViewLayoutResizeMask resizeMask;
@end

typedef struct  {
    CGSize size;
    unsigned int flexibleWidth : 1;
    unsigned int flexibleHeight : 1;
} GtArrangeableViewHint;

// these are added at runtime 

@protocol GtArrangeableView <NSObject>
@property (readwrite, assign, nonatomic) CGRect frame;
@end

@protocol GtArrangeableViewContainer <GtArrangeableView>
@property (readwrite, assign, nonatomic) CGRect bounds;
@property (readonly, retain, nonatomic) NSArray* subviews;
@end

@interface NSObject (GtViewLayout)
// Important: objects operated on by a view layout are expected to implement methods in
// the GtArrangeableView protocol but don't have to implement the protocol directly, for example, UIViews.

@property (readwrite, retain, nonatomic) GtViewLayout* viewLayout;
@property (readwrite, retain, nonatomic) GtViewLayoutBehavior* viewLayoutBehavior;
- (CGSize) calculateSizeForLayout:(GtArrangeableViewHint) hint;

- (void) layoutSubviewsWithViewLayout;

@end

@interface GtViewLayout : NSObject {
@private
	UIEdgeInsets m_padding;
	UIEdgeInsets m_viewMargins;
}

+ (id) viewLayout;

@property (readwrite, assign, nonatomic) UIEdgeInsets padding;
@property (readwrite, assign, nonatomic) UIEdgeInsets viewMargins;

// override point. Returns size of new bounds - can be same size as input bounds.
- (CGSize) layoutArrangeableViews:(NSArray*) arrayOfArrangeableViews // each item must implement methods in GtArrangeableView
                         inBounds:(CGRect) bounds;

// for subclasses.
- (UIEdgeInsets) adjustedMarginsForView:(id) view;

@end

/*
	GtRowViewLayout
	1. this stacks the view top to bottom (back to front in subviewList)
	2. makes each view as wide as parent view (minus padding and margins)
	3. setViewSize sets height of view to bottom of last view + padding + margins
*/ 

@interface GtRowViewLayout : GtViewLayout {}
+ (GtRowViewLayout*) rowViewLayout;
@end

/*
	GtRowViewLayout (this is really best with one subview)
	1. this fills all subviews to fit in super view
	2. setViewSize does nothing.
*/ 
@interface GtFillInSuperviewViewLayout : GtViewLayout {}
@end

@interface GtColumnViewLayout : GtViewLayout {}
+ (GtColumnViewLayout*) columnViewLayout;
@end


