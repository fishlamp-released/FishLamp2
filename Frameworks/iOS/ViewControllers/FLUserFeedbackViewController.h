//
//	FLBetaFeedbackEmail.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/13/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
