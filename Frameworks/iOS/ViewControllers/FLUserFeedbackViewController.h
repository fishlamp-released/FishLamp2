//
//	FLBetaFeedbackEmail.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLTableViewController.h"
#import "FLEditObjectViewController.h"
#import "FLEmailer.h"

@interface FLUserFeedbackViewController : FLEditObjectViewController<FLEmailerDelegate> {
@private
	NSString* _emailAddress;
	NSArray* _stringArray;
}

@property (readwrite, retain, nonatomic) NSString* emailAddress;
@property (readwrite, retain, nonatomic) NSArray* stringArray;

- (id) init; // loads default nib

+ (FLUserFeedbackViewController*) userFeedbackViewController:(NSString*) emailAddress buttonTitleArray:(NSArray*) buttonTitleArray;

+ (NSArray*) defaultStringArray;

@end
