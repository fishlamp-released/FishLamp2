//
//	GtChooseFromTextListViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtTableViewController.h"

@interface GtStringChooserViewController : GtTableViewController {
@private
	NSArray* m_stringList;
	IBOutlet UIToolbar* m_toolbar;
	IBOutlet UIBarButtonItem* m_chooseButton;
	NSString* m_initialSelection;
	NSString* m_chosenString;
	GtCallbackObject* m_chosenCallback;
}

@property (readwrite, retain, nonatomic) GtCallbackObject* didChooseStringCallback;

@property (readonly, retain, nonatomic) NSString* chosenString; 

- (id) initWithStringList:(NSArray*) stringList selectedString:(NSString*) selectedString;

+ (GtStringChooserViewController*) stringChooserViewController:(NSArray*) stringList selectedString:(NSString*) selectedString;

- (IBAction) chooseButtonWasPressed:(id) sender;
@end

