//
//	GtBetaFeedbackEmail.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/13/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewController.h"
#import "GtEditObjectViewController.h"
#import "GtEmailer.h"

@interface GtUserFeedbackViewController : GtEditObjectViewController<GtEmailerDelegate> {
@private
	NSString* m_emailAddress;
	NSArray* m_stringArray;
}

@property (readwrite, retain, nonatomic) NSString* emailAddress;
@property (readwrite, retain, nonatomic) NSArray* stringArray;

- (id) init; // loads default nib

+ (GtUserFeedbackViewController*) userFeedbackViewController:(NSString*) emailAddress buttonTitleArray:(NSArray*) buttonTitleArray;

+ (NSArray*) defaultStringArray;

@end
