//
//	FLPasswordEntryViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/19/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLEditObjectViewController.h"

typedef enum {
	FLPasswordEntryViewControllerOptionNone,
	FLPasswordEntryViewControllerOptionPasswordRequired = (1 << 1),
	FLPasswordEntryViewControllerOptionConfirmationRequired = (1 << 1),
} FLPasswordEntryViewControllerOptionMask;

@interface FLPasswordEntryViewController : FLEditObjectViewController {
@private
	FLPasswordEntryViewControllerOptionMask _options;
	NSString* _prompt;
}

- (id) initWithPrompt:(NSString*) prompt withOptions:(FLPasswordEntryViewControllerOptionMask) options;

+ (FLPasswordEntryViewController*) passwordEntryViewController:(NSString*) prompt withOptions:(FLPasswordEntryViewControllerOptionMask) options;

@property (readonly, retain, nonatomic) NSString* password;

@end
