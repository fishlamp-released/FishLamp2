//
//	FLToolbar.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/24/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIToolbar (FLExtras)

//- (BOOL) replaceBarButtonItemWithCustomView:(UIBarButtonItem*) oldItem
//	  customView:(UIView*) newView
//	  animated:(BOOL) animated
//	  outNewItem:(UIBarButtonItem**) outNewItem;

- (UIBarButtonItem*) toolbarItemForTag:(NSInteger) tag;
- (BOOL) setToolbarItem:(UIBarButtonItem*) item forTag:(NSInteger) tag animated:(BOOL) animated;

- (void) setAllItemsEnabled:(BOOL) enabled;


@end

@interface UIBarButtonItem (FLExtras);
+ (UIBarButtonItem*) flexibleSpaceBarButtonItem;
+ (UIBarButtonItem*) fixedSpaceBarButtonItem:(CGFloat) width;
+ (UIBarButtonItem*) imageButtonBarButtonItem:(UIImage*) image target:(id) target action:(SEL) action;

@end