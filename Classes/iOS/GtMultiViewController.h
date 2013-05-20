//
//  GtMultiViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 12/31/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewController.h"
#import "GtViewLayout.h"
#import "GtOrderedCollection.h"

@class GtViewControllerPlaceholder;

@protocol GtMultiViewControllerDelegate;

@interface GtMultiViewController : GtViewController {
@private
	GtOrderedCollection* m_viewControllers;
    GtViewLayout* m_viewLayout;
}

@property (readwrite, retain, nonatomic) GtViewLayout* viewLayout;

@property (readonly, assign, nonatomic) NSUInteger viewControllerCount;

@property (readonly, retain, nonatomic) GtOrderedCollection* placeholders;

- (GtViewControllerPlaceholder*) placeholderAtIndex:(NSUInteger) idx; 
- (GtViewControllerPlaceholder*) placeholderForKey:(id) key;

- (void) addPlaceholder:(GtViewControllerPlaceholder*) placeholder forKey:(id) key;

// override points

- (void) updateLayout;

// call when scrolling, etc..
- (UIView*) containerView; // returns self.view by default
- (CGRect) containerViewVisibleBounds; // returns self.view.bounds by default;

- (void) updateVisibleViews; 
    // hides and shows visible views.

// normally this is called automatically.
- (void) unloadHiddenControllers;

// override points
- (UIView*) createView;


@end


typedef id (^GtViewControllerFactory)();

@interface GtViewControllerPlaceholder : NSObject {
@private
    CGRect m_frame;
    UIViewController* m_viewController;
    GtViewControllerFactory m_factory;
    NSString* m_title;
    struct {
        unsigned int autoPurgeHiddenViewController : 1;
    } m_flags;
}
@property (readwrite, assign, nonatomic) CGRect frame;
@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, assign, nonatomic) BOOL autoPurgeHiddenViewController;
@property (readwrite, copy, nonatomic) GtViewControllerFactory viewControllerFactory;
@property (readwrite, retain, nonatomic) UIViewController* viewController;

@property (readonly, assign, nonatomic) BOOL viewControllerIsActive;

- (id) initWithViewControllerFactory:(GtViewControllerFactory) factory title:(NSString*) title;

+ (GtViewControllerPlaceholder*) viewControllerPlaceholder:(GtViewControllerFactory) viewController title:(NSString*) title;

- (void) purgeViewController;
- (void) createViewControllerIfNeededInViewController:(UIViewController*) inViewController;

@end

@interface GtSelectableViewControllerMultiViewController : GtMultiViewController {
@private
    NSUInteger m_selectedIndex;
}

@property (readonly, retain, nonatomic) GtViewControllerPlaceholder* selectedViewControllerPlaceholder; 
@property (readonly, assign, nonatomic) NSUInteger selectedIndex;
- (void) setSelectedIndex:(NSUInteger) selectedIndex animate:(BOOL) animate;
- (void) didSelectViewController:(GtViewControllerPlaceholder*) viewController  animate:(BOOL) animate;
- (void) didUnselectViewController:(GtViewControllerPlaceholder*) viewController  animate:(BOOL) animate;

@end