//
//	GtButtonbarView.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/19/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtButton.h"
#import "UIImage+GtColorize.h"

#define GtButtonbarViewBackButtonKey @"backButton"

@interface GtButtonbarView : UIView {
@private
	UILabel* m_label;
	UILabel* m_subtitleLabel;
	NSMutableArray* m_leftViews;
	NSMutableArray* m_rightViews;
	struct {
		unsigned int isInitialized: 1;
	} m_navBarFlags;
	
	CGFloat m_leftIndent;
}

@property (readwrite, assign, nonatomic) BOOL backButtonHidden; // animates
- (void) setBackButtonHidden:(BOOL) hidden animated:(BOOL) animated;

@property (readonly, retain, nonatomic) GtButton* backButton;
@property (readwrite, assign, nonatomic) CGFloat leftIndent;
@property (readwrite, retain, nonatomic) NSString* title;
@property (readonly, retain, nonatomic) UILabel* titleLabel;
@property (readwrite, assign, nonatomic) BOOL isInitialized; // for you to set in your app logic.

@property (readwrite, assign, nonatomic) NSString* subtitle;
- (void) setSubtitleWithItemCount:(NSUInteger) itemCount itemName:(NSString*) itemName;

- (void) addBackButton:(NSString*) title target:(id) target action:(SEL) action;

- (void) addViewToRightSide:(UIView*) view forKey:(NSString*) key animated:(BOOL) animated;
- (void) addViewToLeftSide:(UIView*) view forKey:(NSString*) key animated:(BOOL) animated;

//- (void) addImageButtonToRightSide:(UIImage*) image target:(id) target action:(SEL) action forKey:(NSString*) key animated:(BOOL) animated;
//- (void) addImageButtonToLeftSide:(UIImage*) image target:(id) target action:(SEL) action forKey:(NSString*) key animated:(BOOL) animated;

- (void) addButtonToLeftSide:(GtButton*) button forKey:(NSString*) key animated:(BOOL) animated;
- (void) addButtonToRightSide:(GtButton*) button forKey:(NSString*) key animated:(BOOL) animated;

- (void) removeViewForKey:(NSString*) key animated:(BOOL) animated;

- (UIView*) viewForKey:(NSString*) key;
- (void) setView:(UIView*) view forKey:(NSString*)key animated:(BOOL) animated; // replaces 

- (CGRect) rectForButtonWithKey:(NSString*) key forDisplayInView:(UIView*) view;

- (void) disableAllButtons;
- (void) setViewHidden:(BOOL) hidden forKey:(NSString*) key	 animated:(BOOL) animated;
- (void) setViewEnabled:(BOOL) enabled forKey:(NSString*) key; // only if view responds to setEnabled:

+ (UIButton*) createImageButtonByName:(NSString*) imageName target:(id) target action:(SEL) action;
+ (UIButton*) createImageButton:(UIImage*) image target:(id) target action:(SEL) action;
                       
+ (UIView*) createEmptyItem;


@end

