//
//  GtToolbarView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/8/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class GtToolbarView;

typedef enum {
    GtToolbarItemAlignmentLeft,
    GtToolbarItemAlignmentRight,
    GtToolbarItemAlignmentCenter
} GtToolbarItemAlignment;

@interface GtToolbarItem : NSObject {
@private
    CGRect m_frame;
    GtCallback m_callback;
    id m_view;
    struct {
        unsigned int isDisabled: 1;
        unsigned int isHidden: 1;
    } m_state;
}
@property (readwrite, assign, nonatomic) CGRect frame;
@property (readwrite, retain, nonatomic) id view;
@property (readwrite, assign, nonatomic) CGSize minSize;
@property (readwrite, assign, nonatomic, getter=isDisabled) BOOL disabled;
@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden;
@property (readwrite, assign, nonatomic) GtCallback callback;

- (void) wasAddedToToolbarView:(UIView*) view;
- (void) wasRemovedFromToolbarView:(UIView*) view;

- (void) drawRect:(CGRect) rect inToolbarView:(UIView*) view;
- (void) updateLayoutWithAlignment:(GtToolbarItemAlignment) alignment
                            inView:(UIView*) view;
@end

@interface GtToolbarItemGroup : NSObject {
@private
    CGRect m_frame;
    NSMutableArray* m_items;
    GtToolbarView* m_toolbarView;
}
@property (readonly, assign, nonatomic) GtToolbarView* toolbarView;
@property (readwrite, assign, nonatomic) CGRect frame;

- (id) initWithToolbarView:(GtToolbarView*) view;

- (void) addToolbarItem:(GtToolbarItem*) item;
- (void) removeToolbarItem:(GtToolbarItem*) item;
- (void) removeAllToolbarItems;

- (void) drawRect:(CGRect) rect inToolbarView:(GtToolbarView*) view;
- (void) updateLayoutWithAlignment:(GtToolbarItemAlignment) alignment
                            inView:(UIView*) view;

@end

@interface GtToolbarView : UIView {
@private
    GtToolbarItemGroup* m_leftItems;
    GtToolbarItemGroup* m_centerItems;
    GtToolbarItemGroup* m_rightItems;
    UIView* m_backgroundView;
}

- (id) init; // makes a 320x44 bar by default.
+ (GtToolbarView*) toolbarView;

@property (readwrite, retain, nonatomic) UIView* backgroundView;

// these will lazy create the groups
@property (readonly, retain, nonatomic) GtToolbarItemGroup* leftItems;
@property (readonly, retain, nonatomic) GtToolbarItemGroup* rightItems;
@property (readonly, retain, nonatomic) GtToolbarItemGroup* centerItems;

@end


@interface GtToolbarItemView : GtToolbarItem {
}
+ (id) toolbarItemView:(UIView*) view target:(id) target action:(SEL) action;
@end

@interface GtImageButtonToolbarItem : GtToolbarItemView {
}

- (id) initWithImageName:(NSString*) imageName target:(id) target action:(SEL) action;

+ (id) imageButtonToolbarItem:(NSString*) imageName target:(id) target action:(SEL) action;

@end