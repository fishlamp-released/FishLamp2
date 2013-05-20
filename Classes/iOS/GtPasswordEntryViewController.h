//
//	GtPasswordEntryViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/19/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtEditObjectViewController.h"

typedef enum {
	GtPasswordEntryViewControllerOptionNone,
	GtPasswordEntryViewControllerOptionPasswordRequired = (1 << 1),
	GtPasswordEntryViewControllerOptionConfirmationRequired = (1 << 1),
} GtPasswordEntryViewControllerOptionMask;

@interface GtPasswordEntryViewController : GtEditObjectViewController {
@private
	GtPasswordEntryViewControllerOptionMask m_options;
	NSString* m_prompt;
}

- (id) initWithPrompt:(NSString*) prompt withOptions:(GtPasswordEntryViewControllerOptionMask) options;

+ (GtPasswordEntryViewController*) passwordEntryViewController:(NSString*) prompt withOptions:(GtPasswordEntryViewControllerOptionMask) options;

@property (readonly, retain, nonatomic) NSString* password;

@end
