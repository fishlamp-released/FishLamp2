//
//	FLDeprecatedButtonbarView.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/19/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FLLegacyButton.h"

#import "FLToolbarItem.h"


// THIS IS DEPRECATED

#define FLButtonbarViewBackButtonKey @"backButton"


@interface FLDeprecatedButtonbarView : UIView 

@property (readwrite, assign, nonatomic) BOOL automaticallyShowBackButton; // defaults to NO

@property (readwrite, assign, nonatomic) BOOL backButtonHidden; // animates
- (void) setBackButtonHidden:(BOOL) hidden animated:(BOOL) animated;

@property (readonly, retain, nonatomic) FLLegacyButton* backButton;
@property (readwrite, assign, nonatomic) CGFloat leftIndent;
@property (readwrite, retain, nonatomic) NSString* title;
@property (readonly, retain, nonatomic) UILabel* titleLabel;
@property (readwrite, assign, nonatomic) BOOL isInitialized; // for you to set in your app logic.

@property (readwrite, assign, nonatomic) NSString* subtitle;
- (void) setSubtitleWithItemCount:(NSUInteger) itemCount actionItemName:(NSString*) actionItemName;

- (void) addBackButton:(NSString*) title target:(id) target action:(SEL) action;

- (void) addViewToRightSide:(UIView*) view forKey:(NSString*) key animated:(BOOL) animated;
- (void) addViewToLeftSide:(UIView*) view forKey:(NSString*) key animated:(BOOL) animated;

- (void) addButtonToLeftSide:(FLLegacyButton*) button forKey:(NSString*) key animated:(BOOL) animated;
- (void) addButtonToRightSide:(FLLegacyButton*) button forKey:(NSString*) key animated:(BOOL) animated;

- (void) removeViewForKey:(NSString*) key animated:(BOOL) animated;

- (UIView*) viewForKey:(NSString*) key;
- (void) setView:(UIView*) view forKey:(NSString*)key animated:(BOOL) animated; // replaces 

- (CGRect) rectForButtonWithKey:(NSString*) key forDisplayInView:(UIView*) view;

- (void) disableAllButtons;
- (void) setViewHidden:(BOOL) hidden forKey:(NSString*) key	 animated:(BOOL) animated;
- (void) setViewEnabled:(BOOL) enabled forKey:(NSString*) key; // only if view responds to setEnabled:

+ (UIButton*) createImageButton:(UIImage*) image 
                               target:(id) target 
                               action:(SEL) action;

+ (UIButton*) createImageButtonByName:(NSString*) imageName 
                           imageColor:(NSUInteger) colorOfImageInFile // FLImageColor
                               target:(id) target 
                               action:(SEL) action;

+ (UIView*) createEmptyItem;

+ (void) createTopToolbarForViewController:(UIViewController*) viewController;

- (void) addBackgroundGradientView;

@end
