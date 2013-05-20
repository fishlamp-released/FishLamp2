//
//  GtMenuViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewController.h"
#import "GtMenuView.h"
#import "GtHoverViewController.h"

@interface GtMenuViewController : GtViewController {
@private
    GtMenuView* m_menuView;
}

@property (readonly, retain, nonatomic) GtMenuView* menuView;

- (id) initWithTitle:(NSString*) title;

+ (GtMenuViewController*) menuViewController:(NSString*) title;

- (void) updateLayout;

- (void) addMenuItem:(NSString*) name target:(id) target action:(SEL) action;
- (void) addMenuItem:(NSString*) name submenu:(GtMenuViewController*) submenu;
- (void) addMenuItem:(NSString*) name target:(id) target action:(SEL) action configureMenuItem:(void (^)(GtMenuItemView*)) configureMenuItemBlock;
- (void) addMenuItem:(NSString*) name submenu:(GtMenuViewController*) submenu  configureMenuItem:(void (^)(GtMenuItemView*)) configureMenuItemBlock;

- (void) showFromView:(UIView*) view permittedArrowDirection:(GtHoverViewControllerArrowDirection) direction;

@end
