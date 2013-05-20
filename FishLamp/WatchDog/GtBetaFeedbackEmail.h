//
//  GtBetaFeedbackEmail.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "GtViewAnimator.h"

@interface GtBetaFeedbackEmail : UIViewController<UITableViewDelegate, UITableViewDataSource> {
@private
    IBOutlet UITableView* m_tableView;
    IBOutlet UIToolbar* m_toolbar;
	NSString* m_emailAddress;
    NSArray* m_stringArray;
    IBOutlet UILabel* m_titleLabel;
    GtViewAnimator* m_viewAnimator;
}

@property (readwrite, assign, nonatomic) id<GtViewAnimatorProtocol> viewAnimator;
@property (readwrite, assign, nonatomic) NSString* viewTitle;
@property (readwrite, assign, nonatomic) NSString* emailAddress;
@property (readwrite, assign, nonatomic) NSArray* stringArray;

- (id) init; // loads default nib
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil; // use your own nib

- (void) show:(UIView*) superview;

- (IBAction) cancelTap:(id) sender;

/*
+ (void) show:(UIView*) superview  
    emailAddress:(NSString*) emailAddress
    title:(NSString*) optionalTitle
    stringArray:(NSArray*) optionalStringArray;
*/
    
+ (NSArray*) defaultStringArray;

@end
       