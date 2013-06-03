//
//  FLMultiViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/31/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLViewController.h"
#import "FLArrangement.h"
#import "FLOrderedCollection.h"

@class FLViewControllerPlaceholder;

@protocol FLMultiViewControllerDelegate;

@interface FLMultiViewController : FLViewController {
@private
	FLOrderedCollection* _viewControllers;
    FLArrangement* _arrangement;
}

@property (readwrite, retain, nonatomic) FLArrangement* arrangement;

@property (readonly, assign, nonatomic) NSUInteger viewControllerCount;

@property (readonly, retain, nonatomic) FLOrderedCollection* placeholders;

- (FLViewControllerPlaceholder*) placeholderAtIndex:(NSUInteger) idx; 
- (FLViewControllerPlaceholder*) placeholderForKey:(id) key;

- (void) addPlaceholder:(FLViewControllerPlaceholder*) placeholder forKey:(id) key;

// override points

- (void) updateLayout;

// call when scrolling, etc..
- (UIView*) containerView; // returns self.view by default
- (CGRect) containerViewVisibleBounds; // returns self.view.bounds by default;

- (void) updateVisibleViews; 
    // hides and shows visible views.

// normally this is called automatically.
- (void) unloadHiddenControllers;
@end

@interface FLViewControllerPlaceholder : NSObject {
@private
    Class _viewControllerClass;
    FLCallback_t _viewControllerFactory;
    CGRect _frame;
    NSString* _title;
    UIViewController* _viewController;
    BOOL _autoPurge;
}

@property (readwrite, assign, nonatomic) FLCallback_t viewControllerFactory;
@property (readwrite, assign, nonatomic) Class viewControllerClass;
@property (readwrite, assign, nonatomic) CGRect frame;
@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, assign, nonatomic) BOOL autoPurgeHiddenViewController;
@property (readwrite, retain, nonatomic) UIViewController* viewController;

@property (readonly, assign, nonatomic) BOOL viewControllerIsActive;

- (id) initWithViewControllerClass:(Class) viewControllerClass title:(NSString*) title;
- (id) initWithViewControllerFactory:(FLCallback_t) viewControllerFactory title:(NSString*) title;

+ (FLViewControllerPlaceholder*) viewControllerPlaceholder:(NSString*) title viewControllerClass:(Class) viewControllerClass;
+ (FLViewControllerPlaceholder*) viewControllerPlaceholder:(NSString*) title viewControllerFactory:(FLCallback_t) factory;

- (void) showViewControllerInSuperView:(UIView*) superview
                      inViewController:(UIViewController*) viewController;
- (void) hideViewController;

- (void) purgeViewController;

@end

@interface FLSelectableViewControllerMultiViewController : FLMultiViewController {
@private
    NSUInteger _selectedIndex;
}

@property (readonly, retain, nonatomic) FLViewControllerPlaceholder* selectedViewControllerPlaceholder; 
@property (readonly, assign, nonatomic) NSUInteger selectedIndex;
- (void) setSelectedIndex:(NSUInteger) selectedIndex animate:(BOOL) animate;
- (void) didSelectViewController:(FLViewControllerPlaceholder*) viewController  animate:(BOOL) animate;
- (void) didUnselectViewController:(FLViewControllerPlaceholder*) viewController  animate:(BOOL) animate;
- (void) selectedIndexDidChange;
@end