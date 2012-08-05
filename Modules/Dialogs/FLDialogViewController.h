//
//  FLAbstractAlertViewController.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAutoPositionedViewController.h"

// default contentMode is centered.

/// Dialogs have a title view and a content view below it.
/// Content views can be any kind of view.
@interface FLDialogViewController : FLAutoPositionedViewController {
@private
}


//@property (readonly, strong, nonatomic) id contentViewController;
//
//// override this.
//- (UIViewController*) createContentViewController;
//
//// content view for subclasses 
//- (id) contentViewController;
//- (void) setContentView:(UIView*) contentView;
//
//// buttons
//- (void) addButton:(FLButton*) button;

@end