//
//	FLChooseFromTextListViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTableViewController.h"

@interface FLStringChooserViewController : FLTableViewController {
@private
	NSArray* _stringList;
	IBOutlet UIToolbar* _toolbar;
	IBOutlet UIBarButtonItem* _chooseButton;
	NSString* _initialSelection;
	NSString* _chosenString;
	FLCallbackObject* _chosenCallback;
}

@property (readwrite, retain, nonatomic) FLCallbackObject* didChooseStringCallback;

@property (readonly, retain, nonatomic) NSString* chosenString; 

- (id) initWithStringList:(NSArray*) stringList selectedString:(NSString*) selectedString;

+ (FLStringChooserViewController*) stringChooserViewController:(NSArray*) stringList selectedString:(NSString*) selectedString;

- (IBAction) chooseButtonWasPressed:(id) sender;
@end

